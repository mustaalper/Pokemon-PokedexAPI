//
//  PokemonCollectionViewCell.swift
//  PokedexAPI
//
//  Created by MAA on 21.06.2022.
//

import UIKit

class PokemonCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var pokeImg: UIImageView!
    @IBOutlet var pokeName: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.cornerRadius = 10
        layer.borderColor = UIColor.systemPink.cgColor
        layer.borderWidth = 0.5
        layer.shadowColor = UIColor.systemPink.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowRadius = 6.0
        
        pokeName.backgroundColor = .systemPink
        pokeName.textColor = .white
        
    }
    
    func configCell(with model: PokeResult, cellRow: Int) {
        self.pokeName.text = model.name.capitalized
        self.pokeImg.load(urlString: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/\(cellRow).png")
        }
}
