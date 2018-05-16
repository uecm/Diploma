//
//  Authorizer.swift
//  Diploma
//
//  Created by Egor on 5/5/18.
//  Copyright © 2018 egor. All rights reserved.
//

import Foundation
import UIKit.UIApplication

class Authorizer {
    
    enum AuthorizationState {
        case authorized
        case unauthorized
    }
    
    static func authorizationState() -> AuthorizationState {
        return authToken == nil ? .unauthorized : .authorized
    }
    
    static var authToken: String? {
        get {
            return UserDefaults.standard.string(forKey: "userAuthToken")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "userAuthToken")
        }
    }
    
    static func authorize(withEmail email: String,
                          password: String,
                          completion: Closure<Bool>) {
        APIProvider.shared.login(email: email, password: password) { (token) in
            guard let token = token else {
                completion?(false)
                return
            }
            authToken = token
            DataManager.shared.getCurrentUser()
            completion?(true)
        }
    }
    
    static func logout() {
        guard let coordinator = (UIApplication.shared.delegate as? AppDelegate)?.coordinator else {
            fatalError("App Coordinator couldn't be found")
        }
        authToken = nil
        DataManager.shared.dropDatabase()
        APIProvider.shared.cancelRequests()
        coordinator.openLoginScreen()
    }
}
