//
//  Instructor.swift
//  JinJo-iOS
//
//  Created by Paco Lee on 2018-05-04.
//  Copyright © 2018 Paco Lee. All rights reserved.
//

import Foundation
import ObjectMapper

class Instructor: Mappable {
    
    var id: Int?
    var email: String?
    var password: String?
    
    required public init?(map: Map) { }
    
    public func mapping(map: Map) {
        id <- map["instructorID"]
        email <- map["email"]
        password <- map["password"]
    }
    
}

