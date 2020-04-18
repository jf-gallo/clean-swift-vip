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
    }
    
    var displayAll: Bool = true {
        willSet(newValue) {
            if newValue == true {
                interactor?.showAllPosts()
            } else {
                interactor?.filterFavoritePosts()
            }
        }
    }
    
    var interactor: HomeBusinessLogic?
    var posts: [PostViewModel]?
    
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
        
        interactor.getPosts()
    }
    
    func display(posts: [PostViewModel]){
        self.posts = posts
        tableView.reloadData()
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        guard let post = posts?[indexPath.row] else {
            return cell
        }
        cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
        cell.imageView?.image = post.icon
        cell.textLabel?.text = posts?[indexPath.row].model.body
        cell.textLabel?.numberOfLines = 0
        
        if post.hasBeenRead {
            cell.imageView?.tintColor = UIColor.white
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70.0
    }
}
