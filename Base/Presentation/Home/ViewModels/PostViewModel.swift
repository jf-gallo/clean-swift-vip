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
    var isFavorite: Bool?
    var hasBeenRead: Bool = true
    
    var readIcon: UIImage {
        return UIImage.init(systemName: "circle.fill")!
    }
    
    var favoriteIcon: UIImage {
        return (isFavorite ?? false) ? UIImage.init(systemName: "star.fill")! : UIImage.init(systemName: "star")!
    }
    
    var cellIcon: UIImage {
        
        guard hasBeenRead else {
            return self.readIcon
        }
        
        return self.favoriteIcon 
    }
    
    init(model: Post) {
        self.model = model
    }
}
