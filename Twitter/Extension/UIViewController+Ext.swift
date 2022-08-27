//
//  UIViewController+Ext.swift
//  Twitter
//
//  Created by Rodrigo Vart on 12/08/22.
//

import SwiftMessages
import ProgressHUD

extension UIViewController {
    func showMessage (_ title: String, _ body: String, _ iconText: String, _ theme: Theme) {
        let view = MessageView.viewFromNib(layout: .messageView)
        view.configureTheme(theme)
        view.configureDropShadow()
        view.configureContent(title: title, body: body, iconText: iconText)
        view.layoutMarginAdditions = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        (view.backgroundView as? CornerRoundingView)?.cornerRadius = 10
        view.button?.isHidden = true
        var config = SwiftMessages.defaultConfig
        config.duration = .seconds(seconds: 1)
        SwiftMessages.show(config: config, view: view)
        return
    }
    
    func showLoader() {
        ProgressHUD.animationType = .circleSpinFade
        ProgressHUD.show()
    }
    
    func dismissLoader() {
        ProgressHUD.dismiss()
    }
}
