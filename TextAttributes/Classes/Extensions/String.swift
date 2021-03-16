public extension String {
    /// Creates An Attributed String
    /// - Returns: Returns the NSAttributedString instance
    func attributed() -> NSAttributedString {
        return NSAttributedString(string: self)
    }
}
