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
}

class HomePresenter: HomePresentationLogic {
    
    weak var viewController: HomeDisplayLogic?
    
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
    
    func present(failiure: String) {
        
    }
    
    private func getViewModels(from posts: [Post]) -> [PostViewModel] {
        let posts = posts.compactMap({ return PostViewModel(model: $0)})
        // TODO ADD READ FLAG = False
        return posts
    }
    
}
