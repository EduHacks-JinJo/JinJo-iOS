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
    var instructorID: String?
    var roomName: String?
    
    required public init?(map: Map) { }
    
    public func mapping(map: Map) {
        id <- map["id"]
        instructorID <- map["instructorID"]
        roomName <- map["roomName"]
    }
    
}
