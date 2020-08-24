//
//  Item.swift
//  Pokedex
//
//  Created by Pedro Andres Villamil on 23/08/20.
//  Copyright © 2020 Pedro Andres Villamil. All rights reserved.
//

import Foundation

struct Item: Codable {
    let name: String
    let sprites: Sprite
    let cost:   Int
    let effect_entries: [Entrie]
    
    struct Entrie: Codable {
        let effect: String
    }
    
    struct Sprite: Codable {
        let `default`: URL
    }
}
