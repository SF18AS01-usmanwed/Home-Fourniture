//
//  Room.swift
//  Home Fourniture
//
//  Created by Ousmane Ouedraogo on 3/27/19.
//  Copyright © 2019 Ousmane Ouedraogo. All rights reserved.
//

import Foundation
class Room {
    let name: String
    let furniture: [Furniture]
    
    init(name: String, furniture: [Furniture]) {
        self.name = name
        self.furniture = furniture
    }
}
