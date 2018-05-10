//
//  InstructorTableViewCell.swift
//  JinJo-iOS
//
//  Created by Paco Lee on 2017-09-30.
//  Copyright © 2017 Paco Lee. All rights reserved.
//

import UIKit

class InstructorTableViewCell: UITableViewCell {

    static let identifier = "InstructorTableViewCell"
    
    @IBOutlet var view: UIView!
    @IBOutlet var roomNameLabel: UILabel!
    @IBOutlet var roomIDLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    func config(room: Room) {
        if let roomName = room.roomName, let roomID = room.id {
            roomNameLabel.text = roomName
            roomIDLabel.text = "\(roomID):"
        }
    }
    
    private func setupUI() {
        view.round(cornerRadius: 6.0)
        selectionStyle = .none
        
        backgroundColor = UIColor(red: 239/255, green: 239/255, blue: 239/255, alpha: 1.0)
    }
}
