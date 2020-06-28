import UIKit

protocol GroupDisplayLogic: class {
    func displayData(viewModel: Group.Model.ViewModel)
}

class GroupViewController: UIViewController, GroupDisplayLogic {
    var interactor: GroupBusinessLogic?
    var router: (NSObjectProtocol & GroupRoutingLogic & GroupDataPassing)?
    
    private var viewModel = Group.GroupViewModel.init(cells: [])
    private var tableView: UITableView = UITableView()
    var searchBar = UISearchBar()
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        interactor?.makeRequest(request: Group.Model.Request.getGroups)
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
        case .displaySearch(let model):
            self.viewModel = model
            tableView.reloadData()
        case .displayOwner(let owner):
            let iv = AvatarImageView()
            iv.url = owner.photoUrlString
            iv.shadowOpacity = 15
            iv.shadowRadius = 3
            iv.sizeToFit()
            iv.height = (self.navigationController?.toolbar.frame.height ?? 0) - 18
            self.navigationItem.rightBarButtonItems = [UIBarButtonItem(customView: iv),
                                                       UIBarButtonItem(barButtonSystemItem: .add, target: nil, action: nil)]
            
            iv.fillSuperview()
        }
    }

    private func configureUI() {
        title = "Сообщества"
        view.backgroundColor = traitCollection.userInterfaceStyle == .dark ? .black : .white
        navigationController?.hidesBarsOnSwipe = true
        searchBar.delegate = self
        searchBar.placeholder = "Поиск"
        searchBar.sizeToFit()
        searchBar.showsCancelButton = true
        searchBar.searchBarStyle = .minimal
        tableView.rowHeight = 56
        tableView.separatorStyle = .none
        tableView.sectionHeaderHeight = 1
        tableView.sectionFooterHeight = 1
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UserTableViewCell.self, forCellReuseIdentifier: "UserTableViewCell")
        self.view.addSubview(tableView)
        tableView.fillSuperview()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "search_28"), style: .plain, target: self, action: #selector(searchButtonPressed(_:)))
    }
    
    @objc func searchButtonPressed(_ sender: Any) {
        showSearchBar()
    }
    
    var titleView: UIView?
    var btnSearch: UIBarButtonItem?
    
    private func showSearchBar() {
        searchBar.text = ""
        searchBar.alpha = 0
        titleView = navigationItem.titleView
        navigationItem.titleView = searchBar
        btnSearch = navigationItem.rightBarButtonItem
        navigationItem.setRightBarButton(nil, animated: true)
        
        UIView .animate(withDuration: 0.5,
                        animations: { self.searchBar.alpha = 1 },
                        completion: { finished in self.searchBar.becomeFirstResponder() }
        )
    }
    
    private func hideSearchBar() {
        navigationItem.setRightBarButton(btnSearch, animated: true)
        titleView?.alpha = 0
        UIView .animate(withDuration: 0.5,
                        animations: {
                            self.navigationItem.titleView = self.titleView
                            self.titleView?.alpha = 1 },
                        completion: { finished in })
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

extension GroupViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        interactor?.makeRequest(request: Group.Model.Request.searchGroups(searchStr: searchText))
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        interactor?.makeRequest(request: Group.Model.Request.getGroups)
        searchBar.endEditing(true)
        hideSearchBar()
    }
}
