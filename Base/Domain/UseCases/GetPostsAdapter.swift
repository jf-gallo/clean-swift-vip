//
//  GetPostsAdapter.swift
//  Base
//
//  Created by Juan Felipe Gallo on 4/17/20.
//  Copyright © 2020 Juan Felipe Gallo. All rights reserved.
//

import Foundation
import Alamofire

struct GetPostsDependencies: Dependencies {}

final class GetPostsAdapter: GetPostsUseCase {

    var dependencies: GetPostsDependencies
    
    init(dependencies: GetPostsDependencies = .init() ) {
        self.dependencies = dependencies
    }
    
    func execute(request: Parameters?, completion: @escaping serviceCompletion<Post>) {
        
        AF.request("https://jsonplaceholder.typicode.com/posts").responseDecodable(of: [Post].self) { (response) in
            
            guard let posts = response.value else {
                completion(.failure(response.error))
                return
            }
            
            completion(.success(posts))
        }
    }
}
