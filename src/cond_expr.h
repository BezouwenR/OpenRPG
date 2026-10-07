#ifndef RPGC_COND_EXPR_H
#define RPGC_COND_EXPR_H

#include <cctype>
#include <set>
#include <string>

// The condition of an /IF or /ELSEIF directive. IBM i takes one test,
// DEFINED(name) or NOT DEFINED(name); OpenRPG also takes several, joined
// with AND and OR and grouped with parentheses, NOT binding tightest and
// AND before OR, as in an RPG expression:
//
//   /IF DEFINED(A) AND NOT DEFINED(B)
//   /IF (DEFINED(LINUX) OR DEFINED(MACOS)) AND NOT DEFINED(NOGUI)
//
// Shared by the free-format lexer and the fixed-format reader. Names are
// compared in upper case. A // comment may follow the condition. Returns
// false, with a message in err, when the text is not a condition.
namespace rpgc_cond {

class Parser {
public:
    Parser(const std::string& text, const std::set<std::string>& defs)
        : s_(text), defs_(defs) {}

    bool parse(bool& result, std::string& err) {
        try {
            result = orExpr();
            ws();
            if (pos_ < s_.size() && s_.compare(pos_, 2, "//") != 0)
                throw std::string("unexpected '" + s_.substr(pos_) + "'");
            return true;
        } catch (const std::string& e) {
            err = "expected DEFINED(name), NOT, AND, OR or parentheses: " + e;
            return false;
        }
    }

private:
    const std::string& s_;
    const std::set<std::string>& defs_;
    size_t pos_ = 0;

    void ws() { while (pos_ < s_.size() && std::isspace((unsigned char)s_[pos_])) pos_++; }
    // The word at pos_, upper-cased, without consuming it.
    std::string peekWord() {
        ws();
        size_t e = pos_;
        while (e < s_.size() && (std::isalnum((unsigned char)s_[e]) || s_[e] == '_' ||
               s_[e] == '*' || s_[e] == '#' || s_[e] == '$' || s_[e] == '@')) e++;
        std::string w = s_.substr(pos_, e - pos_);
        for (auto& c : w) c = (char)std::toupper((unsigned char)c);
        return w;
    }
    bool eatWord(const char* w) {
        if (peekWord() != w) return false;
        pos_ += std::string(w).size();
        return true;
    }
    bool eat(char c) {
        ws();
        if (pos_ < s_.size() && s_[pos_] == c) { pos_++; return true; }
        return false;
    }

    bool orExpr() {
        bool v = andExpr();
        while (eatWord("OR")) { bool r = andExpr(); v = v || r; }
        return v;
    }
    bool andExpr() {
        bool v = notExpr();
        while (eatWord("AND")) { bool r = notExpr(); v = v && r; }
        return v;
    }
    bool notExpr() {
        if (eatWord("NOT")) return !notExpr();
        return primary();
    }
    bool primary() {
        if (eat('(')) {
            bool v = orExpr();
            if (!eat(')')) throw std::string("a ( has no )");
            return v;
        }
        if (!eatWord("DEFINED")) {
            ws();
            throw std::string(pos_ < s_.size() ? "'" + s_.substr(pos_) + "'" : "nothing");
        }
        if (!eat('(')) throw std::string("DEFINED needs (name)");
        ws();
        std::string name = peekWord();
        if (name.empty()) throw std::string("DEFINED needs (name)");
        pos_ += name.size();
        if (!eat(')')) throw std::string("DEFINED(" + name + " has no )");
        return defs_.count(name) > 0;
    }
};

inline bool evaluate(const std::string& text, const std::set<std::string>& defs,
                     bool& result, std::string& err) {
    return Parser(text, defs).parse(result, err);
}

// /MESSAGE {*WARNING | *ERROR} 'text', an OpenRPG extension: the text after
// the directive, and whether it is an error (which fails the compile, as
// C's #error) rather than a warning. The text is a quoted literal, its
// quotes doubled inside, or else the rest of the line as written.
inline void message(const std::string& rest, bool& error, std::string& text) {
    std::string r = rest;
    auto trim = [](std::string& s) {
        size_t a = s.find_first_not_of(" \t\r");
        size_t b = s.find_last_not_of(" \t\r");
        s = a == std::string::npos ? "" : s.substr(a, b - a + 1);
    };
    trim(r);
    error = false;
    std::string up = r;
    for (auto& c : up) c = (char)std::toupper((unsigned char)c);
    if (up.rfind("*ERROR", 0) == 0) { error = true; r = r.substr(6); }
    else if (up.rfind("*WARNING", 0) == 0) r = r.substr(8);
    trim(r);
    if (r.size() >= 2 && r.front() == '\'' && r.back() == '\'') {
        text.clear();
        for (size_t i = 1; i + 1 < r.size(); i++) {
            text += r[i];
            if (r[i] == '\'' && r[i + 1] == '\'') i++;
        }
    } else {
        text = r;
    }
}

} // namespace rpgc_cond

#endif // RPGC_COND_EXPR_H
