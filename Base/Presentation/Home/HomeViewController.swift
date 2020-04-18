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
    
    var interactor: HomeBusinessLogic?

    override func viewDidLoad() {
        super.viewDidLoad()

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
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
}
