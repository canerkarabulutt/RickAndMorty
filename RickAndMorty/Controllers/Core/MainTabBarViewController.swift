//
//  ViewController.swift
//  RickAndMorty
//
//  Created by Caner Karabulut on 12.12.2023.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        setUpTabBar()
    }
    
    private func setUpTabBar() {
        let charactersVC = CharacterViewController()
        let locationsVC = LocationViewController()
        let episodesVC = EpisodeViewController()
        let settingsVC = SettingsViewController()
        
        viewControllers = [
            configureViewController(rootViewController: charactersVC, title: "Characters", image: "person"),
            configureViewController(rootViewController: locationsVC, title: "Locations", image: "globe"),
            configureViewController(rootViewController: episodesVC, title: "Episodes", image: "tv"),
            configureViewController(rootViewController: settingsVC, title: "Settings", image: "gear")
        ]
    }
    private func configureViewController(rootViewController: UIViewController, title: String, image: String) -> UINavigationController{
        let appearance = UINavigationBarAppearance()
        appearance.configureWithDefaultBackground()

        let controller = UINavigationController(rootViewController: rootViewController)
        rootViewController.title = title
        controller.tabBarItem.title = title
        controller.navigationBar.prefersLargeTitles = true
        controller.navigationItem.largeTitleDisplayMode = .automatic
        controller.tabBarItem.image = UIImage(systemName: image)
        return controller
    }
}

