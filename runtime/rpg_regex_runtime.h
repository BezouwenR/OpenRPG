#ifndef RPG_REGEX_RUNTIME_H
#define RPG_REGEX_RUNTIME_H

// Regular-expression built-ins, an OpenRPG extension: %MATCHES, %FIND and
// %COUNTMATCHES. Included only by programs that use them, since <regex> is
// slow to compile. The patterns are ECMAScript regular expressions, as
// std::regex reads them.

#include <map>
#include <regex>
#include <string>
#include "rpg_runtime.h"

// A pattern is compiled once and kept: a loop testing every record against
// the same pattern would otherwise compile it every time. A pattern that is
// not a regular expression is status 100, as a bad %SUBST or %SCAN
// operand is.
inline const std::regex& rpg_regex(const std::string& pattern) {
    static std::map<std::string, std::regex> cache;
    auto it = cache.find(pattern);
    if (it != cache.end()) return it->second;
    try {
        return cache.emplace(pattern, std::regex(pattern, std::regex::ECMAScript)).first->second;
    } catch (const std::regex_error& e) {
        rpg_raise(100, "RNX0100: Regular expression '" + pattern + "' is not valid: " + e.what());
    }
    static const std::regex never;
    return never;
}

// %MATCHES(string : regex): whether the pattern matches anywhere in the
// string. ^ and $ anchor it to the whole string.
inline bool rpg_regex_matches(const std::string& s, const std::string& pattern) {
    return std::regex_search(s, rpg_regex(pattern));
}

// %FIND(regex : string): where the first match starts, from 1, or 0.
inline int rpg_regex_find(const std::string& pattern, const std::string& s) {
    std::smatch m;
    if (!std::regex_search(s, m, rpg_regex(pattern))) return 0;
    return static_cast<int>(m.position(0)) + 1;
}

// %COUNTMATCHES(regex : string): how many times the pattern matches, each
// match starting after the one before it ends. An empty match counts once
// and moves on a character.
inline int rpg_regex_count(const std::string& pattern, const std::string& s) {
    const std::regex& re = rpg_regex(pattern);
    return static_cast<int>(std::distance(std::sregex_iterator(s.begin(), s.end(), re),
                                          std::sregex_iterator()));
}

#endif // RPG_REGEX_RUNTIME_H
