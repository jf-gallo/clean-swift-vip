//
//  NetworkResponse.swift
//
//  Created by Juan Felipe Gallo on 8/30/19.
//  Copyright © 2019 jogo. All rights reserved.
//

import Foundation

enum NetworkResponse: String {
    case success
    case authenticationError = "You need to be authenticated"
    case badRequest = "Bad Request"
    case outdated = "url outdated"
    case failed = "Network request failed"
    case noData = "Not data fetched from response"
    case unableToDecode = "Unable to decode from response"
}
