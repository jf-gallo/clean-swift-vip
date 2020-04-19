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
    var isFavorite: Bool
    var hasBeenRead: Bool = false
    
    var readIcon: UIImage {
       return hasBeenRead ? UIImage.init(systemName: "checkmark")! : UIImage.init(systemName: "circle.fill")!
    }
    
    var favoriteIcon: UIImage {
        return isFavorite ? UIImage.init(systemName: "star")! : UIImage.init(systemName: "checkmark")!
    }
    
    var cellIcon: UIImage {
        
        guard hasBeenRead else {
            return self.readIcon
        }
        
        return self.favoriteIcon 
    }
    
    init(model: Post, isFavorite: Bool = false) {
        self.model = model
        self.isFavorite = isFavorite
    }
}
