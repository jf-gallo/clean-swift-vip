//
//  GetUserWebService.swift
//
//  Created by Juan Felipe Gallo on 9/17/19.
//  Copyright © 2019 jogo. All rights reserved.
//


import Foundation

//enum GetPostsService {
//
//    case getUser
//}

struct GetWebserviceDependencies {
    
}

struct GetPostsService: WebService {
    
    let parameters: RequestParameters?
    
    init(parameters: RequestParameters? = nil){
        self.parameters = parameters
    }
        
    var requestParameters: RequestParameters? {
        return parameters
    }
    
    var environmentBaseURL : String {
        return WebServiceConstants.baseURL
    }
    
    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else{
            fatalError("baseURL could not be configured.")
            
        }
        return url
    }
    
    var path: String {
        return "posts"
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var task: HTTPTask? {
        
        return .requestParametersAndHeaders(bodyParameters: nil,
                                            urlParameters: parameters,
                                            bodyFormData: nil)
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
}
