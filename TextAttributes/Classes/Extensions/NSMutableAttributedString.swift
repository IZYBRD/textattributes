public extension NSMutableAttributedString {
    /// Adds the given TextAttribute to the characters in the specified range.
    /// - Parameters:
    ///   - attr: The TextAttribute that should be applied.
    ///   - inRange: The range of characters to which the specified attribute apply.
    ///
    /// - Returns: Returns self. Useful if you wish to chain multiple commands together
    @discardableResult func addAttribute(_ attr: TextAttribute,
                                         in inRange: Range<String.UTF16View.Index>? = nil) -> NSMutableAttributedString {
        return addAttributes([attr], in: inRange)
    }
    
    /// Adds the given collection of attributes to the characters in the specified range.
    /// - Parameters:
    ///   - attrs: The TextAttribute that should be applied.
    ///   - inRange: The range of characters to which the specified attributes apply.
    ///
    /// - Returns: Returns self. Useful if you wish to chain multiple commands together
    @discardableResult func addAttributes(_ attrs: [TextAttribute],
                                          in inRange: Range<String.UTF16View.Index>? = nil) -> NSMutableAttributedString {
        let reduced = attrs.reduce(into: [NSAttributedString.Key: Any]()) { result, attribute in
            switch attribute {
            case .textAlignment, .lineSpacing, .lineBreakMode:
                let existingStyle = (result[attribute.key] as? NSParagraphStyle) ?? NSParagraphStyle.default
                let value = attribute.value as! NSParagraphStyle
                result[attribute.key] = existingStyle + value
                return
            // switch for each other type so when new cases are added we don't forget to update this
            case .backgroundColor:
                break
            case .font:
                break
            case .foregroundColor:
                break
            case .kern:
                break
            case .shadow:
                break
            case .strikethroughColor:
                break
            case .strikethroughStyle:
                break
            case .underlineColor:
                break
            case .underlineStyle:
                break
            case .link:
                break
            case .baselineOffset:
                break
            }
            result[attribute.key] = attribute.value
        }
        addAttributes(reduced, range: inRange)
        return self
    }
    
    /// Adds the given TextAttribute to each occurence of the provided String in the specified range.
    /// - Parameters:
    ///   - attr: The TextAttribute that should be applied.
    ///   - aString: The sub String which to add attribute to.
    ///   - opts: The options used by the enumeration. For possible values, see String.CompareOptions.
    ///   - inRange: The range of characters to which the specified attribute apply.
    ///
    /// - Returns: Returns self. Useful if you wish to chain multiple commands together
    @discardableResult func addAttribute(_ attr: TextAttribute,
                                         toOccurencesOfString aString: String,
                                         options opts: String.CompareOptions = [],
                                         in inRange: Range<String.UTF16View.Index>? = nil) -> NSMutableAttributedString {
        return addAttributes([attr], toOccurencesOfString: aString, options: opts, in: inRange)
    }
    
    /// Adds the given TextAttributes to each occurence of the provided String in the specified range.
    /// - Parameters:
    ///   - attrs: The TextAttributes that should be applied.
    ///   - aString: The sub String which to add the attributes to.
    ///   - opts: The options used by the enumeration. For possible values, see String.CompareOptions.
    ///   - inRange: The range of characters to which the specified attributes apply.
    ///
    /// - Returns: Returns self. Useful if you wish to chain multiple commands together
    @discardableResult func addAttributes(_ attrs: [TextAttribute],
                                          toOccurencesOfString aString: String,
                                          options opts: String.CompareOptions = [],
                                          in inRange: Range<String.UTF16View.Index>? = nil) -> NSMutableAttributedString {
        enumerateOccurrences(of: aString, options: opts, in: inRange) { attributedString, range in
            attributedString.addAttributes(attrs)
        }
        return self
    }
    
    /// Removes the `TextAttribute.Style` from the `NSMutableAttributedString`
    /// - Parameters:
    ///   - attr: The TextAttribute that should be removed.
    ///   - inRange: The range of characters to which to remove the specified attribute.
    ///
    /// - Returns: Returns self. Useful if you wish to chain multiple commands together
    @discardableResult func removeAttribute(_ attr: TextAttribute.Style,
                                            in inRange: Range<String.UTF16View.Index>? = nil) -> NSMutableAttributedString {
        return removeAttributes([attr], in: inRange)
    }

    /// Removes the `TextAttribute.Styles` from the `NSMutableAttributedString`
    /// - Parameters:
    ///   - attrs: The TextAttributes that should be removed.
    ///   - inRange: The range of characters to which to remove the specified attribute.
    ///
    /// - Returns: Returns self. Useful if you wish to chain multiple commands together
    @discardableResult func removeAttributes(_ attrs: [TextAttribute.Style],
                                             in inRange: Range<String.UTF16View.Index>? = nil) -> NSMutableAttributedString {
        attrs.forEach { attr in
            enumerateAttribute(attr, in: inRange) { attribute, range in
                removeAttribute(attr.key, range: range)
            }
        }
        return self
    }
    
    /// Removes the given TextAttribute from each occurence of the provided String in the specified range.
    /// - Parameters:
    ///   - attr: The TextAttribute that should be removed.
    ///   - aString: The sub string which to remove the attribute from.
    ///   - opts: The options used by the enumeration. For possible values, see String.CompareOptions.
    ///   - inRange: The range of characters to which to remove the TextAttribute from.
    ///
    /// - Returns: Returns self. Useful if you wish to chain multiple commands together
    @discardableResult func removeAttribute(_ attr: TextAttribute.Style,
                                            fromOccurencesOfString aString: String,
                                            options opts: String.CompareOptions = [],
                                            in inRange: Range<String.UTF16View.Index>? = nil) -> NSAttributedString {
        return removeAttributes([attr], fromOccurencesOfString: aString, options: opts, in: inRange)
    }
    
    /// Removes the given TextAttributes from each occurence of the provided String in the specified range.
    /// - Parameters:
    ///   - attrs: The TextAttributes that should be removed.
    ///   - aString: The sub string which to remove the attributes from.
    ///   - opts: The options used by the enumeration. For possible values, see String.CompareOptions.
    ///   - inRange: The range of characters to which to remove the TextAttributes from.
    ///
    /// - Returns: Returns self. Useful if you wish to chain multiple commands together
    @discardableResult func removeAttributes(_ attrs: [TextAttribute.Style],
                                             fromOccurencesOfString aString: String,
                                             options opts: String.CompareOptions = [],
                                             in inRange: Range<String.UTF16View.Index>? = nil) -> NSAttributedString {
        enumerateOccurrences(of: aString, options: opts, in: inRange) { attributedString, range in
            attributedString.removeAttributes(attrs)
        }
        return self
    }
}
