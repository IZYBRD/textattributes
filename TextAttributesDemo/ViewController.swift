import TextAttributes

class ViewController: UIViewController {
    private let label = UILabel()
    private let string = """
    The quick brown fox jumped over the lazy brown dog
    Jived fox nymph grabs quick waltz.
    Glib jocks quiz nymph to vex dwarf.
    Sphinx of black quartz, judge my vow.
    How vexingly quick daft zebras jump!
    The five boxing wizards jump quickly.
    Pack my box with five dozen liquor jugs.
    """.attributed().addingAttributes([.font(.boldSystemFont(ofSize: 22.0)), .lineSpacing(28.0), .kern(2.0), .textAlignment(.center)])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        label.numberOfLines = 0        
        label.attributedText = string
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let point = touches.first?.location(in: label) else { return }
        guard let idx = label.glyphIndex(at: point) else { return }
        let start = string.string.index(string.string.startIndex, offsetBy: idx)
        let end = string.string.index(string.string.startIndex, offsetBy: idx + 1)
        label.attributedText = label.attributedText?.addingAttributes([.underlineStyle(.single), .underlineColor(.red)], in: start..<end)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let point = touches.first?.location(in: label) else { return }
        guard let idx = label.glyphIndex(at: point) else { return }
        let start = string.string.index(string.string.startIndex, offsetBy: idx)
        let end = string.string.index(string.string.startIndex, offsetBy: idx + 1)
        label.attributedText = label.attributedText?.addingAttributes([.underlineStyle(.single), .underlineColor(.red)], in: start..<end)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        label.attributedText = label.attributedText?.removingAttributes([.underlineColor, .underlineStyle])
    }
}
