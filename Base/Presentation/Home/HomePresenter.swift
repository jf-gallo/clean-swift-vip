//
//  HomePresenter.swift
//  Base
//
//  Created by Juan Felipe Gallo on 4/17/20.
//  Copyright © 2020 Juan Felipe Gallo. All rights reserved.
//

import Foundation

protocol HomePresentationLogic: class {
    var viewController: HomeDisplayLogic? { get }
    func present(posts: [Post])
    func present(failiure: String)
    func presentFilteredPosts()
    func presentAllPosts()
    func deleteAllPosts()
}

class HomePresenter: HomePresentationLogic {
    
    weak var viewController: HomeDisplayLogic?

    // Single Source of Truth
    var posts: [PostViewModel]?
    
    init(viewController: HomeDisplayLogic){
        self.viewController = viewController
    }
    
    func present(posts: [Post]) {
        DispatchQueue.main.async { [weak self] in
            guard let strongSelf = self else {
                return
            }
            strongSelf.viewController?.display(posts: strongSelf.getViewModels(from: posts))
        }
    }
    
    func presentFilteredPosts() {
        let filteredPosts = posts?.filter({ $0.isFavorite ?? false })
        viewController?.display(posts: filteredPosts!)
    }
    
    func presentAllPosts() {
        viewController?.display(posts: posts!)
    }
    
    func deleteAllPosts() {
        viewController?.display(posts: [])
    }
    
    func present(failiure: String) {
        
    }
    
    private func getViewModels(from posts: [Post]) -> [PostViewModel] {
        var posts = posts.compactMap({ return PostViewModel(model: $0)})
        for i in 0..<20 {
            posts[i].hasBeenRead = false
        }
        self.posts = posts
        return posts
    }
}
