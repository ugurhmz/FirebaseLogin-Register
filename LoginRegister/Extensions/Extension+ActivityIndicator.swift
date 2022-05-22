//
//  Extension+ActivityIndicator.swift
//  LoginRegister
//
//  Created by ugur-pc on 22.05.2022.
//

import UIKit
var activityView: UIActivityIndicatorView?

extension UIViewController {
        func showActivityIndicator() {
            activityView = UIActivityIndicatorView(style: .large)
            activityView?.center = self.view.center
            activityView?.color = .red
            self.view.addSubview(activityView!)
            activityView?.startAnimating()
        }
    
        func hideActivityIndicator(){
            if (activityView != nil){
                activityView?.stopAnimating()
            }
        }
}
