//
//  SplashJoinViewController.swift
//  JinJo-iOS
//
//  Created by Paco Lee on 2017-09-30.
//  Copyright © 2017 Paco Lee. All rights reserved.
//

import UIKit

class SplashJoinViewController: UIViewController {
    static let identifier = "SplashJoinViewController"

    @IBOutlet var joinRoomButton: UIButton!
    @IBOutlet var instructorButton: UIButton!
    @IBOutlet var roomTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        joinRoomButton.round(cornerRadius: 6.0)
        instructorButton.round(cornerRadius: 6.0)
        roomTextField.delegate = self
    }
    
    @IBAction func joinRoom(_ sender: Any) {
        if let roomID = roomTextField.text, !roomID.isEmpty, let roomIDInt = Int(roomID) {
            RoomService.sharedService.getRoom(roomID: roomIDInt) { (result) in
                if result.isSuccess, let room = result.value {
                    let vc = UIStoryboard(name: "Room", bundle: nil).instantiateViewController(withIdentifier: RoomViewController.identifier) as! RoomViewController
                    vc.config(room: room, roomControllerState: .student)
                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                    appDelegate.window?.rootViewController = UINavigationController(rootViewController: vc)
                } else {
                    UIAlertController.showRoomIDDoesNotExistPopUp()
                }
            }
        }
    }
    
    @IBAction func instructorAction(_ sender: Any) {
        let vc = UIStoryboard(name: "Splash", bundle: nil).instantiateViewController(withIdentifier: SplashLogInViewController.identifier)
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension SplashJoinViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return false
    }
}
