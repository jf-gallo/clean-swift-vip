//
//  BaseService.swift
//  Base
//
//  Created by Juan Felipe Gallo on 4/18/20.
//  Copyright © 2020 Juan Felipe Gallo. All rights reserved.
//

import Foundation
import Alamofire

final class GetPostsWebService<T> where T: Codable {
    
    func get(request: Parameters?, completion: @escaping serviceCompletion<T>) {
        AF.request(URLEndpoint.getPosts.url).responseDecodable(of: [T].self) { (response) in
            guard let results = response.value else {
                completion(.failure(response.error))
                return
            }
            completion(.success(results))
        }
    }
}
