//
//  ParameterEncoding.swift
//  jogo-ios
//
//  Created by Juan Felipe Gallo on 8/30/19.
//  Copyright © 2019 jogo. All rights reserved.
//

import Foundation

 protocol ParameterEncoder {
    static func encode(urlRequest: inout URLRequest, with parameters: RequestParameters) throws
}
