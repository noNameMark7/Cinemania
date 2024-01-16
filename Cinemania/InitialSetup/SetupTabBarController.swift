import UIKit

final class SetupTabBarController {
    static func asRootViewController(in window: UIWindow) {
        let tabBarController = UITabBarController()
        tabBarController.tabBar.tintColor = .label
        
        // Define the font attributes for the tab bar titles
        let titleAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.customFont(.comfortaaMedium, ofSize: 12) as Any
        ]
        
        // Apply the font attributes to all tab bar items
        UITabBarItem.appearance().setTitleTextAttributes(titleAttributes, for: .normal)
        
        let homeViewController = HomeViewController()
        homeViewController.view.backgroundColor = .systemBackground
        homeViewController.title = "Top Trending"
        
        let homeNavigationController = UINavigationController(rootViewController: homeViewController)
        homeNavigationController.tabBarItem = UITabBarItem(
            title: "Movies and TV Shows",
            image: UIImage(systemName: "house"),
            tag: 0
        )
        
        let savedViewController = SavedViewController()
        savedViewController.view.backgroundColor = .systemBackground
        savedViewController.title = "Saved"
        
        let savedNavigationController = UINavigationController(rootViewController: savedViewController)
        savedNavigationController.tabBarItem = UITabBarItem(
            title: "Saved",
            image: UIImage(systemName: "arrow.down.to.line"),
            tag: 1
        )
        
        // Apply the font attributes to all navigationController titles
        UINavigationBar.appearance().titleTextAttributes = [
            NSAttributedString.Key.font: UIFont.customFont(.comfortaaSemiBold, ofSize: 16) as Any
        ]
        
        tabBarController.viewControllers = [
            homeNavigationController,
            savedNavigationController
        ]
        
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
    }
}
