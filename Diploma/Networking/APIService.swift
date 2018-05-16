//
//  APIService.swift
//  Diploma
//
//  Created by Egor on 5/3/18.
//  Copyright © 2018 egor. All rights reserved.
//

import Moya

enum APIService {
    case login(email: String, password: String)
    case user
    case students
    case addStudent(model: StudentModel)
    case myTasks
    case allTasks
}


extension APIService: TargetType {
    var baseURL: URL { return URL(string: "http://localhost:8080")! }
    
    
    var path: String {
        switch self {
        case .user:
            return "/me"
        case .login(_, _):
            return "/login"
        case .students, .addStudent(model: _):
            return "/student"
        case .allTasks:
            return "/task/all"
        case .myTasks:
            return "/task"
        }
    }
    
    var method: Method {
        switch self {
        case .user, .students, .myTasks, .allTasks:
            return .get
        case .login, .addStudent(model: _):
            return .post
        }
    }
    
    var sampleData: Data {
        return "Sample Data".utf8Encoded
    }
    
    var task: Task {
        switch self {
        case .login, .user, .students, .myTasks, .allTasks:
            return .requestPlain
        case let .addStudent(model: model):
            return .requestJSONEncodable(model)
        }
    }
    
    var headers: [String : String]? {
        var header = ["Content-type": "application/json"]
        switch self {
        case let .login(email: e, password: p):
            header["Authorization"] = "Basic \("\(e):\(p)".base64Encoded)"
            fallthrough
        default:
            return header
        }
    }
}


extension APIService: AccessTokenAuthorizable {
    var authorizationType: AuthorizationType {
        switch self {
        case .login:
            return .none
        default:
            return .bearer
        }
    }
    
    var tokenClosure: String? {
        switch self {
        case let .login(email: e, password: p):
            return "\(e):\(p)".base64Encoded
        default:
            return Authorizer.authToken
        }
    }
}



// MARK: - Helpers
private extension String {
    var urlEscaped: String {
        return addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
    
    var base64Encoded: String {
        return utf8Encoded.base64EncodedString()
    }
    
    var utf8Encoded: Data {
        return data(using: .utf8)!
    }
}


