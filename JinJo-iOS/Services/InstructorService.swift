//
//  InstructorService.swift
//  JinJo-iOS
//
//  Created by Paco Lee on 2018-05-04.
//  Copyright © 2018 Paco Lee. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

enum InstructorError: Error {
    case incorrectLogin
}

class InstructorService {
    static let sharedService = InstructorService()
    
    func addInstructor(email: String, password: String, completion: @escaping (Result<Bool>) -> Void) {
        APIClient.sharedClient.request(Router.addInstructor(email: email, password: password)) { (response) in
            switch response {
            case .success:
                completion(Result.success(true))
            case .failure(let error):
                completion(Result.failure(error))
            }
        }
    }
    
    func updatePassword(email: String, oldPassword: String, newPassword: String, completion: @escaping (Result<Bool>) -> Void) {
        APIClient.sharedClient.request(Router.updatePassword(email: email, oldPassword: oldPassword, newPassword: newPassword)) { (response) in
            switch response {
            case .success:
                completion(Result.success(true))
            case .failure(let error):
                completion(Result.failure(error))
            }
        }
    }
    
    func loginInstructor(email: String, password: String, completion: @escaping (Result<Instructor>) -> Void) {
        APIClient.sharedClient.request(Router.loginInstructor(email: email, password: password)) { (response) in
            switch response {
            case .success(let result):
                if let json = result as? [[String: Any]], json.count > 0 {
                    let instructor = Mapper<Instructor>().mapArray(JSONArray: json)
                    completion(Result.success(instructor[0]))
                } else {
                    completion(Result.failure(InstructorError.incorrectLogin))
                }
            case .failure(let error):
                completion(Result.failure(error))
            }
        }
    }
}
