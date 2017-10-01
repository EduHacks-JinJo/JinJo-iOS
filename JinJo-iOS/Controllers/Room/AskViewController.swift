//
//  AskViewController.swift
//  JinJo-iOS
//
//  Created by Paco Lee on 2017-09-30.
//  Copyright © 2017 Paco Lee. All rights reserved.
//

import UIKit

class AskViewController: UIViewController {
    
    static let identifier = "AskViewController"
    
    @IBOutlet var postButton: UIButton!
    @IBOutlet var textView: UITextView!
    
    var roomID: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        textView.becomeFirstResponder()
    }
    
    func config(roomID: String) {
        self.roomID = roomID
    }
    
    private func setup() {
        textView.layer.borderWidth = 1.0
        textView.layer.borderColor = UIColor.black.cgColor
        textView.round(cornerRadius: 6.0)
        postButton.round(cornerRadius: 6.0)
        title = "Ask A Question"
        
        navigationController?.navigationBar.tintColor = UIColor(red: 107/255, green: 186/255, blue: 183/255, alpha: 1.0)
    }
    
    @IBAction func postAction(_ sender: Any) {
        
        if let question = textView.text, question != "" {
            RoomService.shared.postQuestion(roomID: roomID, question: question, completion: { (success) in
                if success {
                    self.navigationController?.popViewController(animated: true)
                }
            })
        }
    }
}
