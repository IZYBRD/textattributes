public extension UILabel {
    func glyphIndex(at location: CGPoint) -> Int? {
        
        // the text container
        let textContainer = NSTextContainer(size: bounds.size)
        textContainer.lineFragmentPadding = 0.0
        textContainer.lineBreakMode = lineBreakMode
        textContainer.maximumNumberOfLines = numberOfLines

        // Configure NSLayoutManager and add the text container
        let layoutManager = NSLayoutManager()
        layoutManager.addTextContainer(textContainer)

        // Configure NSTextStorage and apply the layout manager
        let textStorage = NSTextStorage(attributedString: attributedText ?? NSAttributedString())
        textStorage.addLayoutManager(layoutManager)

        // the location offset based on the content insets and text alignments
        let insetLocation = textContainer.insetLocation(location, in: self, using: layoutManager)
        
        // figure out which character was tapped
        let characterIndex = layoutManager.glyphIndex(for: insetLocation, in: textContainer, fractionOfDistanceThroughGlyph: nil)

        // figure out how many characters are in the string up to and including the line tapped
        let lastCharacterIndex = textContainer.lastCharacterIndex(location, in: self, using: layoutManager)

        // ignore taps past the end of the current line
        return characterIndex <= lastCharacterIndex ? characterIndex : lastCharacterIndex
    }
}
