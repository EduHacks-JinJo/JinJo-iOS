//
//  CoursesTableViewCell.swift
//  JinJo-iOS
//
//  Created by Paco Lee on 2017-09-30.
//  Copyright © 2017 Paco Lee. All rights reserved.
//

import UIKit

class CoursesTableViewCell: UITableViewCell {

    static let identifier = "CoursesTableViewCell"
    
    @IBOutlet var view: UIView!
    @IBOutlet var courseNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    func config(course: String) {
        courseNameLabel.text = course
    }
    
    private func setupUI() {
        view.round(cornerRadius: 6.0)
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 1.0
        selectionStyle = .none
        
        backgroundColor = UIColor(red: 239/255, green: 239/255, blue: 239/255, alpha: 1.0)
    }
}
