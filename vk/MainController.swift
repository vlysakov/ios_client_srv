import UIKit

class MainController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print(tabBar.frame.height)
        let newsVC = UIViewController()
        let bColor: UIColor = .white
        newsVC.view.backgroundColor = bColor
        newsVC.title = "News"
        newsVC.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "newsfeed_28"), selectedImage: UIImage(named: "newsfeed_28"))
        let friendsVC = FriendsViewController()
        friendsVC.title = "Friends"
        friendsVC.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "users_28"), selectedImage: UIImage(named: "users_28"))
        let profileVC = UIViewController()
        profileVC.view.backgroundColor = bColor
        profileVC.title = "Profile"
        profileVC.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "user_circle_28"), selectedImage: UIImage(named: "user_circle_28"))
        
        self.viewControllers = [friendsVC, newsVC, profileVC]
        
        print("UserId = \(Session.instance.userId ?? "nil")")
        NetworkService.instance.printFriends()
        NetworkService.instance.printPhotos()
        NetworkService.instance.printGroups()
        NetworkService.instance.printSearchGroups("nikon")
        NetworkService.instance.printUserInfo()

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        var f = tabBar.frame
        f.size.height = f.size.height - 10
        f.origin.y = view.frame.size.height - f.size.height
        tabBar.frame = f
        
    }
    
}
