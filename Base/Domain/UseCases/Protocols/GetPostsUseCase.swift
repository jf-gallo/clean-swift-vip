//
//  GetPostsUseCase.swift
//  Base
//
//  Created by Juan Felipe Gallo on 4/17/20.
//  Copyright © 2020 Juan Felipe Gallo. All rights reserved.
//

import Foundation

protocol Dependencies {
    
}
protocol GetPostsUseCase {
    var dependencies: GetPostsDependencies { get }
    func execute(request: Parameters?, completion: @escaping serviceCompletion<Post>)
}
