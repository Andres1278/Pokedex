//
//  Move.swift
//  Pokedex
//
//  Created by Pedro Andres Villamil on 23/08/20.
//  Copyright © 2020 Pedro Andres Villamil. All rights reserved.
//

import Foundation

struct Move: Codable {
    let name: String
    let accuracy: Int?
    let pp: Int
    let power: Int?
    let type: MoveType
    let effect_entries: [Effect]
    
    struct Effect: Codable {
        let short_effect: String
    }
    
    struct MoveType: Codable {
        let name: String
        let url: URL
    }
}



