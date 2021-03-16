public protocol LabelDelegate: AnyObject {
    func label(_ label: Label, didSelect link: URL)
}
    
public class Label: UILabel {
    public weak var delegate: LabelDelegate?
    
    fileprivate let textContainer = NSTextContainer()
    fileprivate let layoutManager = LayoutManager()
    fileprivate let textStorage   = NSTextStorage()
    
    public override var frame: CGRect {
        didSet {
            var size = bounds.size
            size.width = min(size.width, preferredMaxLayoutWidth)
            size.height = 0
            textContainer.size = size;
        }
    }
    
    public override var attributedText: NSAttributedString! {
        didSet { textStorage.setAttributedString(attributedText) }
    }
    
    public override var numberOfLines: Int {
        didSet { textContainer.maximumNumberOfLines = numberOfLines }
    }
    
    public override var preferredMaxLayoutWidth: CGFloat {
        didSet {
            var size = bounds.size
            size.width = min(size.width, preferredMaxLayoutWidth)
            textContainer.size = size;
        }
    }
    
    public override var bounds: CGRect {
        didSet {
            var size = bounds.size
            size.width = min(size.width, preferredMaxLayoutWidth)
            size.height = 0
            textContainer.size = size;
        }
    }
    
    convenience init() {
        self.init(frame: .zero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        textContainer.lineFragmentPadding = 0
        textContainer.maximumNumberOfLines = numberOfLines
        textContainer.lineBreakMode = lineBreakMode
        textContainer.size = frame.size
        layoutManager.addTextContainer(textContainer)
        textStorage.addLayoutManager(layoutManager)
        isUserInteractionEnabled = true
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func layoutSubviews() {
        super.layoutSubviews()
        textContainer.size = frame.size
    }

    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let point = touches.first?.location(in: self) else { return }
        guard let string = attributedText else { return }
        guard let idx = glyphIndex(at: point) else { return }
        // idx is the selected character index
        // from this we need to get the attributes at this point
        let attributes = string.attributes(at: idx, effectiveRange: nil)
        if let link = attributes[.link] as? URL {
            delegate?.label(self, didSelect: link)
        }
    }
    
    public override func drawText(in rect: CGRect) {
        // Calculate the offset of the text in the view
        let glyphRange = layoutManager.glyphRange(for: textContainer)
        layoutManager.drawBackground(forGlyphRange: glyphRange, at: .zero)
        layoutManager.drawGlyphs(forGlyphRange: glyphRange, at: .zero)
    }
    
    public override func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
        let savedTextContainerSize = textContainer.size
        let savedTextContainerNumberOfLines = textContainer.maximumNumberOfLines
        textContainer.size = bounds.size
        textContainer.maximumNumberOfLines = numberOfLines

        let glyphRange = layoutManager.glyphRange(for: textContainer)
        var textBounds = layoutManager.boundingRect(forGlyphRange: glyphRange, in: textContainer)
        textBounds.origin = bounds.origin
        textBounds.size.width = CGFloat(ceilf(Float(textBounds.size.width)))
        textBounds.size.height = CGFloat(ceilf(Float(textBounds.size.height)))
        
        textContainer.size = savedTextContainerSize
        textContainer.maximumNumberOfLines = savedTextContainerNumberOfLines

        return textBounds
    }
}

/// NSLayoutManager to force the foreground attribute color for .link attributes
fileprivate final class LayoutManager: NSLayoutManager {
    @available(iOS 13.0, *)
    public override func showCGGlyphs(_ glyphs: UnsafePointer<CGGlyph>, positions: UnsafePointer<CGPoint>, count glyphCount: Int, font: UIFont, textMatrix: CGAffineTransform, attributes: [NSAttributedString.Key : Any] = [:], in CGContext: CGContext) {
        defer { super.showCGGlyphs(glyphs, positions: positions, count: glyphCount, font: font, textMatrix: textMatrix, attributes: attributes, in: CGContext); }
        guard let foregroundColor = attributes[.foregroundColor] as? UIColor else {  return }
        CGContext.setFillColor(foregroundColor.cgColor)
    }
    
    public override func showCGGlyphs(_ glyphs: UnsafePointer<CGGlyph>, positions: UnsafePointer<CGPoint>, count glyphCount: Int, font: UIFont, matrix textMatrix: CGAffineTransform, attributes: [NSAttributedString.Key : Any] = [:], in graphicsContext: CGContext) {
        defer { super.showCGGlyphs(glyphs, positions: positions, count: glyphCount, font: font, matrix: textMatrix, attributes: attributes, in: graphicsContext) }
        guard let foregroundColor = attributes[.foregroundColor] as? UIColor else {  return }
        graphicsContext.setFillColor(foregroundColor.cgColor)
    }
}
