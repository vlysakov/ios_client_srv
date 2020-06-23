import UIKit

protocol FriendsDisplayLogic: class
{
    func displaySomething(viewModel: Friends.Something.ViewModel)
}

class FriendsViewController: UIViewController, FriendsDisplayLogic
{
    var interactor: FriendsBusinessLogic?
    var router: (NSObjectProtocol & FriendsRoutingLogic & FriendsDataPassing)?
    
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
        doSomething()
    }
    
    // MARK: Do something
    
    //@IBOutlet weak var nameTextField: UITextField!
    
    func doSomething()
    {
        let request = Friends.Something.Request()
        interactor?.doSomething(request: request)
    }
    
    func displaySomething(viewModel: Friends.Something.ViewModel)
    {
        //nameTextField.text = viewModel.name
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        view.backgroundColor = traitCollection.userInterfaceStyle == .dark ? .black : .white
    }
}
