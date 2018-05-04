//
//  APIClient.swift
//  JinJo-iOS
//
//  Created by Paco Lee on 2018-05-04.
//  Copyright © 2018 Paco Lee. All rights reserved.
//

import Foundation
import Alamofire

enum Router: URLRequestConvertible {
    
    static let baseURLString = "http://localhost:8080"
    
    // Instructor
    case addInstructor(email: String, password: String)
    case updatePassword(email: String, oldPassword: String, newPassword: String)
    case loginInstructor(email: String, password: String)
    
    // Room
    case addRoom(instructorID: Int, roomName: String)
    case getRooms(instructorID: Int)
    case getRoom(roomID: Int)
    
    // Question
    case getQuestions(roomID: Int)
    case addQuestion(question: String, roomID: Int)
    case likeQuestion(questionID: Int)
    case answerQuestion(questionID: Int)
    
    var method: HTTPMethod {
        switch self {
        case .addInstructor, .addRoom, .addQuestion:
            return .post
            
        case .loginInstructor, .getRoom, .getRooms, .getQuestions:
            return .get
            
        case .updatePassword, .likeQuestion, .answerQuestion:
            return .put
        }
    }
    
    var path: String {
        switch self {
        // Instructor
        case .addInstructor, .updatePassword, .loginInstructor:
            return "/instructor"
            
        // Room
        case .addRoom, .getRooms, .getRoom:
            return "/room"
        
        // Question
        case .getQuestions, .addQuestion:
            return "/question"
        case .likeQuestion:
            return "/question/like"
        case .answerQuestion:
            return "/question/answer"
        }
    }
    
    // MARK: URLRequestConvertible
    
    func asURLRequest() throws -> URLRequest {
        let url = try Router.baseURLString.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        
        switch self {
        // Instructor
        case .addInstructor(let email, let password):
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: ["email": email, "password": password])
        case .updatePassword(let email, let oldPassword, let newPassword):
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: ["email": email, "oldPassword": oldPassword, "newPassword": newPassword])
        case .loginInstructor(let email, let password):
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: ["email": email, "password": password])
        
        // Room
        case .addRoom(let instructorID, let roomName):
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: ["instructorID": instructorID, "roomName": roomName])
        case .getRooms(let instructorID):
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: ["instructorID": instructorID])
        case .getRoom(let roomID):
            urlRequest.url = URL(string: "\(Router.baseURLString)\(path)/\(roomID)")

        // Question
        case .getQuestions(let roomID):
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: ["roomID": roomID])
        case .addQuestion(let question, let roomID):
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: ["question": question, "roomID": roomID])
        case .likeQuestion(let questionID):
            urlRequest.url = URL(string: "\(Router.baseURLString)\(path)/\(questionID)")
        case .answerQuestion(let questionID):
            urlRequest.url = URL(string: "\(Router.baseURLString)\(path)/\(questionID)")
        }
        
        return urlRequest
    }
}

class APIClient {
    
    static let sharedClient = APIClient()
    
    private let sessionManager: SessionManager
    
    init() {
        var defaultHeaders = Alamofire.SessionManager.defaultHTTPHeaders
        
        defaultHeaders["Content-Type"] = ""
        defaultHeaders["Accept"] = "application/json"
        
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = defaultHeaders
        
        sessionManager = Alamofire.SessionManager(configuration: configuration)
    }
    
    func request(_ request: URLRequestConvertible, completion: @escaping (Result<Any>) -> Void) {
        sessionManager.request(request).validate().responseJSON { (response) in
            completion(response.result)
        }
    }
    
    func download(_ request: URLRequestConvertible, completion: @escaping (Result<Data>) -> Void) {
        sessionManager.download(request).validate().responseData{ response in
            completion(response.result)
        }
    }
    
    func upload(_ data: Data, fileName: String, mimeType: String, _ request: URLRequestConvertible, completion: @escaping (Result<Any>) -> Void) {
        sessionManager.upload(
            multipartFormData: { multipartFormData in
                multipartFormData.append(data, withName: "file", fileName: fileName, mimeType: mimeType)
        },
            with:  request,
            encodingCompletion: { encodingResult in
                switch encodingResult {
                case .success(let upload, _, _):
                    upload.responseJSON { response in
                        completion(Result.success(response.result))
                    }
                case .failure(let encodingError):
                    completion(Result.failure(encodingError))
                }
        }
        )
    }
    
    
    // Utilities
    func checkSuccessHandler(response: Result<Any>, completion: @escaping (Result<Bool>) -> Void) {
        switch response {
        case .success:
            completion(Result.success(true))
        case .failure(let error):
            completion(Result.failure(error))
        }
    }
}
