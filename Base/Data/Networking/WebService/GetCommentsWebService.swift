//
//  BaseService.swift
//  Base
//
//  Created by Juan Felipe Gallo on 4/18/20.
//  Copyright © 2020 Juan Felipe Gallo. All rights reserved.
//

import Foundation
import Alamofire

final class GetCommentsWebService<T> where T: Decodable {
    
    func getComments(for postId: Int, completion: @escaping serviceCompletion<T>) {
        print("Will execute request with PostID \(postId))")
        AF.request(URLEndpoint.getComments.url+"?postId=\(postId)").responseDecodable(of: [T].self) { (response) in
            print(response)
            guard let results = response.value else {
                completion(.failure(response.error))
                return
            }
            completion(.success(results))
        }
    }
}
