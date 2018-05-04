//
//  QuestionService.swift
//  JinJo-iOS
//
//  Created by Paco Lee on 2018-05-04.
//  Copyright © 2018 Paco Lee. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

class QuestionService {
    static let sharedService = QuestionService()
    
    func getQuestions(roomID: Int, completion: @escaping (Result<[Question]>) -> Void) {
        APIClient.sharedClient.request(Router.getQuestions(roomID: roomID)) { (response) in
            switch response {
            case .success(let result):
                if let json = result as? [[String: Any]] {
                    let questions = Mapper<Question>().mapArray(JSONArray: json)
                    completion(Result.success(questions))
                }
            case .failure(let error):
                completion(Result.failure(error))
            }
        }
    }
    
    func addQuestion(question: String, roomID: Int, completion: @escaping (Result<Bool>) -> Void) {
        APIClient.sharedClient.request(Router.addQuestion(question: question, roomID: roomID)) { (response) in
            switch response {
            case .success:
                completion(Result.success(true))
            case .failure(let error):
                completion(Result.failure(error))
            }
        }
    }
    
    func likeQuestion(questionID: Int, completion: @escaping (Result<Bool>) -> Void) {
        APIClient.sharedClient.request(Router.likeQuestion(questionID: questionID)) { (response) in
            switch response {
            case .success:
                completion(Result.success(true))
            case .failure(let error):
                completion(Result.failure(error))
            }
        }
    }
    
    func answerQuestion(questionID: Int, completion: @escaping (Result<Bool>) -> Void) {
        APIClient.sharedClient.request(Router.answerQuestion(questionID: questionID)) { (response) in
            switch response {
            case .success:
                completion(Result.success(true))
            case .failure(let error):
                completion(Result.failure(error))
            }
        }
    }
}

