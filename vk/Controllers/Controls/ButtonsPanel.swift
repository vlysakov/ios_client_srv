import UIKit

class ButtonsPanel: UIStackView {
    
    var buttons = [UIButton]()
    
    convenience init(count: Int) {
        self.init()
        self.buttons = Array(repeating: UIButton(), count: count)
        self.configureUI()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        configureUI()
    }
    
    private func configureUI() {
        self.buttons = Array(repeating: UIButton(), count: 2)
        guard buttons.count > 0 else { return }
        axis = .horizontal
        distribution = .fill
        alignment = .fill
        spacing = 8.0
        buttons.forEach { addArrangedSubview($0) }
    }
    
}
