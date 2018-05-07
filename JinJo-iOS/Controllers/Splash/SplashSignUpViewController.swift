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
                let vc = UIStoryboard(name: "Courses", bundle: nil).instantiateInitialViewController()
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                
                if let window = appDelegate.window {
                    UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: {
                        window.rootViewController = vc
                    }, completion: nil)
                }
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
