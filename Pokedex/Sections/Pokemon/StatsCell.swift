//
//  StatsCell.swift
//  Pokedex
//
//  Created by Pedro Andres Villamil on 23/08/20.
//  Copyright © 2020 Pedro Andres Villamil. All rights reserved.
//

import UIKit

class StatsCell: UITableViewCell {
    
    var stats: [Pokemon.PokemonStat]?
    
    @IBOutlet weak var HPLabel: UILabel!
    @IBOutlet weak var HPProgress: UIProgressView!
    @IBOutlet weak var ATKLabel: UILabel!
    @IBOutlet weak var ATKProgress: UIProgressView!
    @IBOutlet weak var DEFLabel: UILabel!
    @IBOutlet weak var DEFProgress: UIProgressView!
    @IBOutlet weak var SATKLabel: UILabel!
    @IBOutlet weak var SATKProgress: UIProgressView!
    @IBOutlet weak var SDFELabel: UILabel!
    @IBOutlet weak var SDFEProgress: UIProgressView!
    @IBOutlet weak var SPDLabel: UILabel!
    @IBOutlet weak var SPDProgress: UIProgressView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func configure(with stats: [Pokemon.PokemonStat]) {
        stats.forEach {
            switch $0.stat.name {
            case "hp":
                HPLabel.text = "\($0.base_stat)"
                HPProgress.progress =  Float($0.base_stat) / 100
            case "attack":
                ATKLabel.text = "\($0.base_stat)"
                ATKProgress.progress = Float($0.base_stat) / 100
            case "defense":
                DEFLabel.text = "\($0.base_stat)"
                DEFProgress.progress = Float($0.base_stat) / 100
            case "special-attack":
                SATKLabel.text = "\($0.base_stat)"
                SATKProgress.progress = Float($0.base_stat) / 100
            case "special-defense":
                SDFELabel.text = "\($0.base_stat)"
                SDFEProgress.progress = Float($0.base_stat) / 100
            case "speed":
                SPDLabel.text = "\($0.base_stat)"
                SPDProgress.progress = Float($0.base_stat) / 100
            default:
                return
            }
        }
    }
}
