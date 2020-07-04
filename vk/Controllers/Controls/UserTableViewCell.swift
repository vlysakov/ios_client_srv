import UIKit

class UserTableViewCell: UITableViewCell {
    
    // MARK: Overrides initializer
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureUI()
    }
    
    public func set(id: Int, name: String, url: String?) {
        self.id = id
        self.userView.url = url
        self.userView.name = name 
    }

    //MARK: Private properties
    public var id: Int?
    
    let userView: UserViewControl = UserViewControl()
    //MARK: Private methods
    private func configureUI() {
        contentView.addSubview(userView)
        userView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint .activate([
            userView.leftAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leftAnchor),
            userView.rightAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.rightAnchor),
            userView.centerYAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.centerYAnchor)

        ])
    }
    
}
