//
//  CourseRoomsTableViewCell.swift
//  JinJo-iOS
//
//  Created by Paco Lee on 2017-09-30.
//  Copyright © 2017 Paco Lee. All rights reserved.
//

import UIKit

class CourseRoomsTableViewCell: UITableViewCell {
    
    static let identifier = "CourseRoomsTableViewCell"

    @IBOutlet var view: UIView!
    @IBOutlet var courseNameLabel: UILabel!
    var room: Room!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    func config(room: Room) {
        self.room = room
        
        if let roomName = room.classname {
            courseNameLabel.text = roomName
        } else if let date = room.date {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            courseNameLabel.text = dateFormatter.string(from: date)
        }
    }
        
    private func setupUI() {
        view.round(cornerRadius: 6.0)
        selectionStyle = .none
        
        backgroundColor = UIColor(red: 239/255, green: 239/255, blue: 239/255, alpha: 1.0)
    }
}
