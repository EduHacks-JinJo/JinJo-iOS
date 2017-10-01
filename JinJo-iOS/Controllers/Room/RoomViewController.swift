//
//  RoomViewController.swift
//  JinJo-iOS
//
//  Created by Paco Lee on 2017-09-30.
//  Copyright © 2017 Paco Lee. All rights reserved.
//

import UIKit

enum RoomControllerState {
    case instructor
    case student
}

class RoomViewController: UIViewController {
    static let identifier = "RoomViewController"

    var questions = ["Why are you white?"]
    var votes = ["0"]
    
    var roomControllerState: RoomControllerState!
    var roomID: String!
    
    @IBOutlet var questionButton: UIButton!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var questionButtonHeight: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func config(roomID: String, roomControllerState: RoomControllerState) {
        self.roomID = roomID
        self.roomControllerState = roomControllerState
        
        title = "Room ID: \(roomID)"
    }
    
    private func setup() {
        setupTableView()
        navigationController?.navigationBar.tintColor = UIColor(red: 107/255, green: 186/255, blue: 183/255, alpha: 1.0)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(logOutAction))
        
        if roomControllerState == .student {
            questionButtonHeight.constant = 60
            questionButton.isHidden = false
        } else {
            questionButtonHeight.constant = 0
            questionButton.isHidden = true
        }
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: RoomTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: RoomTableViewCell.identifier)
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 125
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
    }
    
    @IBAction func askQuestionAction(_ sender: Any) {
        let vc = UIStoryboard(name: "Room", bundle: nil).instantiateViewController(withIdentifier: AskViewController.identifier)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func logOutAction() {
        let vc = UIStoryboard(name: "Splash", bundle: nil).instantiateInitialViewController()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        if let window = appDelegate.window {
            UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: {
                window.rootViewController = vc
            }, completion: nil)
        }
    }
}

extension RoomViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension RoomViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection  section: Int) -> Int {
        return questions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RoomTableViewCell.identifier, for: indexPath) as! RoomTableViewCell
        cell.config(question: questions[indexPath.row], votes: votes[indexPath.row], roomControllerState: roomControllerState)
        return cell
    }
}

