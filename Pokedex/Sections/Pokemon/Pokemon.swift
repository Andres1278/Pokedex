//
//  Pokemon.swift
//  Pokedex
//
//  Created by Pedro Andres Villamil on 23/08/20.
//  Copyright © 2020 Pedro Andres Villamil. All rights reserved.
//

import Foundation

struct Pokemon: Codable {
    let name: String
    let weight: Int
    let base_experience: Int
    let height: Int
    let sprites: Sprite
    let types: [Type]
    let moves: [PokemonMoves]
    let stats: [PokemonStat]
    let abilities: [PokemonAbility]
    
    struct PokemonAbility: Codable {
        let ability: Ability
    }
    
    struct Ability: Codable {
        let name: String
    }
    
    struct PokemonStat: Codable {
        let stat: Stat
        let base_stat: Int
    }
    
    struct Stat: Codable {
        let name: String
    }
    
    struct PokemonMoves: Codable {
        let move: Move
    }
    
    struct Move: Codable {
        let name: String
    }
    
    struct Sprite: Codable {
        let front_default: URL
    }
    
    struct `Type`: Codable {
        let type: NameType
    }
    
    struct NameType: Codable {
        let name: String
    }
}
