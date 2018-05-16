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
        plugins: [AccessTokenPlugin(tokenClosure: Authorizer.authToken ?? "")]
    )
    
    var requests = [Cancellable]()

    @discardableResult
    override func request(_ target: APIService,
                          callbackQueue: DispatchQueue? = nil,
                          progress: ProgressBlock? = nil,
                          completion: @escaping Completion) -> Cancellable {
        
        let request = super.request(target,
                                    callbackQueue: callbackQueue,
                                    progress: progress,
                                    completion: completion)
        requests.append(request)
        
        return request
    }
    
    func cancelRequests() {
        requests.forEach{ $0.cancel() }
    }
    
}

