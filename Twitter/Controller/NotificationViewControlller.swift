//
//  NotificationViewControlller.swift
//  Twitter
//
//  Created by Rodrigo Vart on 10/08/22.
//

import UIKit

class NotificationViewControlller: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    func setupUI() {
        view.backgroundColor = .white
        navigationItem.title = "Notifications"
    }
}
