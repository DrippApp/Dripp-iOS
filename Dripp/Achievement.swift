//
//  Achievement.swift
//  Dripp
//
//  Created by Henry Saniuk on 2/9/16.
//  Copyright © 2016 Henry Saniuk. All rights reserved.
//

import Foundation

class Achievement {
    let id: Int
    let title: String
    let description: String
    let image: String
    
    init(id: Int, title: String, description: String, image: String) {
        self.id = id
        self.title = title
        self.description = description
        self.image = image
    }
}