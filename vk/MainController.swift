import UIKit

class MainController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let newsVC = UIViewController()
        let bColor: UIColor = traitCollection.userInterfaceStyle == .dark ? .black : .white
        newsVC.view.backgroundColor = bColor
        newsVC.title = "News"
        newsVC.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "newsfeed_28"), selectedImage: UIImage(named: "newsfeed_28"))
        let friendsVC = FriendsViewController()
        friendsVC.title = "Друзья"
        friendsVC.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "users_28"), selectedImage: UIImage(named: "users_28"))
        let profileVC = UserProfileViewController()
        profileVC.view.backgroundColor = bColor
        profileVC.title = "Profile"
        profileVC.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "user_circle_28"), selectedImage: UIImage(named: "user_circle_28"))
        
        let groupsVC = GroupViewController()
        groupsVC.view.backgroundColor = bColor
        groupsVC.title = "Сообщества"
        groupsVC.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "users3_28"), selectedImage: UIImage(named: "users3_28"))
        
        self.viewControllers = [UINavigationController(rootViewController: groupsVC),
                                UINavigationController(rootViewController: friendsVC),
                                UINavigationController(rootViewController: profileVC)]
        
        print("UserId = \(Session.instance.userId ?? "nil")")

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        var f = tabBar.frame
        f.size.height = f.size.height - 10
        f.origin.y = view.frame.size.height - f.size.height
        tabBar.frame = f
        
    }
    
}
