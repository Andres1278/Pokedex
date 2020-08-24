//
//  ViewController.swift
//  Pokedex
//
//  Created by Pedro Andres Villamil on 22/08/20.
//  Copyright © 2020 Pedro Andres Villamil. All rights reserved.
//

import UIKit

class PokemonListViewController: UIViewController {

    var nextURL: URL?
    var pokemons: [APIListResponse.Result] = []
    var filtered: [APIListResponse.Result] = []
    var currentFilter: String?
    var isLoadingPage = false
    let searchController = UISearchController(searchResultsController: nil)
    
    @IBOutlet weak var pokemonTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Pokemons"
        edgesForExtendedLayout = [.all]
        extendedLayoutIncludesOpaqueBars = true
        pokemonTableView.delegate = self
        pokemonTableView.dataSource = self
        loadNextPage()
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Pokemons"
        navigationItem.searchController = searchController
    }
    
    func loadNextPage() {
        guard !isLoadingPage else { return }
        isLoadingPage = true
        ServiceManger.request(to: nextURL?.absoluteString ?? "https://pokeapi.co/api/v2/pokemon/") { [weak self] (response: APIListResponse?, error) in
            guard let self = self,  let response = response else { return }
            self.isLoadingPage = false
            self.pokemons.append(contentsOf: response.results)
            self.applyFilter(with: self.currentFilter ?? "")
            self.nextURL = response.next
            self.pokemonTableView.reloadData()
        }
    }
}

extension PokemonListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        applyFilter(with: text)
    }
    
    func applyFilter(with text: String) {
        currentFilter = text
        guard text != "" else {
            filtered = pokemons
            pokemonTableView.reloadData()
            return
        }
        
        filtered = pokemons.filter {
            guard $0.name.lowercased().contains(text.lowercased()) else { return false }
            return true
        }
        pokemonTableView.reloadData()
    }
}


extension PokemonListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filtered.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonListCell", for: indexPath) as! PokemonListTableViewCell
        if indexPath.row == pokemons.count - 1 && nextURL != nil {
            loadNextPage()
        }
        cell.configure(with: filtered[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let mainStoyboard = UIStoryboard.init(name: "Main", bundle: Bundle.main)
        
        guard let destinationViewController = mainStoyboard.instantiateViewController(identifier: "DetailViewController") as? DetailViewController else {
            print("Couldn't find the view controller")
            return}
        
        destinationViewController.pokemonURL = pokemons[indexPath.row].url
        present(destinationViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
}

