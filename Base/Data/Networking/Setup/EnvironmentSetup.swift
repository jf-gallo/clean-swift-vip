//
//  NetworkManager.swift
//  jogo-ios
//
//  Created by Juan Felipe Gallo on 8/30/19.
//  Copyright © 2019 jogo. All rights reserved.
//

import Foundation

enum NetworkEnvironment {
    case production
}

struct EnvironmentSetup {
    
    static let environment: NetworkEnvironment = .production
//    static var UserAPIKey = GetAccessToken().accessTokenData.access_token
    
}
