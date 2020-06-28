import UIKit

class MainController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let profileVC = UserProfileViewController()
        profileVC.view.backgroundColor = traitCollection.userInterfaceStyle == .dark ? .black : .white
        profileVC.title = "Profile"
        profileVC.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "user_circle_28"), selectedImage: UIImage(named: "user_circle_28"))

        self.viewControllers = [UINavigationController(rootViewController: profileVC)]
        
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
