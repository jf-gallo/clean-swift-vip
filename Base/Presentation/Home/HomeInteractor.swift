//
//  HomeInteractor.swift
//  Base
//
//  Created by Juan Felipe Gallo on 4/17/20.
//  Copyright © 2020 Juan Felipe Gallo. All rights reserved.
//

import Foundation

struct InteractorDependencies {
    
}

protocol HomeBusinessLogic {
    var dependencies: InteractorDependencies { get }
}

final class HomeInteractor: HomeBusinessLogic {
    
    let dependencies: InteractorDependencies
    
    let presenter: HomePresentationLogic?
    
    init(presenter: HomePresentationLogic, dependencies: InteractorDependencies = .init()){
        self.presenter = presenter
        self.dependencies = dependencies
    }
    
}
