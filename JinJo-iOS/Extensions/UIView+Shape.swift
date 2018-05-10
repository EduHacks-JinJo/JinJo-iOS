//
//  UIView+Shape.swift
//  JinJo-iOS
//
//  Created by Paco Lee on 2018-05-04.
//  Copyright © 2018 Paco Lee. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func round(cornerRadius: CGFloat) {
        self.layer.cornerRadius = cornerRadius
        self.clipsToBounds = true
    }
    
    func circular() {
        self.layer.cornerRadius = self.frame.size.height / 2
        self.layer.masksToBounds = true
    }
}
