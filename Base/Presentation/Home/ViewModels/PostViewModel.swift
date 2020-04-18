//
//  PostViewModel.swift
//  Base
//
//  Created by Juan Felipe Gallo on 4/18/20.
//  Copyright © 2020 Juan Felipe Gallo. All rights reserved.
//

import Foundation
import UIKit

struct PostViewModel {
    let model: Post
    var isFavorite: Bool = false
    var hasBeenRead: Bool = false
    
    var icon: UIImage? {
        if isFavorite {
            return UIImage.init(systemName: "star")
        } else {
            return hasBeenRead ? nil : UIImage.init(systemName: "circle.fill")
        }
    }
    
    init(model: Post) {
        self.model = model
    }
    
    
}
