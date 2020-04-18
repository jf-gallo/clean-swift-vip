//
//  NetworkRouter.swift
//  jogo-ios
//
//  Created by Juan Felipe Gallo on 8/30/19.
//  Copyright © 2019 jogo. All rights reserved.
//

import Foundation

public typealias networkRouterCompletion = (_ data: Data?, _ response: URLResponse?, _ error: Error?)->()

protocol NetworkRouter: class {
    associatedtype EndPoint: WebService
    func request(_ route:EndPoint, completion: @escaping networkRouterCompletion)
    func cancel()
}
