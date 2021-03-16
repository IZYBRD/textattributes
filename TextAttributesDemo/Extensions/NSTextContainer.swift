import UIKit

internal extension NSTextContainer {
    /// returns the tapped location offset based on the alignment and label insets
    func insetLocation(_ location: CGPoint, in label: UILabel, using layoutManager: NSLayoutManager) -> CGPoint {
        // account for text alignment and insets
        let textBoundingBox = layoutManager.usedRect(for: self)
        let alignmentOffset = label.textAlignment.offset

        // returns the location offset based on the content insets and text alignments
        let xOffset = ((label.bounds.size.width - textBoundingBox.size.width) * alignmentOffset) - textBoundingBox.origin.x
        let yOffset = ((label.bounds.size.height - textBoundingBox.size.height) * alignmentOffset) - textBoundingBox.origin.y
        return CGPoint(x: location.x - xOffset, y: location.y - yOffset)
    }
    
    /// returns the last character index in the tapped line
    func lastCharacterIndex(_ location: CGPoint, in label: UILabel, using layoutManager: NSLayoutManager) -> Int {
        let lineSpacing = (label.attributedText?.paragraphStyle.lineSpacing ?? 0)
        let lineTapped = Int(ceil(location.y / (label.font.lineHeight + lineSpacing))) - 1

        let rightMostPointInLine = CGPoint(x: label.bounds.size.width, y: (label.font.lineHeight + lineSpacing) * CGFloat(lineTapped))
        return layoutManager.glyphIndex(for: rightMostPointInLine, in: self, fractionOfDistanceThroughGlyph: nil)
    }
}

private extension NSAttributedString {
    var paragraphStyle: NSParagraphStyle {
        guard let paragraphStyle = attribute(.paragraphStyle, at: 0, longestEffectiveRange: nil, in: NSRange(location: 0, length: length)) as? NSParagraphStyle else { return .default }
        return paragraphStyle
    }
}

private extension NSTextAlignment {
    var offset: CGFloat {
        switch self {
        case .left, .natural, .justified:
            return 0.0
        case .center:
            return 0.5
        case .right:
            return 1.0
        @unknown default:
            return 0.0
        }
    }
}
