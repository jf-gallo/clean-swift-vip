//
//  HomeInteractor.swift
//  Base
//
//  Created by Juan Felipe Gallo on 4/17/20.
//  Copyright © 2020 Juan Felipe Gallo. All rights reserved.
//

import Foundation

struct InteractorDependencies {
    let getPosts: GetPostsUseCase = GetPostsAdapter()
}

protocol HomeBusinessLogic {
    var dependencies: InteractorDependencies { get }
    func getPosts()
    func filterFavoritePosts()
    func showAllPosts()
    func deleteAllPosts()
}

final class HomeInteractor: HomeBusinessLogic {
    
    let dependencies: InteractorDependencies
    let presenter: HomePresentationLogic?
    var posts: [Post]?
    
    init(presenter: HomePresentationLogic, dependencies: InteractorDependencies = .init()){
        self.presenter = presenter
        self.dependencies = dependencies
    }
    
    func getPosts() {
            dependencies.getPosts.execute(request: nil) { [weak self] (response) in
                switch response {
                case .success(let posts):
                    self?.presenter?.present(posts: posts!)
                    break
                case .failure(let error):
                    self?.presenter?.present(failiure: error?.asAFError?.errorDescription ?? "failed to get posts")
                    break
                }
            }
    }
    
    func filterFavoritePosts() {
        presenter?.presentFilteredPosts()
    }
    
    func showAllPosts() {
        presenter?.presentAllPosts()
    }
    
    func deleteAllPosts() {
        presenter?.deleteAllPosts()
    }
}
