//
//  InstructorRoomViewController.swift
//  JinJo-iOS
//
//  Created by Paco Lee on 2017-09-30.
//  Copyright © 2017 Paco Lee. All rights reserved.
//

import UIKit
import SocketIO

class InstructorRoomViewController: UIViewController {
    static let identifier = "InstructorRoomViewController"

    var questions = [Question]()
    var room: Room!
    let socket = SocketIOClient(socketURL: NSURL(string: "http://localhost:8080")! as URL)
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    
        if self.isMovingFromParentViewController, let roomID = room.id {
            socket.emit("disconnect", with: [roomID])
        }
    }
    
    func config(room: Room) {
        self.room = room
        
        if let roomName = room.roomName {
            navigationItem.title = roomName
        }
    }
    
    private func setup() {
        setupTableView()
        navigationController?.navigationBar.tintColor = UIColor(red: 107/255, green: 186/255, blue: 183/255, alpha: 1.0)
        
        if let roomID = room.id {
            QuestionService.sharedService.getQuestions(roomID: roomID) { (result) in
                if let questions = result.value {
                    self.questions = questions
                    self.tableView.reloadData()
                }
            }
        }
        
         setupSocket()
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: QuestionTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: QuestionTableViewCell.identifier)
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 125
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
    }
    
    private func setupSocket() {
        setupHandlers()
        socket.connect()
    }
    
    private func setupHandlers() {
        socket.onAny {print("Got event: \($0.event), with items: \($0.items)")}
        
        socket.on(clientEvent: .connect) {[weak self] data, ack in
            print("socket connected")
            
            if let roomID = self?.room.id {
                self?.socket.emit("joining room", with: [roomID])
            }
        }
        
        socket.on("refresh questions") { [weak self] data, ack in
            self?.getQuestions()
        }
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
}

extension InstructorRoomViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let question = questions[indexPath.row]
        if let questionID = question.id, let roomID = question.roomID {
            QuestionService.sharedService.answerQuestion(questionID: questionID, roomID: roomID) { (result) in
                if result.isSuccess {
                    self.getQuestions()
                }
            }
        }
    }
}

extension InstructorRoomViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection  section: Int) -> Int {
        return questions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: QuestionTableViewCell.identifier, for: indexPath) as! QuestionTableViewCell
        cell.config(question: questions[indexPath.row], roomControllerState: RoomControllerState.instructor, roomControllerDelegate: self)
        return cell
    }
}

extension InstructorRoomViewController: RoomControllerDelegate {
    func retrieveQuestions() {
        getQuestions()
    }
}
