//
//  Question.swift
//  JinJo-iOS
//
//  Created by Paco Lee on 2017-10-01.
//  Copyright © 2017 Paco Lee. All rights reserved.
//

import Foundation
import ObjectMapper

class Question: Mappable {
    
    var id: Int?
    var question: String?
    var upvotes: Int?
    var roomID: Int?
    var isAnswered: Bool?
    
    required public init?(map: Map) { }
    
    public func mapping(map: Map) {
        id <- map["id"]
        question <- map["question"]
        upvotes <- map["upvotes"]
        roomID <- map["roomID"]
        isAnswered <- map["isAnswered"]
    }
    
}
