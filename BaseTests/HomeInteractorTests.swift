//
//  BaseTests.swift
//  BaseTests
//
//  Created by Juan Felipe Gallo on 4/17/20.
//  Copyright © 2020 Juan Felipe Gallo. All rights reserved.
//

import XCTest
@testable import Base

class HomeInteractorTests: XCTestCase {
    
    var interactor: HomeInteractor!
    
    override func setUp() {
        interactor = HomeInteractor()
    }
    
    override func tearDown() {
        interactor = nil
    }
    
    func testUpdatePostSuccess() {
        
        // Given
        let posts = createPosts()
        let postToBeReplaced = Post.init(userId: 878, id: 677, title: "initial", body: "Initial")
        let postToReplaceWith = Post.init(userId: 999, id: 677, title: "replaced", body: "replaced")
        
        // Then
        interactor.posts = posts
        interactor.posts.append(postToBeReplaced)
        interactor.update(post: postToReplaceWith)
        
        // When
        
        guard let updatedPost = interactor.posts.first(where: { $0.id == postToBeReplaced.id }) else {
            XCTFail("failed to update post")
            return
        }
        XCTAssertTrue(updatedPost.body == "replaced", "Failed to replace post in interactor")
        
    }
    
    func testUpdatePostFail() {
        
        // Given
        let posts = createPosts()
        let postToBeReplaced = Post.init(userId: 878, id: 677, title: "initial", body: "Initial")
        let postToReplaceWith = Post.init(userId: 999, id: 687, title: "replaced", body: "replaced")
        
        // Then
        interactor.posts = posts
        interactor.posts.append(postToBeReplaced)
        interactor.update(post: postToReplaceWith)
        
        // When
        XCTAssertNil(interactor.posts.first(where: { $0.id == postToReplaceWith.id }))
        
        
    }
    
    func testDeletePostSuccess() {
        
        // Given
        let posts = createPosts()
        let postToBeDeleted = Post.init(userId: 878, id: 677, title: "initial", body: "Initial")
        
        // Then
        interactor.posts = posts
        interactor.posts.append(postToBeDeleted)
        guard let index = interactor.posts.firstIndex(where: {$0.id == postToBeDeleted.id }) else {
            XCTFail("Cant get index for post to be deleted")
            return
        }
        
        interactor.deletePost(at: index)
        
        XCTAssertNil(interactor.posts.first(where: { $0.id == postToBeDeleted.id}), "Failed to delete post")
        
    }
    
    func testDeletePostFail() {
        
        // Given
        let posts = createPosts()
        let postToBeDeleted = Post.init(userId: 878, id: 677, title: "initial", body: "Initial")
        
        // Then
        interactor.posts = posts
        interactor.posts.append(postToBeDeleted)
        
        // index out of bounds
        let index = 899
        
        interactor.deletePost(at: index)
        
        XCTAssertTrue(interactor.posts.firstIndex(where: {$0.id == postToBeDeleted.id}) != nil, "failed to fail :(")
        
    }
    
    func createPosts() -> [Post] {
        var posts: [Post] = []
        for _ in 0...20 {
            let id = Int.random(in: 0...200)
            let user = Int.random(in: 0...200)
            let title = "title"
            let body = "body"
            let post = Post.init(userId: user, id: id, title: title, body: body)
            posts.append(post)
        }
        return posts
    }
}
