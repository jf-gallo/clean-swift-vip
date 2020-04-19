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
    func deleteAllPosts()
    var posts: [Post]! { get set }
    func update(post: Post)
    func deletePost(at index: Int)
}

final class HomeInteractor: HomeBusinessLogic {
    let dependencies: InteractorDependencies
    let presenter: HomePresentationLogic?
    
    var posts: [Post]!
    
    init(presenter: HomePresentationLogic? = nil, dependencies: InteractorDependencies = .init()){
        self.presenter = presenter
        self.dependencies = dependencies
    }
    
    func getPosts() {
        dependencies.getPosts.getAllPosts() { [weak self] (response) in
            switch response {
            case .success(let posts):
                self?.posts = posts
                self?.presenter?.present(posts: posts!)
                break
            case .failure(let error):
                self?.presenter?.present(failiure: error?.asAFError?.errorDescription ?? "failed to get posts")
                break
            }
        }
    }
    
    func deleteAllPosts() {
        self.posts = nil
        presenter?.deleteAllPosts()
    }
    
    func deletePost(at index: Int) {
        guard index >= 0, index <= posts.count else { return }
         self.posts.remove(at: index)
     }
    
    func update(post: Post) {
        guard let index = posts.firstIndex(where: { $0.id == post.id}) else {
            return
        }
        posts?[index] = post
    }
}

