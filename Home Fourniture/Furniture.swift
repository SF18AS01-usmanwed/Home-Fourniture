//
//  Furniture.swift
//  Home Fourniture
//
//  Created by Ousmane Ouedraogo on 3/27/19.
//  Copyright © 2019 Ousmane Ouedraogo. All rights reserved.
//

import Foundation
class Furniture {
    let name: String
    let description: String
    var imageData: Data?
    
    init(name: String, description: String, imageData: Data? = nil) {
        self.name = name
        self.description = description
        self.imageData = imageData
    }
}
