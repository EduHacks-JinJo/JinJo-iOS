//
//  RoomTableViewCell.swift
//  JinJo-iOS
//
//  Created by Paco Lee on 2017-09-30.
//  Copyright © 2017 Paco Lee. All rights reserved.
//

import UIKit

class RoomTableViewCell: UITableViewCell {

    static let identifier = "RoomTableViewCell"
    
    @IBOutlet var questionLabel: UILabel!
    @IBOutlet var voteButton: UIButton!
    @IBOutlet var votesLabel: UILabel!
    @IBOutlet var view: UIView!
    @IBOutlet var voteButtonHeight: NSLayoutConstraint!
    @IBOutlet var voteLabelHeight: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func config(question: String, votes: String, roomControllerState: RoomControllerState) {
        questionLabel.text = question
        votesLabel.text = votes
        
        view.round(cornerRadius: 6.0)
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 1.0
        selectionStyle = .none
        backgroundColor = UIColor(red: 239/255, green: 239/255, blue: 239/255, alpha: 1.0)
        
        if roomControllerState == .instructor {
            voteButton.isHidden = true
            voteLabelHeight.constant = 38.5 * 2
            voteButtonHeight.constant = 0
        } else {
            voteButton.isHidden = false
            voteLabelHeight.constant = 38.5
            voteButtonHeight.constant = 38.5
        }
    }
    
    @IBAction func voteAction(_ sender: Any) {
        
    }
}
