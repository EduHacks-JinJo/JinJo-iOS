//
//  CreateRoomViewController.swift
//  JinJo-iOS
//
//  Created by Paco Lee on 2017-09-30.
//  Copyright © 2017 Paco Lee. All rights reserved.
//

import UIKit

class CreateRoomViewController: UIViewController {
    static let identifier = "CreateRoomViewController"
    
    @IBOutlet var courseTextField: UITextField!
    @IBOutlet var nameTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        navigationController?.navigationBar.tintColor = UIColor(red: 107/255, green: 186/255, blue: 183/255, alpha: 1.0)
    }
    
    @IBAction func createRoom(_ sender: Any) {
        
    }
}
