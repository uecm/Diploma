//
//  Helpers.swift
//  Diploma
//
//  Created by Egor on 5/5/18.
//  Copyright © 2018 egor. All rights reserved.
//

import UIKit.UIAlertController

typealias Closure<T> = ((_ callback: T) -> Void)?
typealias Callback = (() -> Void)?


var currentUserID: Int {
    get {
        return UserDefaults.standard.integer(forKey: "_currentUserId")
    }
    set {
        UserDefaults.standard.set(newValue, forKey: "_currentUserId")
    }
}



extension UIAlertController {
    
    enum AlertAction {
        case ok
        case cancel
    }
    
    static func okActionAlert(withTitle title: String, message: String) -> UIAlertController {
        let okAction = UIAlertAction(title: "Ok", style: .default)
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(okAction)
        return alert
    }
    
    static func alert(withTitle title: String,
                      message: String,
                      actions: AlertAction...,
                      okCallback: Callback = nil,
                      cancelCallback: Callback = nil) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        actions.forEach {
            var action: UIAlertAction!
            switch $0 {
            case .ok:
                action = UIAlertAction(title: "Ok", style: .default, handler: { (_) in
                    okCallback?()
                })
            case .cancel:
                action = UIAlertAction(title: "Cancel", style: .destructive, handler: { (_) in
                    cancelCallback?()
                })
            }
            alert.addAction(action)
        }
        return alert
    }
}

