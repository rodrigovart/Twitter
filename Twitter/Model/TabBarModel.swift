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
        navs.append(NavigationView(controller: FeedViewController(), image: UIImage(named: "casa")!.resize(CGSize(width: 32, height: 32))))
        navs.append(NavigationView(controller: ExploreViewController(), image: UIImage(named: "search")!.resize(CGSize(width: 32, height: 30))))
        navs.append(NavigationView(controller: NotificationViewControlller(), image: UIImage(named: "bell")!.resize(CGSize(width: 40, height: 40))))
        navs.append(NavigationView(controller: MessageViewController(), image: UIImage(named: "ic_mail_outline_white_2x-1")!.resize(CGSize(width: 32, height: 32))))
    }
}

struct NavigationView {
    var controller: UIViewController
    var image: UIImage
}
