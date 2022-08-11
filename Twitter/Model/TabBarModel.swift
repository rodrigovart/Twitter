//
//  TabBarModel.swift
//  Twitter
//
//  Created by Rodrigo Vart on 10/08/22.
//

import UIKit

struct TabBarNavigationView {
    var navs: [NavigationView] = []
    
    init() {
        navs.append(NavigationView(controller: FeedViewController(), image: UIImage(named: "home_unselected")!))
        navs.append(NavigationView(controller: ExploreViewController(), image: UIImage(named: "search_unselected")!))
        navs.append(NavigationView(controller: NotificationViewControlller(), image: UIImage(named: "like_unselected")!))
        navs.append(NavigationView(controller: MessageViewController(), image: UIImage(named: "ic_mail_outline_white_2x-1")!))
    }
}

struct NavigationView {
    var controller: UIViewController
    var image: UIImage
}
