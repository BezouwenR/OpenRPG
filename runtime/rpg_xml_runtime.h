#ifndef RPG_XML_RUNTIME_H
#define RPG_XML_RUNTIME_H

// Lightweight XML parser for RPG XML-INTO support
// Parses XML strings into a simple DOM for field extraction

#include <string>
#include <vector>
#include <algorithm>
#include <stdexcept>
#include <cctype>
#include <cstdlib>

struct RpgXmlNode {
    std::string name;
    std::string text;
    std::vector<RpgXmlNode> children;
    std::vector<std::pair<std::string, std::string>> attributes;
};

struct RpgXmlDoc {
    RpgXmlNode root;
};

namespace rpg_xml_detail {

inline void skip_ws(const std::string& s, size_t& pos) {
    while (pos < s.size() && std::isspace(static_cast<unsigned char>(s[pos]))) pos++;
}

inline void skip_xml_decl(const std::string& s, size_t& pos) {
    skip_ws(s, pos);
    if (pos + 1 < s.size() && s[pos] == '<' && s[pos + 1] == '?') {
        auto end = s.find("?>", pos);
        if (end != std::string::npos) pos = end + 2;
    }
}

inline std::string decode_entity(const std::string& text) {
    std::string result;
    result.reserve(text.size());
    for (size_t i = 0; i < text.size(); i++) {
        if (text[i] == '&') {
            if (text.compare(i, 4, "&lt;") == 0) { result += '<'; i += 3; }
            else if (text.compare(i, 4, "&gt;") == 0) { result += '>'; i += 3; }
            else if (text.compare(i, 5, "&amp;") == 0) { result += '&'; i += 4; }
            else if (text.compare(i, 6, "&apos;") == 0) { result += '\''; i += 5; }
            else if (text.compare(i, 6, "&quot;") == 0) { result += '"'; i += 5; }
            else result += text[i];
        } else {
            result += text[i];
        }
    }
    return result;
}

inline std::string parse_attr_value(const std::string& s, size_t& pos) {
    char quote = s[pos++]; // consume opening quote
    std::string val;
    while (pos < s.size() && s[pos] != quote) {
        val += s[pos++];
    }
    if (pos < s.size()) pos++; // consume closing quote
    return decode_entity(val);
}

inline RpgXmlNode parse_element(const std::string& s, size_t& pos) {
    RpgXmlNode node;
    skip_ws(s, pos);

    if (pos >= s.size() || s[pos] != '<') return node;
    pos++; // skip '<'

    // Parse tag name
    while (pos < s.size() && !std::isspace(static_cast<unsigned char>(s[pos]))
           && s[pos] != '>' && s[pos] != '/') {
        node.name += s[pos++];
    }

    // Parse attributes
    while (pos < s.size() && s[pos] != '>' && s[pos] != '/') {
        skip_ws(s, pos);
        if (pos < s.size() && s[pos] != '>' && s[pos] != '/') {
            std::string attr_name;
            while (pos < s.size() && s[pos] != '=' && s[pos] != '>'
                   && !std::isspace(static_cast<unsigned char>(s[pos]))) {
                attr_name += s[pos++];
            }
            skip_ws(s, pos);
            if (pos < s.size() && s[pos] == '=') {
                pos++; // skip '='
                skip_ws(s, pos);
                if (pos < s.size() && (s[pos] == '"' || s[pos] == '\'')) {
                    node.attributes.push_back({attr_name, parse_attr_value(s, pos)});
                }
            }
        }
    }

    // Self-closing tag?
    if (pos < s.size() && s[pos] == '/') {
        pos++; // skip '/'
        if (pos < s.size() && s[pos] == '>') pos++; // skip '>'
        return node;
    }

    if (pos < s.size() && s[pos] == '>') pos++; // skip '>'

    // Parse content (text and child elements)
    while (pos < s.size()) {
        skip_ws(s, pos);
        if (pos >= s.size()) break;

        // End tag?
        if (pos + 1 < s.size() && s[pos] == '<' && s[pos + 1] == '/') {
            pos += 2; // skip '</'
            // Skip tag name
            while (pos < s.size() && s[pos] != '>') pos++;
            if (pos < s.size()) pos++; // skip '>'
            break;
        }

        // Child element?
        if (s[pos] == '<') {
            // Skip comments
            if (pos + 3 < s.size() && s[pos+1] == '!' && s[pos+2] == '-' && s[pos+3] == '-') {
                auto end = s.find("-->", pos);
                if (end != std::string::npos) { pos = end + 3; continue; }
            }
            // Skip CDATA
            if (pos + 8 < s.size() && s.compare(pos, 9, "<![CDATA[") == 0) {
                auto end = s.find("]]>", pos);
                if (end != std::string::npos) {
                    node.text += s.substr(pos + 9, end - pos - 9);
                    pos = end + 3;
                    continue;
                }
            }
            node.children.push_back(parse_element(s, pos));
        } else {
            // Text content
            std::string text;
            while (pos < s.size() && s[pos] != '<') {
                text += s[pos++];
            }
            // Trim trailing whitespace
            while (!text.empty() && std::isspace(static_cast<unsigned char>(text.back())))
                text.pop_back();
            if (!text.empty())
                node.text += decode_entity(text);
        }
    }

    return node;
}

} // namespace rpg_xml_detail

// Parse an XML string into a document
inline RpgXmlDoc rpg_xml_parse(const std::string& xml) {
    RpgXmlDoc doc;
    size_t pos = 0;
    rpg_xml_detail::skip_xml_decl(xml, pos);
    rpg_xml_detail::skip_ws(xml, pos);
    if (pos < xml.size()) {
        doc.root = rpg_xml_detail::parse_element(xml, pos);
    }
    return doc;
}

// Case-insensitive string compare
inline bool rpg_xml_name_match(const std::string& a, const std::string& b, bool case_any) {
    if (!case_any) return a == b;
    if (a.size() != b.size()) return false;
    for (size_t i = 0; i < a.size(); i++) {
        if (std::toupper(static_cast<unsigned char>(a[i])) !=
            std::toupper(static_cast<unsigned char>(b[i])))
            return false;
    }
    return true;
}

// Find a child element by name
inline const RpgXmlNode* rpg_xml_find(const RpgXmlNode& node, const std::string& name, bool case_any) {
    for (auto& child : node.children) {
        if (rpg_xml_name_match(child.name, name, case_any))
            return &child;
    }
    return nullptr;
}

// Extract string value from a named child element
inline std::string rpg_xml_get_str(const RpgXmlNode& node, const std::string& name, bool case_any) {
    const RpgXmlNode* child = rpg_xml_find(node, name, case_any);
    return child ? child->text : "";
}

// Extract integer value from a named child element
inline int rpg_xml_get_int(const RpgXmlNode& node, const std::string& name, bool case_any) {
    const RpgXmlNode* child = rpg_xml_find(node, name, case_any);
    if (!child || child->text.empty()) return 0;
    return std::atoi(child->text.c_str());
}

// Extract double value from a named child element
inline double rpg_xml_get_double(const RpgXmlNode& node, const std::string& name, bool case_any) {
    const RpgXmlNode* child = rpg_xml_find(node, name, case_any);
    if (!child || child->text.empty()) return 0.0;
    return std::atof(child->text.c_str());
}

// Navigate to a descendant node via slash-separated path (e.g., "data/orders/order")
// If the first path segment matches the root element name, it is consumed (RPG convention).
inline const RpgXmlNode* rpg_xml_navigate(const RpgXmlNode& root, const std::string& path, bool case_any) {
    const RpgXmlNode* cur = &root;
    size_t start = 0;
    bool first = true;
    while (start < path.size()) {
        size_t slash = path.find('/', start);
        std::string segment = (slash == std::string::npos)
            ? path.substr(start) : path.substr(start, slash - start);
        start = (slash == std::string::npos) ? path.size() : slash + 1;
        if (segment.empty()) continue;
        // If first segment matches root name, skip it (root is already current)
        if (first && rpg_xml_name_match(cur->name, segment, case_any)) {
            first = false;
            continue;
        }
        first = false;
        const RpgXmlNode* found = rpg_xml_find(*cur, segment, case_any);
        if (!found) return nullptr;
        cur = found;
    }
    return cur;
}

// Collect all children matching a name (for array DS loading)
inline std::vector<const RpgXmlNode*> rpg_xml_find_all(const RpgXmlNode& node, const std::string& name, bool case_any) {
    std::vector<const RpgXmlNode*> result;
    for (auto& child : node.children) {
        if (rpg_xml_name_match(child.name, name, case_any))
            result.push_back(&child);
    }
    return result;
}

// --- XML-INTO as IBM i does it --------------------------------------------
//
// The options (%XML's second argument) decide how the document is matched to
// the RPG variable, and a document that does not match is an error, status
// 353 (RNX0353) -- not a best effort. Verified on PUB400 (test87, test88):
//   case=lower (default)  XML names are the RPG names in lower case
//   case=upper            ... in upper case
//   case=any / convert    ... in any case
//   allowmissing=no (default)  every subfield needs an element (or attribute)
//   allowextra=no (default)    every element needs a subfield
//   path=a/b/c            the element(s) to read, from the document's root;
//                         by default the variable's own name. For an array
//                         the last name is the repeated element.
// With allowmissing=yes a subfield with no element keeps its value.
[[noreturn]] inline void rpg_raise(int status, const std::string& msg);

struct RpgXmlOpts {
    enum Case { LOWER, UPPER, ANY } casemode = LOWER;
    bool allowmissing = false;
    bool allowextra = false;
    std::string path;
};

inline RpgXmlOpts rpg_xml_opts(const std::string& s) {
    RpgXmlOpts o;
    size_t i = 0;
    while (i < s.size()) {
        while (i < s.size() && std::isspace(static_cast<unsigned char>(s[i]))) i++;
        size_t j = i;
        while (j < s.size() && !std::isspace(static_cast<unsigned char>(s[j]))) j++;
        std::string tok = s.substr(i, j - i);
        i = j;
        size_t eq = tok.find('=');
        if (eq == std::string::npos) continue;
        std::string k = tok.substr(0, eq), v = tok.substr(eq + 1);
        for (auto& c : k) c = static_cast<char>(std::tolower(static_cast<unsigned char>(c)));
        std::string lv = v;
        for (auto& c : lv) c = static_cast<char>(std::tolower(static_cast<unsigned char>(c)));
        if (k == "case") o.casemode = lv == "upper" ? RpgXmlOpts::UPPER
                                    : (lv == "any" || lv == "convert") ? RpgXmlOpts::ANY
                                    : RpgXmlOpts::LOWER;
        else if (k == "allowmissing") o.allowmissing = lv == "yes";
        else if (k == "allowextra") o.allowextra = lv == "yes";
        else if (k == "path") o.path = v;
    }
    return o;
}

// Does an XML name match an RPG name (which the compiler holds upper case)?
inline bool rpg_xml_eq(const std::string& xml, const std::string& rpg, const RpgXmlOpts& o) {
    if (xml.size() != rpg.size()) return false;
    for (size_t i = 0; i < xml.size(); i++) {
        unsigned char x = static_cast<unsigned char>(xml[i]), r = static_cast<unsigned char>(rpg[i]);
        if (o.casemode == RpgXmlOpts::ANY) { if (std::toupper(x) != std::toupper(r)) return false; }
        else if (o.casemode == RpgXmlOpts::LOWER) { if (x != std::tolower(r)) return false; }
        else if (x != std::toupper(r)) return false;
    }
    return true;
}

// A path names XML elements as written; only case=any relaxes it.
inline bool rpg_xml_path_eq(const std::string& xml, const std::string& seg, const RpgXmlOpts& o) {
    if (o.casemode != RpgXmlOpts::ANY) return xml == seg;
    RpgXmlOpts any; any.casemode = RpgXmlOpts::ANY;
    return rpg_xml_eq(xml, seg, any);
}

[[noreturn]] inline void rpg_xml_mismatch(const std::string& why) {
    rpg_raise(353, "RNX0353: The XML document does not match the RPG variable: " + why + ".");
}

// The element(s) XML-INTO reads into `target` (the variable's name, upper
// case): those the path names, or by default the document's root, which
// must then be named as the variable is.
inline std::vector<const RpgXmlNode*> rpg_xml_select(const RpgXmlDoc& d, const std::string& target,
                                                     const RpgXmlOpts& o) {
    std::vector<std::string> segs;
    bool byName = o.path.empty();
    if (byName) segs.push_back(target);
    else {
        size_t i = 0;
        while (i <= o.path.size()) {
            size_t j = o.path.find('/', i);
            if (j == std::string::npos) j = o.path.size();
            if (j > i) segs.push_back(o.path.substr(i, j - i));
            i = j + 1;
        }
    }
    if (segs.empty()) rpg_xml_mismatch("the path is empty");
    auto eq = [&](const std::string& x, const std::string& s) {
        return byName ? rpg_xml_eq(x, s, o) : rpg_xml_path_eq(x, s, o);
    };
    const RpgXmlNode* cur = &d.root;
    if (!eq(cur->name, segs[0])) rpg_xml_mismatch("the document's element is <" + cur->name + ">");
    if (segs.size() == 1) return {cur};
    for (size_t k = 1; k + 1 < segs.size(); k++) {
        const RpgXmlNode* next = nullptr;
        for (auto& c : cur->children) if (eq(c.name, segs[k])) { next = &c; break; }
        if (!next) rpg_xml_mismatch("no element <" + segs[k] + "> on the path");
        cur = next;
    }
    std::vector<const RpgXmlNode*> out;
    for (auto& c : cur->children) if (eq(c.name, segs.back())) out.push_back(&c);
    if (out.empty()) rpg_xml_mismatch("no element <" + segs.back() + "> on the path");
    return out;
}

// allowmissing / allowextra: the element's children and attributes against
// the data structure's subfields.
inline void rpg_xml_check(const RpgXmlNode& n, const std::vector<std::string>& subfields,
                          const RpgXmlOpts& o) {
    if (!o.allowmissing) {
        for (auto& sf : subfields) {
            bool found = false;
            for (auto& c : n.children) if (rpg_xml_eq(c.name, sf, o)) { found = true; break; }
            for (auto& a : n.attributes) if (!found && rpg_xml_eq(a.first, sf, o)) found = true;
            if (!found) rpg_xml_mismatch("<" + n.name + "> has nothing for subfield " + sf);
        }
    }
    if (!o.allowextra) {
        auto known = [&](const std::string& x) {
            for (auto& sf : subfields) if (rpg_xml_eq(x, sf, o)) return true;
            return false;
        };
        for (auto& c : n.children)
            if (!known(c.name)) rpg_xml_mismatch("<" + c.name + "> matches no subfield");
        for (auto& a : n.attributes)
            if (!known(a.first)) rpg_xml_mismatch("attribute " + a.first + " matches no subfield");
    }
}

// A subfield's element, or its attribute's value; nullptr when there is none.
inline const RpgXmlNode* rpg_xml_child(const RpgXmlNode& n, const std::string& sf, const RpgXmlOpts& o) {
    for (auto& c : n.children) if (rpg_xml_eq(c.name, sf, o)) return &c;
    return nullptr;
}
inline const std::string* rpg_xml_value(const RpgXmlNode& n, const std::string& sf, const RpgXmlOpts& o) {
    if (const RpgXmlNode* c = rpg_xml_child(n, sf, o)) return &c->text;
    for (auto& a : n.attributes) if (rpg_xml_eq(a.first, sf, o)) return &a.second;
    return nullptr;
}
inline int rpg_xml_to_int(const std::string& s) { return s.empty() ? 0 : std::atoi(s.c_str()); }
inline double rpg_xml_to_double(const std::string& s) { return s.empty() ? 0.0 : std::atof(s.c_str()); }

#endif // RPG_XML_RUNTIME_H
