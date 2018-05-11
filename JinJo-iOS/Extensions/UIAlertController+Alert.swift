//
//  UIAlertController+Alert.swift
//  JinJo-iOS
//
//  Created by Paco Lee on 2018-05-04.
//  Copyright © 2018 Paco Lee. All rights reserved.
//

import Foundation
import UIKit

extension UIAlertController {
    static func showRoomIDDoesNotExistPopUp() {
        let alertController = UIAlertController(title: nil, message: "The room ID entered does not exist.", preferredStyle: .actionSheet)
        
        let okAction = UIAlertAction(title: "ok", style: .default) { action in
        }
        
        alertController.addAction(okAction)
        
        if let topViewController = UIApplication.topViewController() {
            alertController.popoverPresentationController?.sourceView = topViewController.view
            topViewController.present(alertController, animated: true, completion: nil)
        }
    }
    
    static func showIncorrectLoginPopUp() {
        let alertController = UIAlertController(title: nil, message: "Login information incorrect.", preferredStyle: .actionSheet)
        
        let okAction = UIAlertAction(title: "ok", style: .default) { action in
        }
        
        alertController.addAction(okAction)
        
        if let topViewController = UIApplication.topViewController() {
            alertController.popoverPresentationController?.sourceView = topViewController.view
            topViewController.present(alertController, animated: true, completion: nil)
        }
    }
}
