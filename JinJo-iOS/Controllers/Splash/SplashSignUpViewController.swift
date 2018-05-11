//
//  SplashSignUpViewController.swift
//  JinJo-iOS
//
//  Created by Paco Lee on 2017-09-30.
//  Copyright © 2017 Paco Lee. All rights reserved.
//

import UIKit

class SplashSignUpViewController: UIViewController {
    @IBOutlet var signUpButton: UIButton!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var confirmPasswordTextField: UITextField!
    
    static let identifier = "SplashSignUpViewController"

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        signUpButton.round(cornerRadius: 6.0)
        emailTextField.delegate = self
        passwordTextField.delegate = self
        confirmPasswordTextField.delegate = self
    }

    @IBAction func signUpAction(_ sender: Any) {
        guard let email = emailTextField.text, email != "" else {
            return
        }
        
        guard let password = passwordTextField.text, password != "" else {
            return
        }
        
        guard let confirmPassword = confirmPasswordTextField.text, confirmPassword != "" else {
            return
        }
        
        InstructorService.sharedService.addInstructor(email: email, password: password) { (result) in
            if result.isSuccess {
                InstructorService.sharedService.loginInstructor(email: email, password: password, completion: { (loginResult) in
                    if let instructor = loginResult.value, let id = instructor.id {
                        UserDefaults.standard.set(id, forKey: "id")
                        let vc = UIStoryboard(name: "Instructor", bundle: nil).instantiateInitialViewController()
                        let appDelegate = UIApplication.shared.delegate as! AppDelegate
                        
                        if let window = appDelegate.window {
                            UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: {
                                window.rootViewController = vc
                            }, completion: nil)
                        }
                    }
                })
            }
        }
    }
    
    @IBAction func logInAction(_ sender: Any) {
        let vc = UIStoryboard(name: "Splash", bundle: nil).instantiateViewController(withIdentifier: SplashLogInViewController.identifier)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func studentAction(_ sender: Any) {
        let vc = UIStoryboard(name: "Splash", bundle: nil).instantiateViewController(withIdentifier: SplashJoinViewController.identifier)
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension SplashSignUpViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return false
    }
}
