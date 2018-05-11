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
    
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var createRoomButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        navigationController?.navigationBar.tintColor = UIColor(red: 107/255, green: 186/255, blue: 183/255, alpha: 1.0)
        createRoomButton.round(cornerRadius: 6.0)
        nameTextField.delegate = self
    }
    
    @IBAction func createRoom(_ sender: Any) {
        if let roomName = nameTextField.text, !roomName.isEmpty {
            let id = UserDefaults.standard.integer(forKey: "id")
            RoomService.sharedService.addRoom(instructorID: id, roomName: roomName) { (result) in
                if result.isSuccess {
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
    }
}

extension CreateRoomViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return false
    }
}
