//
//  InstructorRoomViewController.swift
//  JinJo-iOS
//
//  Created by Paco Lee on 2017-09-30.
//  Copyright © 2017 Paco Lee. All rights reserved.
//

import UIKit

class InstructorRoomViewController: UIViewController {
    static let identifier = "InstructorRoomViewController"

    var questions = [Question]()
    var room: Room!
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
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
        if let questionID = question.id {
            QuestionService.sharedService.answerQuestion(questionID: questionID) { (result) in
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
