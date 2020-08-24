//
//  APIListResponse.swift
//  Pokedex
//
//  Created by Pedro Andres Villamil on 23/08/20.
//  Copyright © 2020 Pedro Andres Villamil. All rights reserved.
//

import Foundation

struct APIListResponse: Codable{
    struct Result: Codable {
        let name: String
        let url: URL
    }
    let results: [Result]
    let next: URL
    let count: Int
}
