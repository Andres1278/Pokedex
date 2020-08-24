//
//  MovesTableViewCell.swift
//  Pokedex
//
//  Created by Pedro Andres Villamil on 23/08/20.
//  Copyright © 2020 Pedro Andres Villamil. All rights reserved.
//

import UIKit

class MovesTableViewCell: UITableViewCell {

    @IBOutlet weak var moveLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with move: APIListResponse.Result) {
        let name = move.name.replacingOccurrences(of: "-", with: " ")
        moveLabel.text = name.capitalized
      }
}

//override func awakeFromNib() {
//      super.awakeFromNib()
//      let selectedView = UIView()
//      selectedView.backgroundColor = UIColor(red: 105 / 255, green: 185 / 255, blue: 227 / 255, alpha: 0.5)
//      selectedBackgroundView = selectedView
//  }
//
//  func configure(with pokemon: Pokemon, index: Int) {
//      pokemonNameLabel.text = pokemon.name.capitalized
//      pokemonNumberLabel.text = String(format: "#%03d", index + 1)
//  }
