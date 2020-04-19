//
//  DetailPresenter.swift
//  Base
//
//  Created by Juan Felipe Gallo on 4/18/20.
//  Copyright © 2020 Juan Felipe Gallo. All rights reserved.
//

import Foundation

protocol DetailPresentationLogic: class {
    var viewController: DetailDisplayLogic? { get }
    func present(comments: [Comment])
    func present(user: User)
    func present(failiure: String)
}

class DetailPresenter: DetailPresentationLogic {
    
    weak var viewController: DetailDisplayLogic?
    var posts: [PostViewModel]?
    
    init(viewController: DetailDisplayLogic){
        self.viewController = viewController
    }
    
    func present(failiure: String) {
        
    }
    
    func present(comments: [Comment]) {
        viewController?.display(comments: comments)
    }
    
    func present(user: User) {
        viewController?.display(user: user)
    }
    
    
}

