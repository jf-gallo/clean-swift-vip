//
//  HomePresenter.swift
//  Base
//
//  Created by Juan Felipe Gallo on 4/17/20.
//  Copyright © 2020 Juan Felipe Gallo. All rights reserved.
//

import Foundation

protocol HomePresentationLogic: class {
    var viewController: HomeDisplayLogic? { get }
}

class HomePresenter: HomePresentationLogic {
    weak var viewController: HomeDisplayLogic?
    
    init(viewController: HomeDisplayLogic){
        self.viewController = viewController
    }

}
