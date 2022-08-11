//
//  ExploreViewController.swift
//  Twitter
//
//  Created by Rodrigo Vart on 10/08/22.
//

import UIKit

class ExploreViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    func setupUI() {
        view.backgroundColor = .white
        navigationItem.title = "Explore"
    }
}
