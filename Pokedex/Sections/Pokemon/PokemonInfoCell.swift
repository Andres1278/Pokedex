//
//  AbilityCell.swift
//  Pokedex
//
//  Created by Pedro Andres Villamil on 23/08/20.
//  Copyright © 2020 Pedro Andres Villamil. All rights reserved.
//

import UIKit

class PokemonInfoCell: UITableViewCell {
    
    @IBOutlet weak var abilityLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with string: String) {
        let text = string.replacingOccurrences(of: "-", with: " ")
        abilityLabel.text = text.capitalized
    }

}
