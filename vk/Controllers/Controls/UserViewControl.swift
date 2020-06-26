import UIKit

class UserViewControl: UIStackView {
    
    enum ViewMode {
        case Simple
        case Detail
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        configureUI()
    }
    
    var viewMode: ViewMode = .Simple
    
    private let nameLabel: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .left
        lbl.font = UIFont.systemFont(ofSize: 14)
        return lbl
    }()
    var name: String = "" {
        didSet {
            nameLabel.text = name
        }
    }
    
    let avatarImageView: AvatarImageView = {
        let iv = AvatarImageView()
        iv.shadowOpacity = 15
        iv.shadowRadius = 3
        iv.image = UIImage(named: "help_circle_28")
        iv.height = 48
        return iv
    }()
    var url: String? {
        didSet {
            avatarImageView.url = url
        }
    }
    
    
    private func configureUI() {
        axis = .horizontal
        spacing = 8.0
        distribution = .fill
        alignment = .fill
        addArrangedSubview(avatarImageView)
        switch viewMode {
        case .Simple:
            addArrangedSubview(nameLabel)
        case .Detail:
            print ("detail")
        }
    }

}
