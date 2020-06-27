import UIKit

protocol GroupDisplayLogic: class {
    func displayData(viewModel: Group.Model.ViewModel)
}

class GroupViewController: UIViewController, GroupDisplayLogic {
    var interactor: GroupBusinessLogic?
    var router: (NSObjectProtocol & GroupRoutingLogic & GroupDataPassing)?
    
    private var viewModel = Group.GroupViewModel.init(cells: [])
    private var tableView: UITableView = UITableView()
    
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
        let interactor = GroupInteractor()
        let presenter = GroupPresenter()
        let router = GroupRouter()
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
        interactor?.makeRequest(request: Group.Model.Request.getGroups)
        interactor?.makeRequest(request: Group.Model.Request.getOwner(ownerId: nil))
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        view.backgroundColor = traitCollection.userInterfaceStyle == .dark ? .black : .white
    }
    
    
    func displayData(viewModel: Group.Model.ViewModel) {
        switch viewModel {
        case .displayGroups(let model):
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

    
    private func configureUI() {
        view.backgroundColor = traitCollection.userInterfaceStyle == .dark ? .black : .white
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
    
}

//MARK: UITableViewDelegate, UITableViewDataSource
extension GroupViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserTableViewCell", for: indexPath) as! UserTableViewCell
        let item = viewModel.cells[indexPath.row]
        cell.set(id: item.groupId, name: item.name, url: item.photoUrl)
        return cell
    }
    
}
