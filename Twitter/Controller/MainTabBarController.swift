//
//  MainTabBarController.swift
//  Twitter
//
//  Created by Rodrigo Vart on 10/08/22.
//

import UIKit

class MainTabBarController: UITabBarController {
    lazy var newTweetButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .white
        button.backgroundColor = .twitterBlue
        button.setImage(UIImage(named: "new_tweet"), for: .normal)
        button.addTarget(self, action: #selector(newTweetTap), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
        setupUI()
    }
    
    func setupTabBar() {
        let navigations = TabBarNavigationView()
        var items: [UINavigationController] = []
        
        navigations.navs.forEach { nav in
            items.append(setupItensTabBar(controller: nav.controller, image: nav.image))
        }
        
        viewControllers = items
    }
    
    func setupItensTabBar(controller: UIViewController, image: UIImage) -> UINavigationController {
        let nav = UINavigationController(rootViewController: controller)
        nav.tabBarItem.image = image
        nav.navigationBar.barTintColor = .white
        return nav
    }
    
    func setupUI() {
        view.addSubview(newTweetButton)
        newTweetButton.anchor(
            bottom: view.safeAreaLayoutGuide.bottomAnchor,
            right: view.rightAnchor,
            paddingBottom: 64,
            paddingRight: 16,
            width: 56,
            height: 56
        )
        newTweetButton.layer.cornerRadius = 56 / 2
    }
    
    @objc func newTweetTap() {
        
    }
}
