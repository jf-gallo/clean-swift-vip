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
            
    var interactor: DetailBusinessLogic?
    var post: Post?
    var comments: [Comment]?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 80.0
        
        setupVIP()
        setupUI()
    }
    
    func setupUI(){
        setupNavigationBar()
    }
        
    func setupNavigationBar(){
        let favoriteButton = UIBarButtonItem.init(barButtonSystemItem: .save, target: self, action: #selector(setFavorite))
        favoriteButton.tintColor = UIColor.white
        self.navigationItem.rightBarButtonItem = favoriteButton
    }
    
    @objc func setFavorite() {
    }
    
    func setupVIP()
    {
        let presenter = DetailPresenter.init(viewController: self)
        let interactor = DetailInteractor(presenter: presenter)
        self.interactor = interactor
    }
    
    func display(user: User) {
        
    }
    
    func display(comments: [Comment]) {
        self.comments = comments
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

