import UIKit

@objc protocol FriendsRoutingLogic {
    //func routeToSomewhere(segue: UIStoryboardSegue?)
}

protocol FriendsDataPassing {
    var dataStore: FriendsDataStore? { get }
}

class FriendsRouter: NSObject, FriendsRoutingLogic, FriendsDataPassing {
    weak var viewController: FriendsViewController?
    var dataStore: FriendsDataStore?
    
    // MARK: Routing
    
    //func routeToSomewhere(segue: UIStoryboardSegue?)
    //{
    //  if let segue = segue {
    //    let destinationVC = segue.destination as! SomewhereViewController
    //    var destinationDS = destinationVC.router!.dataStore!
    //    passDataToSomewhere(source: dataStore!, destination: &destinationDS)
    //  } else {
    //    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    //    let destinationVC = storyboard.instantiateViewController(withIdentifier: "SomewhereViewController") as! SomewhereViewController
    //    var destinationDS = destinationVC.router!.dataStore!
    //    passDataToSomewhere(source: dataStore!, destination: &destinationDS)
    //    navigateToSomewhere(source: viewController!, destination: destinationVC)
    //  }
    //}
    
    // MARK: Navigation
    
    //func navigateToSomewhere(source: FriendsViewController, destination: SomewhereViewController)
    //{
    //  source.show(destination, sender: nil)
    //}
    
    // MARK: Passing data
    
    //func passDataToSomewhere(source: FriendsDataStore, destination: inout SomewhereDataStore)
    //{
    //  destination.name = source.name
    //}
}
