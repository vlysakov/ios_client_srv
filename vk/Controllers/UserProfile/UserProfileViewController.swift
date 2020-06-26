import UIKit

protocol UserProfileDisplayLogic: class {
    func displayData(viewModel: UserProfile.Model.ViewModel)
}

class UserProfileViewController: UIViewController, UserProfileDisplayLogic {
    var interactor: UserProfileBusinessLogic?
    var router: (NSObjectProtocol & UserProfileRoutingLogic & UserProfileDataPassing)?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        let viewController = self
        let interactor = UserProfileInteractor()
        let presenter = UserProfilePresenter()
        let router = UserProfileRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    // MARK: Routing
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        interactor?.makeRequest(request: UserProfile.Model.Request.getOwner)
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        view.backgroundColor = traitCollection.userInterfaceStyle == .dark ? .black : .white
    }
    
    let userView: UserViewControl = UserViewControl()
    private func configureUI() {
        view.backgroundColor = traitCollection.userInterfaceStyle == .dark ? .black : .white
        let sv = UIScrollView()
        view.addSubview(sv)
        sv.fillSuperview()
        let stv1 = UIStackView()
        stv1.axis = .vertical
        stv1.spacing = 8.0
        stv1.distribution = .fill
        stv1.alignment = .fill
        stv1.addArrangedSubview(userView)
        stv1.addArrangedSubview(getButtonsPanel())
        stv1.addArrangedSubview(UIView())
        sv.addSubview(stv1)
        stv1.fillSuperview(padding: UIEdgeInsets(top: 4, left: .zero, bottom: .zero, right: .zero))
        NSLayoutConstraint .activate([
            stv1.widthAnchor.constraint(equalTo: sv.widthAnchor),
            stv1.heightAnchor.constraint(equalToConstant: view.frame.height+200)
        ])
    }
    
    private func getButtonsPanel() -> ButtonsPanel {
        let bp = ButtonsPanel(count: 2)
        bp.buttons[0].setImage(UIImage(named: "newsfeed_28"), for: .normal)
        bp.buttons[0].setTitle("Друзья", for: .normal)
//        bp.buttons[0].titleLabel?.text = "12345"
        bp.buttons[1].setImage(UIImage(named: "users3_28"), for: .normal)
        bp.buttons[1].setTitle("Сообщества", for: .normal)
        
        return bp
    }
    
    // MARK: Do something
    
    //@IBOutlet weak var nameTextField: UITextField!
    
    
    func displayData(viewModel: UserProfile.Model.ViewModel) {
        switch viewModel {
        case .displayOwner(let owner):
            userView.name = owner.fullName
            userView.url = owner.photoUrlString
        }
    }
}
