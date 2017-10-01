//
//  RoomService.swift
//  JinJo-iOS
//
//  Created by Paco Lee on 2017-10-01.
//  Copyright © 2017 Paco Lee. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class RoomService {
    static let shared = RoomService()
    private let baseURL = "https://jinjo.herokuapp.com"
    
    func createRoom(courseID: String, classname: String, completion: @escaping (_ success: Bool) -> Void) {
        let url = "\(baseURL)/createroom"
        
        if let token = UserDefaults.standard.string(forKey: "token") {
            Alamofire.request(url, method: .post, parameters: ["courseID": courseID, "classname": classname], encoding: JSONEncoding.default, headers: ["token": token]).responseJSON { response in
                switch response.result {
                case .success:
                    completion(true)
                case .failure:
                    completion(false)
                }
            }
        }
    }
    
    func getRooms(courseID: String, completion: @escaping (_ success: Bool, _ rooms: [Room]) -> Void) {
        let url = "\(baseURL)/classrooms"
        
        if let token = UserDefaults.standard.string(forKey: "token") {
            Alamofire.request(url, method: .post, parameters: ["courseID": courseID], encoding: JSONEncoding.default, headers: ["token": token]).responseJSON { response in
                switch response.result {
                case .success(let value):
                    if let jsonArray = JSON(value).array {
                        var rooms = [Room]()
                        for json in jsonArray {
                            if let dictionary = json.dictionaryObject {
                                if let room = Room(JSON: dictionary) {
                                    rooms.append(room)
                                }
                            }
                        }
                        completion(true, rooms)
                    } else {
                        completion(false, [])
                    }
                    
                case .failure:
                    completion(false, [])
                }
            }
        }
    }
    
    func getCourses(completion: @escaping (_ success: Bool, _ courses: [String]) -> Void) {
        let url = "\(baseURL)/classrooms/courses"
        
        if let token = UserDefaults.standard.string(forKey: "token") {
            Alamofire.request(url, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: ["token": token]).responseJSON { response in
                switch response.result {
                case .success(let value):
                    if let courses = JSON(value).arrayObject as? [String] {
                        completion(true, courses)
                    } else {
                        completion(false, [])
                    }
                    
                case .failure:
                    completion(false, [])
                }
            }
        }
    }
    
    func getQuestions(roomID: String, completion: @escaping (_ success: Bool, _ questions: [Question]) -> Void) {
        let url = "\(baseURL)/questions"
        
        Alamofire.request(url, method: .post, parameters: ["roomID": roomID], encoding: JSONEncoding.default, headers: nil).responseJSON { response in
            switch response.result {
            case .success(let value):
                if let jsonArray = JSON(value).array {
                    var questions = [Question]()
                    for json in jsonArray {
                        if let dictionary = json.dictionaryObject {
                            if let question = Question(JSON: dictionary) {
                                questions.append(question)
                            }
                        }
                    }
                    completion(true, questions)
                } else {
                    completion(false, [])
                }
            case .failure:
                completion(false, [])
            }
        }
    }
    
    func postQuestion(roomID: String, question: String, completion: @escaping (Bool) -> Void) {
        let url = "\(baseURL)/question"
        
        Alamofire.request(url, method: .post, parameters: ["roomID": roomID, "question": question], encoding: JSONEncoding.default, headers: nil).responseJSON { response in
            switch response.result {
            case .success:
                completion(true)
            case .failure:
                completion(false)
            }
        }
    }
    
    func answer(id: String, completion: @escaping (Bool) -> Void) {
        let url = "\(baseURL)/answer"
        
        Alamofire.request(url, method: .post, parameters: ["id": id], encoding: JSONEncoding.default, headers: nil).responseJSON { response in
            switch response.result {
            case .success:
                completion(true)
            case .failure:
                completion(false)
            }
        }
    }
    
    func upvote(id: String, completion: @escaping (Bool) -> Void) {
        let url = "\(baseURL)/upvote"
        
        Alamofire.request(url, method: .post, parameters: ["id": id], encoding: JSONEncoding.default, headers: nil).responseJSON { response in
            switch response.result {
            case .success:
                completion(true)
            case .failure:
                completion(false)
            }
        }
    }
    
    func downvote(id: String, completion: @escaping (Bool) -> Void) {
        let url = "\(baseURL)/downvote"
        
        Alamofire.request(url, method: .post, parameters: ["id": id], encoding: JSONEncoding.default, headers: nil).responseJSON { response in
            switch response.result {
            case .success:
                completion(true)
            case .failure:
                completion(false)
            }
        }
    }
}
