//
//  RoomService.swift
//  JinJo-iOS
//
//  Created by Paco Lee on 2017-10-01.
//  Copyright © 2017 Paco Lee. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

class RoomService {
    static let sharedService = RoomService()
    
    func addRoom(instructorID: Int, roomName: String, completion: @escaping (Result<Bool>) -> Void) {
        APIClient.sharedClient.request(Router.addRoom(instructorID: instructorID, roomName: roomName)) { (response) in
            switch response {
            case .success:
                completion(Result.success(true))
            case .failure(let error):
                completion(Result.failure(error))
            }
        }
    }
    
    func getRooms(instructorID: Int, completion: @escaping (Result<[Room]>) -> Void) {
        APIClient.sharedClient.request(Router.getRooms(instructorID: instructorID)) { (response) in
            switch response {
            case .success(let result):
                if let json = result as? [[String: Any]] {
                    let rooms = Mapper<Room>().mapArray(JSONArray: json)
                    completion(Result.success(rooms))
                }
            case .failure(let error):
                completion(Result.failure(error))
            }
        }
    }
    
    func getRoom(roomID: Int, completion: @escaping (Result<Room>) -> Void) {
        APIClient.sharedClient.request(Router.getRoom(roomID: roomID)) { (response) in
            switch response {
            case .success(let result):
                if let json = result as? [[String: Any]] {
                    let room = Mapper<Room>().mapArray(JSONArray: json)
                    completion(Result.success(room[0]))
                }
            case .failure(let error):
                completion(Result.failure(error))
            }
        }
    }
}
