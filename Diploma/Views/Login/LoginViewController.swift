//
//  LoginViewController.swift
//  Diploma
//
//  Created by Egor on 5/5/18.
//  Copyright © 2018 egor. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var continueButton: UIButton!
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!


    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureButton()
    }
    
    private func configureButton() {
        let layer = continueButton.layer
        layer.borderWidth = 1
        layer.borderColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
    }
    
    
    @IBAction func login(_ sender: Any) {
        guard
            let email = emailField.text, email.count > 0,
            let password = passwordField.text, password.count > 0 else {
                return showEmptyFieldsAlert()
        }
        
        Authorizer.authorize(withEmail: email, password: password) { (success) in
            guard success == true else {
                return self.showIncorrectCredentialsAlert()
            }
            
            if let coordinator = (UIApplication.shared.delegate as? AppDelegate)?.coordinator {
                coordinator.openMainScreen()
            }
        }
    }
    
    private func showEmptyFieldsAlert() {
        present(UIAlertController.okActionAlert(
            withTitle: "Пустые поля",
            message: "Для продолжения нужно заполнить все поля"
            ), animated: true)
    }
    
    private func showIncorrectCredentialsAlert() {
        present(UIAlertController.okActionAlert(
            withTitle: "Неправильные данные",
            message: "Пользователя с такими данными не существует"
            ), animated: true)
    }
    
}


extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case emailField:
            passwordField.becomeFirstResponder()
        case passwordField:
            login(textField)
        default:
            break
        }
        return true
    }
}




