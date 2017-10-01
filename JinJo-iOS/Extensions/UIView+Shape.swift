//
//  UIView+Shape.swift
//  weather
//
//  Created by Paco Lee on 2017-07-26.
//  Copyright © 2017 Paco Lee. All rights reserved.
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
