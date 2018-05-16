//
//  AppCoordinator.swift
//  Diploma
//
//  Created by Egor on 5/5/18.
//  Copyright © 2018 egor. All rights reserved.
//

import UIKit

class AppCoordinator {
    
    var window: UIWindow?
    
    required init(window: UIWindow?) {
        self.window = window
    }
    
    func openInitialScreen() {
        switch Authorizer.authorizationState() {
        case .authorized:
            openMainScreen()
        case .unauthorized:
            openLoginScreen()
        }
    }
    
    func openMainScreen() {
        guard
            let root = UIStoryboard(name: "Main", bundle: nil)
                        .instantiateInitialViewController(),
            let currentRoot = window?.rootViewController else {
                return
        }
        currentRoot.present(root, animated: true) {
            self.window?.rootViewController = root
        }
    }
    
    func openLoginScreen() {
        let root = LoginViewController.init(nibName: "LoginViewController", bundle: nil)
        window?.rootViewController = root
    }
    
    
}
