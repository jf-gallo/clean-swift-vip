//
//  HomeViewController.swift
//  Base
//
//  Created by Juan Felipe Gallo on 4/17/20.
//  Copyright © 2020 Juan Felipe Gallo. All rights reserved.
//

import UIKit

protocol HomeDisplayLogic: class {
    func setupVIP()
    func display(posts: [PostViewModel])
}

protocol PostUpdatesDelegate: AnyObject {
    func postViewed(id: Int)
    func toggleFavorite(id: Int, to value: Bool)
}

class HomeViewController: UIViewController, HomeDisplayLogic {
    
    @IBOutlet weak var segmentedControlOutlet: UISegmentedControl!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var deleteAllButton: UIButton!
    
    @IBAction func deleteAllButtonAction(_ sender: Any) {
        self.posts = nil
        tableView.reloadData()
    }
    
    @IBAction func segmentDidChange(_ sender: UISegmentedControl) {
        displayAll = !displayAll
        tableView.reloadData()
    }

    var posts: [PostViewModel]!

    var favoritePosts: [PostViewModel] {
        return posts.filter({ $0.isFavorite })
    }
    var tableViewPosts: [PostViewModel]? {
        return displayAll ? posts : favoritePosts
    }
    
    var displayAll: Bool = true
    
    var interactor: HomeBusinessLogic?
    var router: HomeRoutingLogic?
            
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 80.0
        
        displayAll = true
        setupVIP()
        setupUI()
    }
    
    func setupUI(){
        setupSegmentedControll()
        setupNavigationBar()
    }
    
    func setupSegmentedControll(){
        
        let selectedTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        let unselectedTitleTextAttributes = [NSAttributedString.Key.foregroundColor: Constants.GreenColor]
        
        segmentedControlOutlet.setTitleTextAttributes(unselectedTitleTextAttributes, for: .normal)
        segmentedControlOutlet.setTitleTextAttributes(selectedTitleTextAttributes, for: .selected)
        
        segmentedControlOutlet.selectedSegmentTintColor = Constants.GreenColor
        segmentedControlOutlet.layer.borderWidth = 2
        segmentedControlOutlet.layer.borderColor = Constants.GreenColor.cgColor
    }
    
    func setupNavigationBar(){
        let refreshButton = UIBarButtonItem.init(barButtonSystemItem: .refresh, target: self, action: #selector(refresh))
        refreshButton.tintColor = UIColor.white
        self.navigationItem.rightBarButtonItem = refreshButton
    }
    
    @objc func refresh() {
        interactor?.getPosts()
    }
    
    func setupVIP()
    {
        let presenter = HomePresenter.init(viewController: self)
        let interactor = HomeInteractor(presenter: presenter)
        self.interactor = interactor
        self.router = HomeRouter(viewController: self)
        
        interactor.getPosts()
    }
    
    func display(posts: [PostViewModel]){
        self.posts = posts
        tableView.reloadData()
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewPosts?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        guard let post = tableViewPosts?[indexPath.row] else {
            return cell
        }
        cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
        cell.imageView?.image = post.cellIcon
        cell.textLabel?.text = post.model.body
        cell.textLabel?.numberOfLines = 0
        
        if post.hasBeenRead && !post.isFavorite {
            cell.imageView?.tintColor = UIColor.white
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let post = posts?[indexPath.row] else { return }
        router?.routeToDetail(post: post)
    }
}

extension HomeViewController: PostUpdatesDelegate {
    
    func postViewed(id: Int) {
        
        guard let index = posts?.firstIndex(where: { $0.model.id == id}),
        let toggle = posts?[index].hasBeenRead else {
            assertionFailure("NO post with same id matched id received")
            return
            }
        
        posts?[index].hasBeenRead = !toggle
        interactor?.update(post: posts[index].model)
        
        self.tableView.reloadData()
    }
    
    func toggleFavorite(id: Int, to value: Bool) {
        guard let index = posts?.firstIndex(where: { $0.model.id == id}) else {
            assertionFailure("NO post with same id matched id received")
            return
            }
        
        posts?[index].isFavorite = value
        interactor?.update(post: posts[index].model)
        
        self.tableView.reloadData()
    }
    
    
}
