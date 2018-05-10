//
//  InstructorRoomTableViewCell.swift
//  JinJo-iOS
//
//  Created by Paco Lee on 2017-09-30.
//  Copyright © 2017 Paco Lee. All rights reserved.
//

import UIKit

class InstructorRoomTableViewCell: UITableViewCell {
    
    static let identifier = "InstructorRoomTableViewCell"

    @IBOutlet var view: UIView!
    @IBOutlet var questionLabel: UILabel!
    var question: Question!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    func config(question: Question) {
        self.question = question
        
        if let question = question.question {
            questionLabel.text = question
        }
    }
        
    private func setupUI() {
        view.round(cornerRadius: 6.0)
        selectionStyle = .none
        
        backgroundColor = UIColor(red: 239/255, green: 239/255, blue: 239/255, alpha: 1.0)
    }
}
