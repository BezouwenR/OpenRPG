#ifndef RPG_SQL_RUNTIME_H
#define RPG_SQL_RUNTIME_H

// ODBC SQL runtime support for RPG-generated C++ programs
// Only included when the RPG source contains EXEC SQL statements

#ifdef _WIN32
#  define WIN32_LEAN_AND_MEAN
#  include <windows.h>
#endif
#include <sql.h>
#include <sqlext.h>
#ifdef _WIN32
// RPG names a field IN, OUT, DELETE or CONST freely (IBM i reserves none
// of them), and the program is C++ that names it the same. <windows.h>
// defines these as macros, which would silently rewrite such a name.
// Nothing below uses them.
#  undef IN
#  undef OUT
#  undef OPTIONAL
#  undef DELETE
#  undef CONST
#  undef ERROR
#endif
#include <cstdint>
#include <cstring>
#include <iostream>
#include <map>
#include <stdexcept>
#include <deque>
#include <string>
#include <vector>

class RpgSqlEnv {
public:
    SQLHENV henv = SQL_NULL_HENV;
    SQLHDBC hdbc = SQL_NULL_HDBC;
    int sqlcode = 0;
    std::string sqlstate = "00000";
    SQLLEN row_count = 0; // last statement's row count (for GET DIAGNOSTICS)
    // The driver's message for the last statement that failed or warned:
    // GET DIAGNOSTICS ... MESSAGE_TEXT, and SQLERRMC in the SQLCA.
    std::string message;

    // SQLERRMC is CHAR(70) and SQLERML its length, as in the SQLCA.
    std::string sqlerrmc() const {
        std::string m = message.substr(0, 70);
        m.resize(70, ' ');
        return m;
    }
    int sqlerml() const { return static_cast<int>(std::min<size_t>(message.size(), 70)); }
    // DB2_MESSAGE_ID: SQL0204 for SQLCODE -204, as on IBM i.
    std::string messageId() const {
        if (sqlcode == 0) return "";
        std::string n = std::to_string(sqlcode < 0 ? -sqlcode : sqlcode);
        if (n.size() < 4) n = std::string(4 - n.size(), '0') + n;
        return (n.size() > 4 ? "SQ" : "SQL") + n;
    }

    // The SQLCODE Db2 for i gives for an SQLSTATE, so error handling
    // written for IBM i (IF SQLCODE = -803) works whatever the database.
    // An SQLSTATE not listed keeps the driver's native code, or -1.
    static int db2Sqlcode(const std::string& state, int native) {
        static const std::map<std::string, int> codes = {
            {"42P01", -204}, {"42S02", -204}, {"42704", -204},   // object not found
            {"42703", -206}, {"42S22", -206},                    // column not found
            {"23505", -803}, {"23000", -803},                    // duplicate key
            {"23502", -407},                                     // NULL into NOT NULL
            {"23503", -530},                                     // foreign key
            {"23514", -545},                                     // check constraint
            {"42601", -104}, {"42000", -104},                    // syntax error
            {"42883", -440},                                     // no such function
            {"42804", -401}, {"42846", -461},                    // incompatible types
            {"22001", -302},                                     // value too long
            {"22003", -406},                                     // numeric out of range
            {"22007", -181}, {"22008", -181},                    // bad date/time value
            {"22012", -802},                                     // division by zero
            {"22018", -420},                                     // bad character for a number
            {"22002", -305},                                     // NULL, no indicator
            {"21000", -811},                                     // more than one row
            {"24000", -501},                                     // cursor not open
            {"26000", -514},                                     // statement not prepared
            {"40001", -911}, {"40P01", -911},                    // deadlock / rollback
            {"42501", -551},                                     // not authorized
            {"42710", -601}, {"42P07", -601}, {"42S01", -601},   // object already exists
            {"08001", -30080}, {"08003", -900}, {"08006", -30081}, // connection
        };
        auto it = codes.find(state);
        if (it != codes.end()) return it->second;
        if (native > 0) return -native;
        return -1;
    }

    bool isConnected_ = false;
    // Commitment control, as CRTSQLRPGI's default COMMIT(*CHG) has it: a
    // change waits for COMMIT, and ROLLBACK undoes it. SET OPTION
    // COMMIT = *NONE (or *NC) turns it off: each statement is committed
    // as it runs. Work still pending when the program ends normally, or
    // at DISCONNECT, is committed; when it ends in error the connection
    // is dropped without a commit, and the database rolls the work back.
    bool commitControl_ = true;

    // Named cursors: cursor name → statement handle
    std::map<std::string, SQLHSTMT> cursors;

    // Named prepared statements: stmt name → statement handle
    std::map<std::string, SQLHSTMT> prepared;

    RpgSqlEnv() {
        SQLAllocHandle(SQL_HANDLE_ENV, SQL_NULL_HANDLE, &henv);
        SQLSetEnvAttr(henv, SQL_ATTR_ODBC_VERSION, (void*)SQL_OV_ODBC3, 0);
        SQLAllocHandle(SQL_HANDLE_DBC, henv, &hdbc);
    }

    ~RpgSqlEnv() {
        for (auto& [name, hstmt] : cursors) {
            SQLFreeHandle(SQL_HANDLE_STMT, hstmt);
        }
        for (auto& [name, hstmt] : prepared) {
            if (cursors.find(name) == cursors.end()) {
                SQLFreeHandle(SQL_HANDLE_STMT, hstmt);
            }
        }
        if (hdbc != SQL_NULL_HDBC) {
            if (isConnected_ && commitControl_) SQLEndTran(SQL_HANDLE_DBC, hdbc, SQL_COMMIT);
            SQLDisconnect(hdbc);
            SQLFreeHandle(SQL_HANDLE_DBC, hdbc);
        }
        if (henv != SQL_NULL_HENV) {
            SQLFreeHandle(SQL_HANDLE_ENV, henv);
        }
    }

    // Connect using DSN
    void connect(const std::string& dsn,
                 const std::string& user = "",
                 const std::string& password = "") {
        if (isConnected_) { SQLDisconnect(hdbc); isConnected_ = false; }
        SQLRETURN rc = SQLConnect(hdbc,
            (SQLCHAR*)dsn.c_str(), SQL_NTS,
            user.empty() ? nullptr : (SQLCHAR*)user.c_str(), SQL_NTS,
            password.empty() ? nullptr : (SQLCHAR*)password.c_str(), SQL_NTS);
        updateDiag(SQL_HANDLE_DBC, hdbc, rc);
        if (rc == SQL_SUCCESS || rc == SQL_SUCCESS_WITH_INFO) { isConnected_ = true; applyCommitControl(); }
    }

    // Connect using connection string
    void connectStr(const std::string& connStr) {
        if (isConnected_) {
            SQLDisconnect(hdbc);
            isConnected_ = false;
        }
        SQLCHAR outConn[1024];
        SQLSMALLINT outLen;
        SQLRETURN rc = SQLDriverConnect(hdbc, nullptr,
            (SQLCHAR*)connStr.c_str(), SQL_NTS,
            outConn, sizeof(outConn), &outLen,
            SQL_DRIVER_NOPROMPT);
        updateDiag(SQL_HANDLE_DBC, hdbc, rc);
        if (rc == SQL_SUCCESS || rc == SQL_SUCCESS_WITH_INFO) { isConnected_ = true; applyCommitControl(); }
    }

    // SET OPTION COMMIT = ...
    void setCommitControl(bool on) {
        commitControl_ = on;
        if (isConnected_) applyCommitControl();
    }

    void applyCommitControl() {
        SQLSetConnectAttr(hdbc, SQL_ATTR_AUTOCOMMIT,
                          (SQLPOINTER)(uintptr_t)(commitControl_ ? SQL_AUTOCOMMIT_OFF : SQL_AUTOCOMMIT_ON),
                          SQL_IS_UINTEGER);
    }

    void disconnect() {
        if (!isConnected_) return;
        if (commitControl_) SQLEndTran(SQL_HANDLE_DBC, hdbc, SQL_COMMIT);
        SQLRETURN rc = SQLDisconnect(hdbc);
        updateDiag(SQL_HANDLE_DBC, hdbc, rc);
        isConnected_ = false;
    }

    // Allocate a new statement handle
    SQLHSTMT allocStmt() {
        SQLHSTMT hstmt = SQL_NULL_HSTMT;
        SQLAllocHandle(SQL_HANDLE_STMT, hdbc, &hstmt);
        return hstmt;
    }

    // Execute SQL directly (no parameters)
    void execDirect(const std::string& sql) {
        SQLHSTMT hstmt = allocStmt();
        SQLRETURN rc = SQLExecDirect(hstmt, (SQLCHAR*)sql.c_str(), SQL_NTS);
        updateDiag(SQL_HANDLE_STMT, hstmt, rc);
        if (rc == SQL_SUCCESS || rc == SQL_SUCCESS_WITH_INFO) {
            SQLRowCount(hstmt, &row_count);
        }
        SQLFreeHandle(SQL_HANDLE_STMT, hstmt);
    }

    // Commit / Rollback
    void commit() {
        SQLRETURN rc = SQLEndTran(SQL_HANDLE_DBC, hdbc, SQL_COMMIT);
        updateDiag(SQL_HANDLE_DBC, hdbc, rc);
    }

    void rollback() {
        SQLRETURN rc = SQLEndTran(SQL_HANDLE_DBC, hdbc, SQL_ROLLBACK);
        updateDiag(SQL_HANDLE_DBC, hdbc, rc);
    }

    // Declare a cursor (allocate stmt handle, prepare SQL)
    void declareCursor(const std::string& name, const std::string& sql) {
        SQLHSTMT hstmt = allocStmt();
        SQLRETURN rc = SQLPrepare(hstmt, (SQLCHAR*)sql.c_str(), SQL_NTS);
        updateDiag(SQL_HANDLE_STMT, hstmt, rc);
        cursors[name] = hstmt;
    }

    // Open a cursor (execute the prepared statement)
    void openCursor(const std::string& name) {
        auto it = cursors.find(name);
        if (it == cursors.end()) {
            sqlcode = -1;
            sqlstate = "24000";
            return;
        }
        SQLRETURN rc = SQLExecute(it->second);
        updateDiag(SQL_HANDLE_STMT, it->second, rc);
    }

    // Fetch from a cursor
    bool fetchCursor(const std::string& name) {
        auto it = cursors.find(name);
        if (it == cursors.end()) {
            sqlcode = -1;
            sqlstate = "24000";
            return false;
        }
        SQLRETURN rc = SQLFetch(it->second);
        updateDiag(SQL_HANDLE_STMT, it->second, rc);
        return (rc == SQL_SUCCESS || rc == SQL_SUCCESS_WITH_INFO);
    }

    // Close a cursor
    void closeCursor(const std::string& name) {
        auto it = cursors.find(name);
        if (it == cursors.end()) {
            sqlcode = -1;
            sqlstate = "24000";
            return;
        }
        SQLRETURN rc = SQLFreeStmt(it->second, SQL_CLOSE);
        updateDiag(SQL_HANDLE_STMT, it->second, rc);
    }

    // Get cursor statement handle (for binding columns)
    SQLHSTMT getCursorStmt(const std::string& name) {
        auto it = cursors.find(name);
        return (it != cursors.end()) ? it->second : SQL_NULL_HSTMT;
    }

    // Prepare a named statement
    void prepareStmt(const std::string& name, const std::string& sql) {
        SQLHSTMT hstmt = allocStmt();
        SQLRETURN rc = SQLPrepare(hstmt, (SQLCHAR*)sql.c_str(), SQL_NTS);
        updateDiag(SQL_HANDLE_STMT, hstmt, rc);
        prepared[name] = hstmt;
    }

    // Execute a named prepared statement
    void executeStmt(const std::string& name) {
        auto it = prepared.find(name);
        if (it == prepared.end()) {
            sqlcode = -1;
            sqlstate = "07003";
            return;
        }
        SQLRETURN rc = SQLExecute(it->second);
        updateDiag(SQL_HANDLE_STMT, it->second, rc);
    }

    // Get prepared statement handle (for binding parameters)
    SQLHSTMT getPreparedStmt(const std::string& name) {
        auto it = prepared.find(name);
        return (it != prepared.end()) ? it->second : SQL_NULL_HSTMT;
    }

    // Get row count from last statement
    SQLLEN getRowCount(SQLHSTMT hstmt) {
        SQLLEN count = 0;
        SQLRowCount(hstmt, &count);
        return count;
    }

    // Update diagnostics from a statement handle after execute/fetch
    void updateStmtDiag(SQLHSTMT hstmt, SQLRETURN rc) {
        updateDiag(SQL_HANDLE_STMT, hstmt, rc);
        if (rc == SQL_SUCCESS || rc == SQL_SUCCESS_WITH_INFO) {
            SQLRowCount(hstmt, &row_count);
        }
    }

    // Type-dispatched parameter binding (template enables if constexpr)
    // The value is copied into a buffer, so anything holding one will do:
    // a variable, or the value of an OVERLAY subfield's view.
    template<typename T>
    void bindParam(SQLHSTMT hstmt, int idx, const T& val) {
        if constexpr (std::is_same_v<std::decay_t<T>, std::string> ||
                      std::is_same_v<std::decay_t<T>, RpgCharOverlay>) {
            // Bound without trailing blanks. A CHAR(n) field always holds n
            // bytes, so a key of 'C002' arrives as 'C002      '. DB2 on
            // IBM i compares character values blank-padded, so that still
            // matches a stored 'C002'; SQLite and most ODBC targets compare
            // exactly, and it would not. Trimming gives DB2's result on a
            // database that doesn't pad. The cost: a VARCHAR host variable
            // that deliberately ends in blanks loses them.
            param_bufs_.push_back(std::string(val));
            auto& buf = param_bufs_.back();
            while (!buf.empty() && buf.back() == ' ') buf.pop_back();
            SQLBindParameter(hstmt, idx, SQL_PARAM_INPUT, SQL_C_CHAR, SQL_VARCHAR,
                             buf.size(), 0, (SQLCHAR*)buf.c_str(), buf.size() + 1, nullptr);
        } else if constexpr (std::is_integral_v<std::decay_t<T>>) {
            param_int_bufs_.push_back(static_cast<SQLINTEGER>(val));
            SQLBindParameter(hstmt, idx, SQL_PARAM_INPUT, SQL_C_SLONG, SQL_INTEGER,
                             0, 0, &param_int_bufs_.back(), 0, nullptr);
        } else {
            param_dbl_bufs_.push_back(static_cast<SQLDOUBLE>(val));
            SQLBindParameter(hstmt, idx, SQL_PARAM_INPUT, SQL_C_DOUBLE, SQL_DOUBLE,
                             0, 0, &param_dbl_bufs_.back(), 0, nullptr);
        }
    }

    // Type-dispatched column binding for SELECT INTO
    // strbuf must be a char array that outlives the fetch call
    template<typename T>
    void bindCol(SQLHSTMT hstmt, int idx, T& val, char* strbuf, SQLLEN strbufSize, SQLLEN& ind) {
        if constexpr (std::is_same_v<std::decay_t<T>, std::string>) {
            SQLBindCol(hstmt, idx, SQL_C_CHAR, strbuf, strbufSize, &ind);
        } else if constexpr (std::is_integral_v<std::decay_t<T>>) {
            SQLBindCol(hstmt, idx, SQL_C_SLONG, &val, 0, &ind);
        } else {
            SQLBindCol(hstmt, idx, SQL_C_DOUBLE, &val, 0, &ind);
        }
    }

    // Copy string buffer back to variable after fetch (no-op for non-string types)
    template<typename T>
    // A NULL leaves the host variable as it was, as on Db2 for i.
    static void copyStrBuf(T& val, const char* strbuf, SQLRETURN frc, SQLLEN ind = 0) {
        if constexpr (std::is_same_v<std::decay_t<T>, std::string>) {
            if ((frc == SQL_SUCCESS || frc == SQL_SUCCESS_WITH_INFO) && ind != SQL_NULL_DATA)
                val = std::string(strbuf);
        }
    }

    // A numeric host variable is bound directly, and a driver may write
    // into it for a NULL too: put back what it held.
    template<typename T>
    static void keepOnNull(T& val, const T& before, SQLRETURN frc, SQLLEN ind) {
        if ((frc == SQL_SUCCESS || frc == SQL_SUCCESS_WITH_INFO) && ind == SQL_NULL_DATA)
            val = before;
    }

    // A NULL fetched into a host variable with no null indicator: SQLCODE
    // -305, SQLSTATE 22002, "null indicator variable required" (Db2). The
    // program would otherwise go on with whatever the variable held.
    void nullNeedsIndicator(SQLRETURN frc, SQLLEN ind) {
        if ((frc == SQL_SUCCESS || frc == SQL_SUCCESS_WITH_INFO) && ind == SQL_NULL_DATA) {
            sqlcode = -305;
            sqlstate = "22002";
            message = "Indicator variable required.";
        }
    }

    // Bind a parameter with an SQL indicator variable (ind < 0 → SQL NULL)
    template<typename T>
    void bindParamWithInd(SQLHSTMT hstmt, int idx, const T& val, int ind_val) {
        if (ind_val < 0) {
            null_ind_bufs_.push_back(SQL_NULL_DATA);
            SQLBindParameter(hstmt, idx, SQL_PARAM_INPUT, SQL_C_CHAR, SQL_VARCHAR,
                             0, 0, nullptr, 0, &null_ind_bufs_.back());
        } else {
            bindParam(hstmt, idx, val);
        }
    }

    // Clear parameter buffers (call before binding a new statement)
    void clearParamBufs() {
        param_bufs_.clear();
        param_int_bufs_.clear();
        param_dbl_bufs_.clear();
        null_ind_bufs_.clear();
    }

    // Parameter buffers (persist until next statement execution)
    // Using deque to avoid pointer invalidation on push_back (vector reallocates)
    std::deque<std::string> param_bufs_;
    std::deque<SQLINTEGER> param_int_bufs_;
    std::deque<SQLDOUBLE> param_dbl_bufs_;
    std::deque<SQLLEN> null_ind_bufs_;

private:
    void updateDiag(SQLSMALLINT handleType, SQLHANDLE handle, SQLRETURN rc) {
        message.clear();
        if (rc == SQL_SUCCESS) {
            sqlcode = 0;
            sqlstate = "00000";
            return;
        }
        if (rc == SQL_NO_DATA) {
            sqlcode = 100;
            sqlstate = "02000";
            return;
        }
        SQLCHAR state[6] = {};
        SQLINTEGER nativeError = 0;
        std::vector<SQLCHAR> msg(1024);
        SQLSMALLINT msgLen = 0;
        SQLRETURN drc = SQLGetDiagRec(handleType, handle, 1, state, &nativeError,
                                      msg.data(), static_cast<SQLSMALLINT>(msg.size()), &msgLen);
        if (drc == SQL_SUCCESS_WITH_INFO && msgLen >= static_cast<SQLSMALLINT>(msg.size())) {
            msg.resize(static_cast<size_t>(msgLen) + 1);   // the message didn't fit
            drc = SQLGetDiagRec(handleType, handle, 1, state, &nativeError,
                                msg.data(), static_cast<SQLSMALLINT>(msg.size()), &msgLen);
        }
        if (drc == SQL_SUCCESS || drc == SQL_SUCCESS_WITH_INFO) {
            sqlstate = std::string((char*)state, 5);
            message = std::string((char*)msg.data());
            while (!message.empty() && (message.back() == '\n' || message.back() == '\r'))
                message.pop_back();
            sqlcode = (rc == SQL_SUCCESS_WITH_INFO) ? 0 : db2Sqlcode(sqlstate, static_cast<int>(nativeError));
        } else {
            sqlcode = (rc == SQL_SUCCESS_WITH_INFO) ? 0 : -1;
            sqlstate = "HY000";
        }
    }
};

#endif // RPG_SQL_RUNTIME_H
