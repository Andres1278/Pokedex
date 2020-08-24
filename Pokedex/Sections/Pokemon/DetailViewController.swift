//
//  DetailViewController.swift
//  Pokedex
//
//  Created by Pedro Andres Villamil on 22/08/20.
//  Copyright © 2020 Pedro Andres Villamil. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var pokemonURL: URL?
    var pokemon: Pokemon?
    

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var typeStackView: UIStackView!
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cardView.layer.cornerRadius = 50
        cardView.layer.cornerCurve = .continuous
        tableView.delegate = self
        tableView.dataSource = self
        loadPokemon()
        


    }
    
    
    @IBAction func dismissButtonTapped(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    func loadPokemon() {
        guard let url = pokemonURL else { return }
        ServiceManger.request(to: url.absoluteString) { [weak self] (pokemon: Pokemon?, error) in
            guard let self = self,  let pokemon = pokemon else { return }
            self.pokemon = pokemon
            self.refreshUI()
            print(pokemon.moves)
            print(pokemon.stats)
            print(pokemon.abilities)
        }
    }
    
    func refreshUI() {
        edgesForExtendedLayout = [.all]
        extendedLayoutIncludesOpaqueBars = true
        guard let pokemon = pokemon else { return }
        nameLabel.text = pokemon.name.capitalized
        guard let backgroundImageName = pokemon.types.first?.type.name else { return }
        backgroundImageView.image = UIImage(named: "Move/Background/\(backgroundImageName.capitalized)")
        pokemon.types.forEach {
            typeStackView.addArrangedSubview( UIImageView(image: UIImage(named: "Move/Tag/\($0.type.name.capitalized)" )) )
        }
        let url = pokemon.sprites.front_default
        do {
            let data = try Data(contentsOf: url)
            self.imageView.image = UIImage(data: data)
        } catch {
            print("Can't find the image from url \(error.localizedDescription)")
        }
        tableView.reloadData()
    }
    
}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return pokemon?.abilities.count ?? 0
        case 2:
            return pokemon?.moves.count ?? 0
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "GraphicCell", for: indexPath) as! StatsCell
            if let stats = pokemon?.stats {
            cell.configure(with: stats)
            }
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "PokeInfoCell", for: indexPath) as! PokemonInfoCell
            guard let pokemon = pokemon else { return cell }
            cell.configure(with: pokemon.abilities[indexPath.row].ability.name)
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "PokeInfoCell", for: indexPath) as! PokemonInfoCell
            guard let pokemon = pokemon else { return cell }
            cell.configure(with: pokemon.moves[indexPath.row].move.name)
            return cell
        default:
            fatalError("Not Implemented")
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 1:
            return "Abilities"
        case 2:
            return "Moves"
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
