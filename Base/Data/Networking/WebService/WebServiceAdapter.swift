//
//  WebServiceAdapter.swift
//
//  Created by Juan Felipe Gallo on 9/6/19.
//  Copyright © 2019 jogo. All rights reserved.
//

import Foundation

// Concrete type wrapper for WebService protocol

struct WebServiceAdapter: WebService {
    
    private var base: WebService
    private var parameters: RequestParameters?
    
    var requestParameters: RequestParameters?
    
    init(_ base: WebService, parameters: RequestParameters? = nil) {
        self.base = base
        self.parameters = parameters
    }
    
    var baseURL: URL {
        get { return base.baseURL }
    }
    var path: String {
        get { return base.path }
    }
    var httpMethod: HTTPMethod {
        get { return base.httpMethod }
    }
    var task: HTTPTask? {
        get { return base.task }
    }
    var headers: HTTPHeaders?{
        get { return base.headers
        }
    }
}
