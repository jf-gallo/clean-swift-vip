//
//  Response.swift
//  Base
//
//  Created by Juan Felipe Gallo on 4/18/20.
//  Copyright © 2020 Juan Felipe Gallo. All rights reserved.
//

import Foundation

enum ServiceResponse<T> {
    case success([T]?)
    case failure(Error?)
}

typealias serviceCompletion<T> = (ServiceResponse<T>) -> Void

