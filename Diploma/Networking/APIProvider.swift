//
//  APIProvider.swift
//  Diploma
//
//  Created by Egor on 5/4/18.
//  Copyright © 2018 egor. All rights reserved.
//

import Moya

class APIProvider: MoyaProvider<APIService> {
    
    static let shared = APIProvider(
        plugins: [authPlugin]
    )
    
    static var authPlugin: AccessTokenPlugin {
        return AccessTokenPlugin(tokenClosure: Authorizer.authToken ?? "")
    }
    
    var requests = [Cancellable]()

    @discardableResult
    override func request(_ target: APIService,
                          callbackQueue: DispatchQueue? = nil,
                          progress: ProgressBlock? = nil,
                          completion: @escaping Completion) -> Cancellable {
        
        let request = super.request(target,
                                    callbackQueue: callbackQueue,
                                    progress: progress)
        { result in
            
            switch target {
            case .login(email: _, password: _):
                break
            default:
                if let statusCode = result.value?.statusCode, statusCode == 401 {
                    // Unauthorize
                    return Authorizer.logout()
                }
            }
            completion(result)
        }
        requests.append(request)
        
        return request
    }
    
    func cancelRequests() {
        requests.forEach{ $0.cancel() }
    }
    
}

