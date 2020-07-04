import UIKit

protocol FriendsDisplayLogic: class
{
    func displayData(viewModel: Friends.Model.ViewModel)
}

class FriendsViewController: UIViewController, FriendsDisplayLogic
{
    var interactor: FriendsBusinessLogic?
    var router: (NSObjectProtocol & FriendsRoutingLogic & FriendsDataPassing)?
    private var viewModel = FriendViewModel.init(cells: [])
    
    private var tableView: UITableView = UITableView()
    
    // MARK: Object lifecycle
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)
    {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    private func setup()
    {
        let viewController = self
        let interactor = FriendsInteractor()
        let presenter = FriendsPresenter()
        let router = FriendsRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    // MARK: Routing
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }
    
    // MARK: View lifecycle
    override func viewDidLoad()
    {
        super.viewDidLoad()
        view.backgroundColor = traitCollection.userInterfaceStyle == .dark ? .black : .white
        configureUI()
        interactor?.makeRequest(request: Friends.Model.Request.getFriends)
        interactor?.makeRequest(request: Friends.Model.Request.getOwner)
    }
    
    private func configureUI() {
        navigationController?.hidesBarsOnSwipe = true
        tableView.rowHeight = 56
        tableView.separatorStyle = .none
        tableView.sectionHeaderHeight = 1
        tableView.sectionFooterHeight = 1
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UserTableViewCell.self, forCellReuseIdentifier: "UserTableViewCell")
        self.view.addSubview(tableView)
        tableView.fillSuperview()
    }
    
    func displayData(viewModel: Friends.Model.ViewModel) {
        switch viewModel {
        case .displayFriends(let model):
            self.viewModel = model
            tableView.reloadData()
        case .displayOwner(let owner):
                let iv = AvatarImageView()
                iv.url = owner.photoUrlString
                iv.shadowOpacity = 15
                iv.shadowRadius = 3
                iv.sizeToFit()
                iv.height = (self.navigationController?.toolbar.frame.height ?? 0) - 9
                self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: iv)
                iv.fillSuperview()
        }
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        view.backgroundColor = traitCollection.userInterfaceStyle == .dark ? .black : .white
    }
}

//MARK: UITableViewDelegate, UITableViewDataSource
extension FriendsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserTableViewCell", for: indexPath) as! UserTableViewCell
        let item = viewModel.cells[indexPath.row]
        cell.set(id: item.friendId, name: item.fullName, url: item.photoUrl)
        return cell
    }
    
}
