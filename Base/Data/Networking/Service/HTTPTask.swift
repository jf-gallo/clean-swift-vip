//
//  HTTPTask.swift
//
//  Created by Juan Felipe Gallo on 8/30/19.
//  Copyright © 2019 jogo. All rights reserved.
//

import Foundation

typealias HTTPHeaders = [String:String]

enum HTTPTask {
    case request
    case requestParameters(bodyParameters: RequestParameters? = nil,
        urlParameters: RequestParameters? = nil)
    case requestParametersAndHeaders(bodyParameters: RequestParameters? = nil,
        urlParameters: RequestParameters? = nil,
        bodyFormData: RequestParameters? = nil,
        additionHeaders: HTTPHeaders? = nil)
}
