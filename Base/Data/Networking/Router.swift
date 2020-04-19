//
//  Router.swift
//  Base
//
//  Created by Juan Felipe Gallo on 4/18/20.
//  Copyright © 2020 Juan Felipe Gallo. All rights reserved.
//

import Foundation

enum URLEndpoint: String  {
    case getPosts
    case getComments
    case getUsers
}

extension URLEndpoint {
    
    private var baseURL: String {
        return "https://jsonplaceholder.typicode.com"
    }
    
    private var endpoint: String {
        switch self {
        case .getComments:
            return "/comments"
        case .getPosts:
            return "/posts"
        case .getUsers:
            return "/users"
        }
    }
    
    var url: String {
        return baseURL+endpoint
    }
}
