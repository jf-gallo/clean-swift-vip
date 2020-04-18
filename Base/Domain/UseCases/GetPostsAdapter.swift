//
//  GetPostsAdapter.swift
//  Base
//
//  Created by Juan Felipe Gallo on 4/17/20.
//  Copyright © 2020 Juan Felipe Gallo. All rights reserved.
//

import Foundation

struct GetPostsDependencies: Dependencies {
     var service = WebServiceRequest<Post>()
 }

final class GetPostsAdapter: GetPostsUseCase {

    var dependencies: GetPostsDependencies
    
    init(dependencies: GetPostsDependencies = .init() ) {
        self.dependencies = dependencies
    }
    
    func execute(request: RequestParameters?, completion: @escaping serviceCompletion<Post>) {
        
        let request = WebServiceAdapter.init(GetPostsService.get(parameters: request))
        
        dependencies.service.makeRequest(for: request) { (result) in
            switch result {
            case .success(let posts):
                completion(.success(posts))
            case .failure(let error):
                completion(.failure(error))
            }
        }

    }
}
