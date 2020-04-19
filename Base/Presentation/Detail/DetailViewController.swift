//
//  DetailViewController.swift
//  Base
//
//  Created by Juan Felipe Gallo on 4/18/20.
//  Copyright © 2020 Juan Felipe Gallo. All rights reserved.
//


import UIKit

protocol DetailDisplayLogic: class {
    func setupVIP()
    func display(user: User)
    func display(comments:[Comment])
    func display(post: PostViewModel)
    func postHasBeenViewed()
}



class DetailViewController: UIViewController, DetailDisplayLogic {
                
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var body: UITextView!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var website: UILabel!
    
    @IBAction func deleteAllButtonAction(_ sender: Any) {
    }
            
    weak var postUptadeDelegate: PostUpdatesDelegate?
    var interactor: DetailBusinessLogic?
    var post: PostViewModel!
    var comments: [Comment]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 80.0
        
        setupVIP()
        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        guard let post = self.post else {
            assertionFailure("No Post to Display!")
            return
        }
        display(post: post)
        postHasBeenViewed()
    }
    
    func setupUI(){
        setupNavigationBar()
    }
        
    func setupNavigationBar(){
        let favoriteButton = UIBarButtonItem.init(image: post.favoriteIcon, style: .plain, target: self, action: #selector(setFavorite))
        self.navigationItem.rightBarButtonItem = favoriteButton
    }
    
    @objc func setFavorite() {
        let isFavorite = post.isFavorite
        post.isFavorite = !isFavorite
        postUptadeDelegate?.toggleFavorite(id: post.model.id, to: !isFavorite)
    }
    
    func postHasBeenViewed() {
        if post.hasBeenRead {
            return
        }
        postUptadeDelegate?.postViewed(id: post.model.id)
    }
    
    func setupVIP()
    {
        let presenter = DetailPresenter.init(viewController: self)
        let interactor = DetailInteractor(presenter: presenter)
        self.interactor = interactor
    }
    
    func display(post: PostViewModel) {
        descriptionLabel.text = post.model.title
        body.text = post.model.body
    }
    
    func display(user: User) {
        
    }
    
    func display(comments: [Comment]) {
        self.comments = comments
        tableView.reloadData()
    }
}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        guard let comment = comments?[indexPath.row] else {
            return cell
        }
        cell.textLabel?.numberOfLines = 0
                
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
}

