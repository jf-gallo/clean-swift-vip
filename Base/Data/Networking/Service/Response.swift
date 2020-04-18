//
//  Response.swift
//  jogo-ios
//
//  Created by Juan Felipe Gallo on 9/24/19.
//  Copyright © 2019 jogo. All rights reserved.
//

import Foundation

typealias requestError = String

enum ServiceResponse<T> {
    case success([T]?)
    case failure(requestError?)
}

typealias serviceCompletion<T> = (ServiceResponse<T>) -> Void
