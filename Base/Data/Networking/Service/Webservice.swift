//
//  EndPointType.swift
//  jogo-ios
//
//  Created by Juan Felipe Gallo on 8/30/19.
//  Copyright © 2019 jogo. All rights reserved.
//

import Foundation

typealias RequestParameters = [String: Any]

protocol WebService {    
    var requestParameters: RequestParameters? { get }
    var baseURL: URL { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var task: HTTPTask? { get }
    var headers: HTTPHeaders? { get }
}

