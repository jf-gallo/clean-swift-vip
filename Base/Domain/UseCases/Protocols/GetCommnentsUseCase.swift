//
//  GetPostsUseCase.swift
//  Base
//
//  Created by Juan Felipe Gallo on 4/17/20.
//  Copyright © 2020 Juan Felipe Gallo. All rights reserved.
//

import Foundation

protocol GetCommentsUseCase {
    var dependencies: GetCommentsDependencies { get }
    func search(for comentId: Int, completion: @escaping serviceCompletion<Comment>)
    
}

