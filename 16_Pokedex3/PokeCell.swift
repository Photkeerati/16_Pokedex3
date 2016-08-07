//
//  PokeCell.swift
//  16_Pokedex3
//
//  Created by Photkeerati on 8/7/2559 BE.
//  Copyright © 2559 Photkeerati. All rights reserved.
//

import UIKit

class PokeCell: UICollectionViewCell {
    @IBOutlet weak var thumbImg:UIImageView!
    @IBOutlet weak var nameLbl:UILabel!
    
    var pokemon: Pokemon!
    
    func configureCell(pokemon:Pokemon) {
        self.pokemon = pokemon
        nameLbl.text = pokemon.name.capitalized
        thumbImg.image = UIImage(named: String(pokemon.pokedexId))
        
    }
}
