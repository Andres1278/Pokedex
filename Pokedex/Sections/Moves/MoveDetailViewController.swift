//
//  MoveDetailViewController.swift
//  Pokedex
//
//  Created by Pedro Andres Villamil on 23/08/20.
//  Copyright © 2020 Pedro Andres Villamil. All rights reserved.
//

import UIKit

class MoveDetailViewController: UIViewController {

    var moveURL: URL?
    var move: Move?
    
    @IBOutlet weak var circleIconImageView: UIImageView!
    @IBOutlet weak var rectangleIconImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var basePowerLabel: UILabel!
    @IBOutlet weak var accuracyLabel: UILabel!
    @IBOutlet weak var ppLabel: UILabel!
    @IBOutlet weak var cardView: UIView!
    @IBOutlet var backgroundView: UIView!
    @IBOutlet weak var moveBackgroundImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cardView.layer.cornerRadius = 50
        cardView.layer.cornerCurve = .continuous
        loadMove()
    }
    
    @IBAction func dismissButtonTapped(_ sender: Any) {
        dismiss(animated: true)
    }
    
    func loadMove() {
        guard let url = moveURL else { return }
        ServiceManger.request(to: url.absoluteString) { [weak self] (move: Move?, error) in
            guard let self = self,  let move = move else { return }
            self.move = move
            self.refreshUI()
        }
    }
    
    func refreshUI() {
        guard let move = move else { return }
        let name = move.name.replacingOccurrences(of: "-", with: " ")
        nameLabel.text = name.capitalized
        descriptionLabel.text = move.effect_entries.first?.short_effect
        basePowerLabel.text = "-"
        if let power = move.power {
            basePowerLabel.text = "\(power)"
        }
        accuracyLabel.text = "-"
        if let accuracy = move.accuracy {
            accuracyLabel.text = "\(accuracy)"
        }
        ppLabel.text = "\(move.pp)"
        circleIconImageView.image = UIImage(named: "Move/Badge/\(move.type.name.capitalized)")
        rectangleIconImageView.image = UIImage(named: "Move/Tag/\(move.type.name.capitalized)")
        moveBackgroundImageView.image = UIImage(named: "Move/Background/\(move.type.name.capitalized)")
    }

}
