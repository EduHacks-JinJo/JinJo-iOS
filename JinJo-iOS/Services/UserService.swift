//
//  UserService.swift
//  JinJo-iOS
//
//  Created by Paco Lee on 2017-09-30.
//  Copyright © 2017 Paco Lee. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

class UserService {
    static let shared = UserService()
    private let baseURL = "https://jinjo.herokuapp.com"
    
    func login(email: String, password: String, completion: @escaping (_ success: Bool) -> Void) {
        let url = "\(baseURL)/auth/login"
        
        Alamofire.request(url, method: .post, parameters: ["email": email, "password": password], encoding: JSONEncoding.default, headers: nil).responseJSON { response in
            switch response.result {
            case .success(let value):
                if let json = JSON(value).dictionaryObject, let token = json["token"] as? String  {
                    UserDefaults.standard.setValue(token, forKey: "token")
                    completion(true)
                } else {
                    completion(false)
                }
                
            case .failure(let error):
                print(error)
                completion(false)
            }
        }
    }
    
    func signUp(email: String, password: String, completion: @escaping (_ success: Bool) -> Void) {
        let url = "\(baseURL)/auth/create"
        
        Alamofire.request(url, method: .post, parameters: ["email": email, "password": password], encoding: JSONEncoding.default, headers: nil).responseJSON { response in
            switch response.result {
            case .success(let value):
                if let json = JSON(value).dictionaryObject, let token = json["token"] as? String  {
                    UserDefaults.standard.setValue(token, forKey: "token")
                    completion(true)
                } else {
                    completion(false)
                }
                
            case .failure:
                completion(false)
            }
        }
    }
}

