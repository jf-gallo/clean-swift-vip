//
//  DetailInteractor.swift
//  Base
//
//  Created by Juan Felipe Gallo on 4/18/20.
//  Copyright © 2020 Juan Felipe Gallo. All rights reserved.
//

import Foundation

struct DetailInteractorDependencies {
    let getUser: GetUserUseCase = GetUserAdapter()
    let getComments: GetCommentsUseCase = GetCommentsAdapter()
}

protocol DetailBusinessLogic {
    var dependencies: DetailInteractorDependencies { get }
    func getComments(for post: Post)
    func getUser(for post: Post)
}

final class DetailInteractor: DetailBusinessLogic {
    
    var dependencies: DetailInteractorDependencies
    let presenter: DetailPresentationLogic?
    var posts: [Post]?
    
    init(presenter: DetailPresentationLogic, dependencies: DetailInteractorDependencies = .init()){
        self.presenter = presenter
        self.dependencies = dependencies
    }
    
    func getComments(for post: Post) {
        self.dependencies.getComments.search(for: post.id) { [weak self] (response) in
            switch response {
            case .success(let comments):
                self?.presenter?.present(comments: comments!)
                break
            case .failure(let error):
                self?.presenter?.present(failiure: error.debugDescription)
                break
            }
        }
    }
    
    func getUser(for post: Post) {
        self.dependencies.getUser.search(userId: post.userId) { [weak self] (response) in
            switch response {
            case .success(let user):
                self?.presenter?.present(user: user!.first!)
                break
            case .failure(let error):
                self?.presenter?.present(failiure: error!.localizedDescription ?? "Failed to get user" )
                break
            }
        }
    }
}
