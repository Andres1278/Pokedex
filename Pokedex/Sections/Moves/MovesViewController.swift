//
//  MovesViewController.swift
//  Pokedex
//
//  Created by Pedro Andres Villamil on 23/08/20.
//  Copyright © 2020 Pedro Andres Villamil. All rights reserved.
//

import UIKit

class MovesViewController: UIViewController {

    var nextURL: URL?
    var moves: [APIListResponse.Result] = []
    var filtered: [APIListResponse.Result] = []
    var currentFilter: String?
    var isLoadingPage = false
    let searchController = UISearchController(searchResultsController: nil)
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Moves"
        tableView.delegate = self
        tableView.dataSource = self
        loadNextPage()
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Moves"
        navigationItem.searchController = searchController
    }
    
    func loadNextPage() {
        guard !isLoadingPage else { return }
        isLoadingPage = true
        ServiceManger.request(to: nextURL?.absoluteString ?? "https://pokeapi.co/api/v2/move/") { [weak self] (response: APIListResponse?, error) in
            guard let self = self,  let response = response else { return }
            self.isLoadingPage = false
            self.moves.append(contentsOf: response.results)
            self.applyFilter(with: self.currentFilter ?? "")
            self.nextURL = response.next
            self.tableView.reloadData()
        }
    }
}

extension MovesViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        applyFilter(with: text)
    }
    
    func applyFilter(with text: String) {
        currentFilter = text
        guard text != "" else {
            filtered = moves
            tableView.reloadData()
            return
        }
        
        filtered = moves.filter {
            guard $0.name.lowercased().contains(text.lowercased()) else { return false }
            return true
        }
        tableView.reloadData()
    }
}

extension MovesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filtered.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MoveCell", for: indexPath) as! MovesTableViewCell
        if indexPath.row == moves.count - 1 && nextURL != nil {
            loadNextPage()
        }
        cell.configure(with: filtered[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let mainStoyboard = UIStoryboard.init(name: "Main", bundle: Bundle.main)
        
        guard let destinationViewController = mainStoyboard.instantiateViewController(identifier: "MoveDetailViewController") as? MoveDetailViewController else {
            print("Couldn't find the view controller")
            return}
        
        destinationViewController.moveURL = moves[indexPath.row].url
        present(destinationViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
}
