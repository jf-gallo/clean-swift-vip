//
//  GetPostsUseCase.swift
//  Base
//
//  Created by Juan Felipe Gallo on 4/17/20.
//  Copyright © 2020 Juan Felipe Gallo. All rights reserved.
//

import Foundation

protocol GetUserUseCase {
    var dependencies: GetUserDependencies { get }
    func search(userId: Int, completion: @escaping serviceCompletion<User>)
}
