//
//  URLParameterEncoding.swift
//  jogo-ios
//
//  Created by Juan Felipe Gallo on 8/30/19.
//  Copyright © 2019 jogo. All rights reserved.
//

import Foundation

 struct URLParameterEncoder: ParameterEncoder {
    
     static func encode(urlRequest: inout URLRequest, with parameters: RequestParameters) throws {
        guard let url = urlRequest.url else { throw NetworkError.missingURL }
        
        if var urlComponents = URLComponents(url: url,
                                             resolvingAgainstBaseURL: false), !parameters.isEmpty {
            urlComponents.queryItems = [URLQueryItem]()
            
            for (key, value) in parameters {
                let queryItem = URLQueryItem.init(name: key,
                    value: "\(value)".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed))
                urlComponents.queryItems?.append(queryItem)
            }
            urlRequest.url = urlComponents.url
        }
        
        if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
            urlRequest.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
        }
    }
}
