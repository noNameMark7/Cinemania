import UIKit

// MARK: -  SetupTabBarController

final class SetupTabBarController {
    
    static func asRootViewController(in window: UIWindow) {
        
        let tabBarController = UITabBarController()
        tabBarController.tabBar.tintColor = .label
        
        /// Define the font attributes for the tab bar titles
        
        let titleAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.customFont(.comfortaaSemiBold, ofSize: 12) as Any
        ]
        
        let homeViewController = HomeViewController()
        homeViewController.view.backgroundColor = .systemBackground
        homeViewController.title = "Trending movies and tv shows"
        
        let homeNavigationController = UINavigationController(rootViewController: homeViewController)
        homeNavigationController.tabBarItem = UITabBarItem(
            title: "Trending",
            image: UIImage(systemName: "house"),
            tag: 0
        )
        
        let savedViewController = SavedViewController()
        savedViewController.view.backgroundColor = .systemBackground
        savedViewController.title = "Saved"
        
        let savedNavigationController = UINavigationController(rootViewController: savedViewController)
        savedNavigationController.tabBarItem = UITabBarItem(
            title: "Saved",
            image: UIImage(systemName: "square.and.arrow.down"),
            tag: 1
        )
        
        let searchViewController = SearchViewController()
        searchViewController.view.backgroundColor = .systemBackground
        searchViewController.title = "Search"
        
        let searchNavigationController = UINavigationController(rootViewController: searchViewController)
        searchNavigationController.tabBarItem = UITabBarItem(
            title: "Search",
            image: UIImage(systemName: "magnifyingglass"),
            tag: 3
        )
        
        let settingsViewController = SettingsViewController()
        settingsViewController.view.backgroundColor = .systemBackground
        settingsViewController.title = "Settings"
        
        let settingsNavigationController = UINavigationController(rootViewController: settingsViewController)
        settingsNavigationController.tabBarItem = UITabBarItem(
            title: "Settings",
            image: UIImage(systemName: "gearshape"),
            tag: 2
        )
        
        /// Apply the font attributes to all navigationController titles
        
        UINavigationBar.appearance().titleTextAttributes = [
            NSAttributedString.Key.font: UIFont.customFont(.comfortaaBold, ofSize: 18) as Any
        ]
        
        /// Apply the font attributes to all tab bar items
        
        UITabBarItem.appearance().setTitleTextAttributes(titleAttributes, for: .normal)
        
        tabBarController.viewControllers = [
            homeNavigationController,
            savedNavigationController,
            searchNavigationController,
            settingsNavigationController,
        ]
        
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
    }
}
