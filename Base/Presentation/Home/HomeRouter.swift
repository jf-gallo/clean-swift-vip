//
//  HomeRouter.swift
//  Base
//
//  Created by Juan Felipe Gallo on 4/18/20.
//  Copyright © 2020 Juan Felipe Gallo. All rights reserved.
//

import UIKit

protocol HomeRoutingLogic
{
    func routeToDetail(post: Post)
}

class HomeRouter: NSObject, HomeRoutingLogic
{
    
    weak var viewController: HomeViewController?

    init(viewController: HomeViewController) {
        self.viewController = viewController
    }
    
    // MARK: Routing
    
    func routeToDetail(post: Post) {
        let storyboard = UIStoryboard(name: "Detail", bundle: nil)
        let destinationVC = storyboard.instantiateInitialViewController()?.children.first as! DetailViewController
        destinationVC.post = post
        navigateToViewController(source: viewController!, destination: destinationVC)
    }
    
    //   MARK: Navigation
    
    func navigateToViewController(source: UIViewController, destination: UIViewController)
    {
        source.show(destination, sender: nil)
    }
    
}
