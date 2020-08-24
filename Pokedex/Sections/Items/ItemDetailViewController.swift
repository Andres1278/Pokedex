//
//  ItemDetailViewController.swift
//  Pokedex
//
//  Created by Pedro Andres Villamil on 23/08/20.
//  Copyright © 2020 Pedro Andres Villamil. All rights reserved.
//

import UIKit

class ItemDetailViewController: UIViewController {
    
    var itemURL: URL?
    var item: Item?

    @IBOutlet weak var tagImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var costLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(itemURL)
        cardView.layer.cornerRadius = 50
        cardView.layer.cornerCurve = .continuous
        loadItem()
    }
    
    @IBAction func dismissButtonTapped(_ sender: Any) {
        dismiss(animated: true)
    }
    
    func loadItem() {
        guard let url = itemURL else { return }
        ServiceManger.request(to: url.absoluteString) { [weak self] (item: Item?, error) in
            guard let self = self,  let item = item else { return }
            self.item = item
            self.refreshUI()
        }
    }
    
    func refreshUI() {
        guard let item = item else { return }
        let name = item.name.replacingOccurrences(of: "-", with: " ")
        nameLabel.text = name.capitalized
        descriptionLabel.text = item.effect_entries.first?.effect
        costLabel.text = "\(item.cost)"
        backgroundImageView.image = UIImage(named: "Background")
        let url = item.sprites.default
        do {
            let data = try Data(contentsOf: url)
            self.tagImageView.image = UIImage(data: data)
        } catch {
            print("Can't find the image from url \(error.localizedDescription)")
        }
    }
}
