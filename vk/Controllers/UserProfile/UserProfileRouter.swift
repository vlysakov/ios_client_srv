import UIKit

@objc protocol UserProfileRoutingLogic {
    func navigateToGroup(source: UserProfileViewController, destination: GroupViewController)
    func navigateToFriends(source: UserProfileViewController, destination: FriendsViewController)
}

protocol UserProfileDataPassing {
    var dataStore: UserProfileDataStore? { get }
}

class UserProfileRouter: NSObject, UserProfileRoutingLogic, UserProfileDataPassing {
    weak var viewController: UserProfileViewController?
    var dataStore: UserProfileDataStore?
    
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
    
    func navigateToGroup(source: UserProfileViewController, destination: GroupViewController) {
      source.show(destination, sender: nil)
    }
    
    func navigateToFriends(source: UserProfileViewController, destination: FriendsViewController) {
      source.show(destination, sender: nil)
    }
    
    // MARK: Passing data
    
    //func passDataToSomewhere(source: UserProfileDataStore, destination: inout SomewhereDataStore)
    //{
    //  destination.name = source.name
    //}
}
