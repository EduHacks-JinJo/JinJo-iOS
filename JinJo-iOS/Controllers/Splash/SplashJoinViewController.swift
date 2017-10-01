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
    }
    
    @IBAction func joinRoom(_ sender: Any) {
        if let roomID = roomTextField.text, roomID != "" {
            let vc = UIStoryboard(name: "Room", bundle: nil).instantiateViewController(withIdentifier: RoomViewController.identifier) as! RoomViewController
            vc.config(roomID: roomID, roomControllerState: .student)
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.window?.rootViewController = UINavigationController(rootViewController: vc)
        }
    }
    
    @IBAction func instructorAction(_ sender: Any) {
        let vc = UIStoryboard(name: "Splash", bundle: nil).instantiateViewController(withIdentifier: SplashLogInViewController.identifier)
        navigationController?.pushViewController(vc, animated: true)
    }
}
