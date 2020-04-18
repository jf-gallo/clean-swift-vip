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
    
    var interactor: HomeBusinessLogic?
    var posts: [PostViewModel]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 80.0
        
        setupVIP()
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
        return posts?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        cell.textLabel?.text = posts?[indexPath.row].model.body
        cell.textLabel?.numberOfLines = 0 
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    
    
}
