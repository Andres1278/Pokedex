//
//  PokemonListTableViewCell.swift
//  Pokedex
//
//  Created by Pedro Andres Villamil on 23/08/20.
//  Copyright © 2020 Pedro Andres Villamil. All rights reserved.
//

import UIKit

class PokemonListTableViewCell: UITableViewCell {

    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var pokemonNumberLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let selectedView = UIView()
        selectedView.backgroundColor = UIColor(red: 105 / 255, green: 185 / 255, blue: 227 / 255, alpha: 0.5)
        selectedBackgroundView = selectedView
    }

    func configure(with pokemon: APIListResponse.Result) {
        let name = pokemon.name.replacingOccurrences(of: "-", with: " ")
        pokemonNameLabel.text = name.capitalized
        let components = pokemon.url.absoluteString.components(separatedBy: "/").dropLast()
        guard let pokemonNumber = components.last, let number = Int(pokemonNumber) else { return }
        pokemonNumberLabel.text = String(format: "#%03d", number)
    }
}
