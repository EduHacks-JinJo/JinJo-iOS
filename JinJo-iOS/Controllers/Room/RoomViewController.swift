//
//  RoomViewController.swift
//  JinJo-iOS
//
//  Created by Paco Lee on 2017-09-30.
//  Copyright © 2017 Paco Lee. All rights reserved.
//

import UIKit
import SocketIO

protocol RoomControllerDelegate {
    func retrieveQuestions()
}

enum RoomControllerState {
    case instructor
    case student
}

class RoomViewController: UIViewController {
    static let identifier = "RoomViewController"

    var questions = [Question]()
    var room: Room!
    
    var roomControllerState: RoomControllerState!
    
    @IBOutlet var questionButton: UIButton!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var questionButtonHeight: NSLayoutConstraint!
    
    let socket = SocketIOClient(socketURL: NSURL(string: "http://localhost:8080")! as URL)

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        getQuestions()
    }
    
    func config(room: Room, roomControllerState: RoomControllerState) {
        self.room = room
        self.roomControllerState = roomControllerState
        
        if let roomName = room.roomName {
            title = "Room ID: \(roomName)"
        }
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
        
        setupSocket()
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.register(UINib(nibName: QuestionTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: QuestionTableViewCell.identifier)
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 125
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
    }
    
    private func setupHandlers() {
        socket.onAny {print("Got event: \($0.event), with items: \($0.items)")}
        
        socket.on(clientEvent: .connect) { [weak self]data, ack in
            print("socket connected")
            
            if let roomID = self?.room.id {
                self?.socket.emit("joining room", with: [roomID])
            }
        }
        
        socket.on("refresh questions") { [weak self] data, ack in
            self?.getQuestions()
        }
    }
    
    private func setupSocket() {
        setupHandlers()
        socket.connect()
    }
    
    func getQuestions() {
        if let roomID = room.id {
            QuestionService.sharedService.getQuestions(roomID: roomID) { (result) in
                if let questions = result.value {
                    self.questions = questions
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    @IBAction func askQuestionAction(_ sender: Any) {
        let vc = UIStoryboard(name: "Room", bundle: nil).instantiateViewController(withIdentifier: AskViewController.identifier) as! AskViewController
        vc.config(room: room)
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

extension RoomViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection  section: Int) -> Int {
        return questions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: QuestionTableViewCell.identifier, for: indexPath) as! QuestionTableViewCell
        cell.config(question: questions[indexPath.row], roomControllerState: roomControllerState, roomControllerDelegate: self)
        return cell
    }
}

extension RoomViewController: RoomControllerDelegate {
    func retrieveQuestions() {
        getQuestions()
    }
}
