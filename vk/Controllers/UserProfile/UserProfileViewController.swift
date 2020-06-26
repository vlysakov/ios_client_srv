import UIKit

protocol UserProfileDisplayLogic: class {
    func displayData(viewModel: UserProfile.Model.ViewModel)
}

class UserProfileViewController: UIViewController, UserProfileDisplayLogic {
    var interactor: UserProfileBusinessLogic?
    var router: (NSObjectProtocol & UserProfileRoutingLogic & UserProfileDataPassing)?
    
    private var imageModel = UserProfile.ImageViewModel.init(imageUrls: [])
    
    lazy var layout = GalleryFlowLayout()
    lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.register(ThumbCell.self, forCellWithReuseIdentifier: ThumbCell.reuseIdentifier)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.dataSource = self
        cv.backgroundColor = traitCollection.userInterfaceStyle == .dark ? .black : .white
        return cv
    }()
    
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
        interactor?.makeRequest(request: UserProfile.Model.Request.getImages)
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
        stv1.addArrangedSubview(collectionView)
        sv.addSubview(stv1)
        stv1.fillSuperview(padding: UIEdgeInsets(top: 4, left: .zero, bottom: .zero, right: .zero))
        NSLayoutConstraint .activate([
            stv1.widthAnchor.constraint(equalTo: sv.widthAnchor),
            stv1.heightAnchor.constraint(equalToConstant: view.frame.height+200)
        ])
    }
    
    private func getButtonsPanel() -> UIStackView {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.distribution = .fillEqually
        sv.alignment = .center
        let b1 = UIButton()
        b1.setImage(UIImage(named: "users_28"), for: .normal)
        b1.setTitle(" Друзья", for: .normal)
        b1.setTitleColor(.systemBlue, for: .normal)
        b1.titleLabel?.font = .systemFont(ofSize: 14)
        sv.addArrangedSubview(b1)
        let b2 = UIButton()
        b2.setImage(UIImage(named: "users3_28"), for: .normal)
        b2.setTitle(" Сообщества", for: .normal)
        b2.setTitleColor(.systemBlue, for: .normal)
        b2.titleLabel?.font = .systemFont(ofSize: 14)
        sv.addArrangedSubview(b2)
        b1.widthAnchor.constraint(equalToConstant: view.frame.width / 2).isActive = true
        b1.heightAnchor.constraint(equalToConstant: 32).isActive = true
        b2.widthAnchor.constraint(equalToConstant: view.frame.width / 2).isActive = true
        b2.heightAnchor.constraint(equalToConstant: 32).isActive = true
        return sv
    }
    
    func displayData(viewModel: UserProfile.Model.ViewModel) {
        switch viewModel {
        case .displayOwner(let owner):
            userView.name = owner.fullName
            userView.url = owner.photoUrlString
        case .displayImages(let images):
            imageModel = images
        }
    }
}

extension UserProfileViewController: UICollectionViewDataSource {
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        updateLayout(view.frame.size)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        updateLayout(size)
    }
    
    private func updateLayout(_ size:CGSize) {
        if size.width > size.height {
            layout.columns = 4
        } else {
            layout.columns = 3
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageModel.imageUrls.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:ThumbCell = collectionView.dequeueReusableCell(withReuseIdentifier: ThumbCell.reuseIdentifier, for: indexPath) as! ThumbCell
        cell.urlString = imageModel.imageUrls[indexPath.item]
        return cell
    }
    
    
}
