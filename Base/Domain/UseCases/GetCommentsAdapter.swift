//
//  GetPostsAdapter.swift
//  Base
//
//  Created by Juan Felipe Gallo on 4/17/20.
//  Copyright © 2020 Juan Felipe Gallo. All rights reserved.
//

import Foundation

struct GetCommentsDependencies {
    let service = GetCommentsWebService<Comment>()
}

final class GetCommentsAdapter: GetCommentsUseCase {
    
    func search(for comentId: Int, completion: @escaping serviceCompletion<Comment>) {
        dependencies.service.getComments(for: comentId) { (response) in
              switch response {
              case .success(let posts):
                  completion(.success(posts))
              case .failure(let error):
                  completion(.failure(error))
              }
          }
    }
    

    var dependencies: GetCommentsDependencies
    
    init(dependencies: GetCommentsDependencies = .init() ) {
        self.dependencies = dependencies
    }
}
