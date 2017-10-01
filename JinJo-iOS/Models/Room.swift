//
//  Room.swift
//  JinJo-iOS
//
//  Created by Paco Lee on 2017-10-01.
//  Copyright © 2017 Paco Lee. All rights reserved.
//

import Foundation
import ObjectMapper

class Room: Mappable {
    
    var id: String?
    var roomID: String?
    var teacherID: String?
    var date: Date?
    var classname: String?
    var courseName: String?
    var courseID: String?
    
    required public init?(map: Map) { }
    
    public func mapping(map: Map) {
        id <- map["_id"]
        roomID <- map["roomID"]
        teacherID <- map["teacherID"]
        date <- (map["date"], DateTransform())
        classname <- map["classname"]
        courseID <- map["courseID"]
    }
    
}
