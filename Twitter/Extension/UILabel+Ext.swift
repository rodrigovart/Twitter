//
//  UILabel+Ext.swift
//  Twitter
//
//  Created by Rodrigo Vart on 12/08/22.
//

import UIKit

extension UILabel {
    func attributedString(_ str1: String, _ str2: String) {
        let attributedTitle = NSMutableAttributedString(string: str1, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16),
                                                                                 NSAttributedString.Key.foregroundColor: UIColor.white])
        attributedTitle.append(NSAttributedString(string: str2, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16),
                                                                           NSAttributedString.Key.foregroundColor: UIColor.white]))
        attributedText = attributedTitle
    }
}
