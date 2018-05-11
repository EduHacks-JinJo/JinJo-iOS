//
//  SplashLogInViewController.swift
//  JinJo-iOS
//
//  Created by Paco Lee on 2017-09-30.
//  Copyright © 2017 Paco Lee. All rights reserved.
//

import UIKit

class SplashLogInViewController: UIViewController {
    static let identifier = "SplashLogInViewController"
    
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var logInButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        logInButton.round(cornerRadius: 6.0)
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    @IBAction func logInAction(_ sender: Any) {
        guard let email = emailTextField.text, email != "" else {
            return
        }
        
        guard let password = passwordTextField.text, password != "" else {
            return
        }
        
        InstructorService.sharedService.loginInstructor(email: email, password: password) { (result) in
            if let value = result.value, let id = value.id {
                UserDefaults.standard.set(id, forKey: "id")
                
                let vc = UIStoryboard(name: "Instructor", bundle: nil).instantiateInitialViewController()
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                
                if let window = appDelegate.window {
                    UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: {
                        window.rootViewController = vc
                    }, completion: nil)
                }
            }
        }
        
    }
    
    @IBAction func signUpAction(_ sender: Any) {
        let vc = UIStoryboard(name: "Splash", bundle: nil).instantiateViewController(withIdentifier: SplashSignUpViewController.identifier)
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBAction func studentAction(_ sender: Any) {
        let vc = UIStoryboard(name: "Splash", bundle: nil).instantiateViewController(withIdentifier: SplashJoinViewController.identifier)
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension SplashLogInViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return false
    }
}
