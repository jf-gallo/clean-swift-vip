//
//  DetailInteractor.swift
//  Base
//
//  Created by Juan Felipe Gallo on 4/18/20.
//  Copyright © 2020 Juan Felipe Gallo. All rights reserved.
//

import Foundation

struct DetailInteractorDependencies {
    let getPosts: GetPostsUseCase = GetPostsAdapter()
}

protocol DetailBusinessLogic {
    var dependencies: DetailInteractorDependencies { get }

}

final class DetailInteractor: DetailBusinessLogic {
    var dependencies: DetailInteractorDependencies
    let presenter: DetailPresentationLogic?
    var posts: [Post]?
    
    init(presenter: DetailPresentationLogic, dependencies: DetailInteractorDependencies = .init()){
        self.presenter = presenter
        self.dependencies = dependencies
    }
}
