//
//  NetworkError.swift
//  jogo-ios
//
//  Created by Juan Felipe Gallo on 8/30/19.
//  Copyright © 2019 jogo. All rights reserved.
//

import Foundation

public enum NetworkError: String, Error {
    case parametersNil = "Parameters Nil"
    case encodingFailed = "Parameter encoding failed"
    case missingURL = "URL is nil"
}
