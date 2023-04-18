//
//  File.swift
//  
//
//  Created by Kris on 4/6/23.
//

import SwiftUI

struct Item
{
    let id: Int
    let type: ItemType
}

enum ItemType {
    case box
    case paper
    case lock
    case boom
}


extension Item {
    static let box = Item(id: 0, type: .box)
    
    static let all = [
        Item(id: 1, type: .paper),
        Item(id: 2, type: .lock),
        Item(id: 3, type: .boom)
    ]
}
