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
    
    var id: String?
    var question: String?
    var upvotes: Int?
    var classID: String?
    var isAnswered: Bool?
    
    required public init?(map: Map) { }
    
    public func mapping(map: Map) {
        id <- map["_id"]
        question <- map["question"]
        upvotes <- map["upvotes"]
        classID <- map["classID"]
        isAnswered <- map["isAnswered"]
    }
    
}
