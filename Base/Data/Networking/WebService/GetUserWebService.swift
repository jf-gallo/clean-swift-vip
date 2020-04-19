//
//  BaseService.swift
//  Base
//
//  Created by Juan Felipe Gallo on 4/18/20.
//  Copyright © 2020 Juan Felipe Gallo. All rights reserved.
//

import Foundation
import Alamofire

final class GetUserWebService<T> where T: Decodable {
    func get(userId:Int, completion: @escaping serviceCompletion<T>) {
        
        print("Will execute request with UserID\(userId))")
        
        AF.request(URLEndpoint.getUsers.url+"?id=\(userId)").responseDecodable(of: [T].self) { (response) in
            print(response)
            guard let result = response.value else {
                completion(.failure(response.error))
                return
            }
            completion(.success(result))
        }
    }
}
