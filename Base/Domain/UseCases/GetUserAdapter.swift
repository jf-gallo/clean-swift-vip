//
//  GetPostsAdapter.swift
//  Base
//
//  Created by Juan Felipe Gallo on 4/17/20.
//  Copyright © 2020 Juan Felipe Gallo. All rights reserved.
//

import Foundation

struct GetUserDependencies {
    let service = GetUserWebService<User>()
}

final class GetUserAdapter: GetUserUseCase {
    
    var dependencies: GetUserDependencies
    
    init(dependencies: GetUserDependencies = .init() ) {
        self.dependencies = dependencies
    }
    
    func search(userId: Int, completion: @escaping serviceCompletion<User>)
    {
        
        dependencies.service.get(userId: userId) { (response) in
            switch response {
            case .success(let user):
                completion(.success(user))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
