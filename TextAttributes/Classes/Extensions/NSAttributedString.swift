import UIKit
public extension NSAttributedString {
    /// A mutable copy of the `NSAttributedString` instance
    var mutable: NSMutableAttributedString {
        return mutableCopy() as! NSMutableAttributedString
    }
}

public extension NSMutableAttributedString {
    /// Returns an attributed string consisting of the characters and attributes within
    /// the specified range in the attributed string.
    /// - Parameter range: The range from which to create a new attributed string. aRange
    /// must lie within the bounds of the receiver.
    /// - Returns: An NSAttributedString
    ///
    /// Raises an rangeException if any part of range lies beyond the end of the receiver’s
    /// characters. This method treats the length of the string as a valid range value that
    /// returns an empty string.
    func attributedSubstring(from range: Range<String.UTF16View.Index>) -> NSAttributedString {
        let nsRange = NSRange(location: string.utf16.distance(from: string.utf16.startIndex, to: range.lowerBound), length: string.utf16.distance(from: range.lowerBound, to: range.upperBound))
        return attributedSubstring(from: nsRange)
    }

    /// Replaces the characters and attributes in a given range with the characters and
    /// attributes of the given attributed string.
    /// - Parameters:
    ///   - range: The range of characters and attributes replaced.
    ///   - attrString: The attributed string whose characters and attributes replace those in the specified range.
    ///
    /// Raises an rangeException if any part of range lies beyond the end of the receiver’s characters.
    func replaceCharacters(in range: Range<String.UTF16View.Index>, with attrString: NSAttributedString) {
        let nsRange = NSRange(location: string.utf16.distance(from: string.utf16.startIndex, to: range.lowerBound), length: string.utf16.distance(from: range.lowerBound, to: range.upperBound))
        replaceCharacters(in: nsRange, with: attrString)
    }
    
    /// Adds an attribute with the given name and value to the characters in the specified range.
    /// - Parameters:
    ///   - attr: A string specifying the attribute name. Attribute keys can be supplied by another
    ///   framework or can be custom ones you define. For information about the system-supplied attribute
    ///   keys, see the Constants section in NSAttributedString.
    ///   - value: The attribute value associated with name.
    ///   - range: The range of characters to which the specified attribute/value pair applies.
    ///
    /// You may assign any name/value pair you wish to a range of characters. Raises an invalidArgumentException
    /// if name or value is nil and an rangeException if any part of aRange lies beyond the end of the receiver’s
    /// characters.
    func addAttribute(_ attr: NSAttributedString.Key, value: Any, range: Range<String.UTF16View.Index>? = nil) {
        let nsRange = range.map { NSRange(location: string.utf16.distance(from: string.utf16.startIndex, to: $0.lowerBound), length: string.utf16.distance(from: $0.lowerBound, to: $0.upperBound)) } ?? NSRange(location: 0, length: length)
        addAttribute(attr, value: value, range: nsRange)
    }

    /// Adds the given collection of attributes to the characters in the specified range.
    /// - Parameters:
    ///   - attrs: A dictionary containing the attributes to add. Attribute keys can be supplied by another
    ///   framework or can be custom ones you define. For information about the system-supplied attribute
    ///   keys, see the Constants section in NSAttributedString.
    ///   - range: The range of characters to which the specified attributes apply.
    ///
    /// You may assign any name/value pair you wish to a range of characters. Raises an invalidArgumentException
    /// if attributes is nil and an rangeException if any part of aRange lies beyond the end of the receiver’s
    /// characters.
    func addAttributes(_ attrs: [NSAttributedString.Key: Any], range: Range<String.UTF16View.Index>? = nil) {
        let nsRange = range.map { NSRange(location: string.utf16.distance(from: string.utf16.startIndex, to: $0.lowerBound), length: string.utf16.distance(from: $0.lowerBound, to: $0.upperBound)) } ?? NSRange(location: 0, length: length)
        addAttributes(attrs, range: nsRange)
    }

    /// Removes the named attribute from the characters in the specified range.
    /// - Parameters:
    ///   - name: A string specifying the attribute name to remove. Attribute keys can be supplied by another
    ///   framework or can be custom ones you define. For information about where to find the system-supplied
    ///   attribute keys, see the overview section in NSAttributedString.
    ///   - range: The range of characters from which the specified attribute is removed.
    ///
    /// Raises an rangeException if any part of aRange lies beyond the end of the receiver’s characters.
    func removeAttribute(_ name: NSAttributedString.Key, range: Range<String.UTF16View.Index>? = nil) {
        let nsRange = range.map { NSRange(location: string.utf16.distance(from: string.utf16.startIndex, to: $0.lowerBound), length: string.utf16.distance(from: $0.lowerBound, to: $0.upperBound)) } ?? NSRange(location: 0, length: length)
        removeAttribute(name, range: nsRange)
    }
}

public extension NSMutableAttributedString {
    /// Enumerates the each subrange of `attr` in the `NSMutableAttributedString` and calls the closure with the
    /// attributes value and the range of the found attributes
    
    /// Enumerates each attribute in the string.
    /// - Parameters:
    ///   - attr: The `TextAttribute.Style` attribute to enumerate.
    ///   - opts: The options used by the enumeration. For possible values, see NSAttributedString.EnumerationOptions.
    ///   - inRange: The range over which the attribute values are enumerated.
    ///   - block: A closure to apply to ranges of the specified attribute in the attributed string.
    ///
    ///     The closure takes two arguments:
    ///     - The attributes for the specified TextAttribute.Style
    ///     - The range of the found TextAttribute.Style in the attributed string.
    func enumerateAttribute(_ attr: TextAttribute.Style,
                            options opts: NSAttributedString.EnumerationOptions = [],
                            in inRange: Range<String.Index>? = nil,
                            using block: (Any?, Range<String.UTF16View.Index>) -> Void) {
        let nsRange = inRange.map { NSRange(location: string.utf16.distance(from: string.utf16.startIndex, to: $0.lowerBound), length: string.utf16.distance(from: $0.lowerBound, to: $0.upperBound)) }
            ?? NSRange(location: 0, length: length)
        enumerateAttribute(attr.key, in: nsRange, options: opts) { attribute, range, stop in
            let start = string.utf16.index(string.utf16.startIndex, offsetBy: range.location)
            let end = string.utf16.index(string.utf16.startIndex, offsetBy: range.location + range.length)
            block(attribute, start..<end)
        }
    }
    
    /// Enumerates each found substring in the string.
    /// - Parameters:
    ///   - aString: The String to enumerate.
    ///   - opts: The options used by the enumeration. For possible values, see String.CompareOptions.
    ///   - inRange: The range over which the attribute values are enumerated.
    ///   - block: A closure to apply to ranges of the specified substring in the attributed string.
    ///
    ///     The closure takes two arguments:
    ///     - An inout NSMutableAttributedString. You may edit the attributes and / or string property.
    ///     - The range of aString in the attributed string.
    func enumerateOccurrences(of aString: String,
                              options opts: String.CompareOptions = [],
                              in inRange: Range<String.UTF16View.Index>? = nil,
                              using block: (inout NSMutableAttributedString, Range<String.UTF16View.Index>) -> Void) {
        let range = inRange ?? string.utf16.startIndex..<string.utf16.index(string.utf16.startIndex, offsetBy: length)
        var start = range.lowerBound
        let end = range.upperBound
        let slice = string[range]
        var substringRanges:[Range<String.UTF16View.Index>] = []
        while let subrange = slice.range(of: aString, options: opts, range: start..<end) {
            substringRanges.append(subrange)
            start = subrange.upperBound
            if start == end { break }
        }
        
        var offset = 0
        substringRanges.forEach { range in
            
            let substringStart = string.utf16.index(range.lowerBound, offsetBy: offset)
            let substringEnd = string.utf16.index(range.upperBound, offsetBy: offset)
            var substring = attributedSubstring(from: substringStart..<substringEnd).mutable
            let len = substring.length
            block(&substring, range)
            
            let replacementStart = string.utf16.index(range.lowerBound, offsetBy: offset)
            let replacementEnd = string.utf16.index(range.upperBound, offsetBy: offset)
            replaceCharacters(in: replacementStart..<replacementEnd, with: substring)
            offset = offset + (substring.length - len)
        }
    }
}

public extension NSAttributedString {
    /// Adds the TextAttribute to the characters in the specified range.
    /// - Parameters:
    ///   - attr: The TextAttribute that should be applied.
    ///   - inRange: The range of characters to which the specified attributes apply.
    ///
    /// - Returns: Returns self. Useful if you wish to chain multiple commands together
    func addingAttribute(_ attr: TextAttribute,
                         in inRange: Range<String.UTF16View.Index>? = nil) -> NSAttributedString {
        return addingAttributes([attr], in: inRange)
    }
    
    /// Adds the given collection of TextAttributes to the characters in the specified range.
    /// - Parameters:
    ///   - attrs: The TextAttribute that should be applied.
    ///   - inRange: The range of characters to which the specified attributes apply.
    ///
    /// - Returns: Returns self. Useful if you wish to chain multiple commands together
    func addingAttributes(_ attrs: [TextAttribute],
                          in inRange: Range<String.UTF16View.Index>? = nil) -> NSAttributedString {
        let string = mutable
        string.addAttributes(attrs, in: inRange)
        return NSAttributedString(attributedString: string)
    }
    
    /// Adds the given TextAttribute to each occurence of the provided String in the specified range.
    /// - Parameters:
    ///   - attr: The TextAttribute that should be applied.
    ///   - aString: The sub String which to add the attribute to.
    ///   - opts: The options used by the enumeration. For possible values, see String.CompareOptions.
    ///   - inRange: The range of characters to which the specified attribute apply.
    ///
    /// - Returns: Returns self. Useful if you wish to chain multiple commands together
    func addingAttribute(_ attr: TextAttribute,
                         toOccurencesOfString aString: String,
                         options opts: String.CompareOptions = [],
                         in inRange: Range<String.UTF16View.Index>? = nil) -> NSAttributedString {
        return addingAttributes([attr], toOccurencesOfString: aString, options: opts, in: inRange)
    }
    
    /// Adds the given TextAttributes to each occurence of the provided String in the specified range.
    /// - Parameters:
    ///   - attrs: The TextAttributes that should be applied.
    ///   - aString: The sub String which to add the attributes to.
    ///   - opts: The options used by the enumeration. For possible values, see String.CompareOptions.
    ///   - inRange: The range of characters to which the specified attributes apply.
    ///
    /// - Returns: Returns self. Useful if you wish to chain multiple commands together
    func addingAttributes(_ attrs: [TextAttribute],
                          toOccurencesOfString aString: String,
                          options opts: String.CompareOptions = [],
                          in inRange: Range<String.UTF16View.Index>? = nil) -> NSAttributedString {
        let string = mutable
        string.addAttributes(attrs, toOccurencesOfString: aString, options: opts, in: inRange)
        return NSAttributedString(attributedString: string)
    }
    
    /// Removes the TextAttribute.Style from the NSMutableAttributedString
    /// - Parameters:
    ///   - attr: The TextAttribute that should be removed.
    ///   - inRange: The range of characters to which to remove the specified attribute.
    ///
    /// - Returns: Returns self. Useful if you wish to chain multiple commands together
    func removingAttribute(_ attr: TextAttribute.Style,
                           in inRange: Range<String.UTF16View.Index>? = nil) -> NSAttributedString {
        removingAttributes([attr], in: inRange)
    }

    /// Removes the TextAttribute.Styles from the NSMutableAttributedString
    /// - Parameters:
    ///   - attrs: The TextAttributes that should be removed.
    ///   - inRange: The range of characters to which to remove the specified attributes.
    ///
    /// - Returns: Returns self. Useful if you wish to chain multiple commands together
    func removingAttributes(_ attrs: [TextAttribute.Style],
                            in inRange: Range<String.UTF16View.Index>? = nil) -> NSAttributedString {
        let string = mutable
        string.removeAttributes(attrs, in: inRange)
        return NSAttributedString(attributedString: string)
    }
    
    /// Removes the given TextAttribute from each occurence of the provided String in the specified range.
    /// - Parameters:
    ///   - attr: The TextAttribute that should be removed.
    ///   - aString: The sub string which to remove the attribute from.
    ///   - opts: The options used by the enumeration. For possible values, see String.CompareOptions.
    ///   - inRange: The range of characters to which to remove the TextAttributes from.
    ///
    /// - Returns: Returns self. Useful if you wish to chain multiple commands together
    func removingAttribute(_ attr: TextAttribute.Style,
                           fromOccurencesOfString aString: String,
                           options opts: String.CompareOptions = [],
                           in inRange: Range<String.UTF16View.Index>? = nil) -> NSAttributedString {
        return removingAttributes([attr], fromOccurencesOfString: aString, options: opts, in: inRange)
    }
    
    /// Removes the given TextAttributes from each occurence of the provided String in the specified range.
    /// - Parameters:
    ///   - attrs: The TextAttributes that should be removed.
    ///   - aString: The sub string which to remove the attributes from.
    ///   - opts: The options used by the enumeration. For possible values, see String.CompareOptions.
    ///   - inRange: The range of characters to which to remove the TextAttributes from.
    ///
    /// - Returns: Returns self. Useful if you wish to chain multiple commands together
    func removingAttributes(_ attrs: [TextAttribute.Style],
                            fromOccurencesOfString aString: String,
                            options opts: String.CompareOptions = [],
                            in inRange: Range<String.UTF16View.Index>? = nil) -> NSAttributedString {
        let string = mutable
        string.removeAttributes(attrs, fromOccurencesOfString: aString, options: opts, in: inRange)
        return NSAttributedString(attributedString: string)
    }
}

public extension NSAttributedString {
    /// Maps attributed substrings with attribute name
    /// - Parameters:
    ///   - attrName: the attribute name
    ///   - block: the block to perform for each substring
    /// - Returns: the mapped strings
    func map(_ attrName: NSAttributedString.Key, using block: (String) -> String) -> [String] {
        var subStrs:[String] = []
        let range = NSRange(location: 0, length: length)
        enumerateAttribute(attrName, in: range, options: []) { attribute, range, stop in
            subStrs.append(block(attributedSubstring(from: range).string))
        }
        return subStrs
    }
}

public extension NSAttributedString {
    /// Adds `.link` attribute keys to all recognized URLs in the attributed string
    /// - Returns: the updated URL containing the link attributes
    func linky() -> NSAttributedString {
        let attributed = self.mutableCopy() as! NSMutableAttributedString
        let string = attributed.string
        
        guard let detector = try? NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue) else { return self }
        let matches = detector.matches(in: string, options: [], range: NSRange(location: 0, length: string.utf16.count))
        
        for match in matches {
            guard let range = Range(match.range, in: string) else { continue }
            let urlStr = string[range]
            if urlStr.hasPrefix("https"), let url = URL(string: String(urlStr)) {
                attributed.addAttributes([.link(url)], in: range)
            } else if urlStr.hasPrefix("http"), let url = URL(string: String(urlStr)) {
                attributed.addAttributes([.link(url)], in: range)
            } else {
                if let url = URL(string: "https://" + String(urlStr)) {
                    attributed.addAttributes([.link(url)], in: range)
                }
            }
        }
        return attributed
    }
}
