//
//  QuestionTableViewCell.swift
//  JinJo-iOS
//
//  Created by Paco Lee on 2017-09-30.
//  Copyright © 2017 Paco Lee. All rights reserved.
//

import UIKit

class QuestionTableViewCell: UITableViewCell {

    static let identifier = "QuestionTableViewCell"
    
    @IBOutlet var questionLabel: UILabel!
    @IBOutlet var voteButton: UIButton!
    @IBOutlet var votesLabel: UILabel!
    @IBOutlet var view: UIView!
    @IBOutlet var answeredLabel: UILabel!
    
    var question: Question!
    var delegate: RoomControllerDelegate!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func config(question: Question, roomControllerState: RoomControllerState, roomControllerDelegate: RoomControllerDelegate) {
        self.question = question
        self.delegate = roomControllerDelegate
        questionLabel.text = question.question
        votesLabel.text = "\(question.upvotes ?? 0)"
        
        view.round(cornerRadius: 6.0)
        selectionStyle = .none
        backgroundColor = UIColor(red: 239/255, green: 239/255, blue: 239/255, alpha: 1.0)
        
        if roomControllerState == .instructor {
            voteButton.isHidden = true
            answeredLabel.isHidden = false
            
            if let isAnswered = question.isAnswered {
                if isAnswered {
                    answeredLabel.text = "Answered"
                    answeredLabel.textColor = UIColor.red
                } else {
                    answeredLabel.text = "Unaswered"
                    answeredLabel.textColor = UIColor.black
                }
            }
        } else {
            voteButton.isHidden = false
            answeredLabel.isHidden = true
            
            if let isAnswered = question.isAnswered {
                if isAnswered {
                    voteButton.isHidden = true
                    answeredLabel.isHidden = false
                    answeredLabel.text = "Answered"
                    answeredLabel.textColor = UIColor.red
                }
            }
        }
    }
    
    @IBAction func voteAction(_ sender: Any) {
        if let id = question.id {
            QuestionService.sharedService.likeQuestion(questionID: id) { (result) in
                if result.isSuccess {
                    self.delegate.retrieveQuestions()
                }
            }
        }
    }
}
