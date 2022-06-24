//
//  DetailViewController.swift
//  PokedexAPI
//
//  Created by MAA on 21.06.2022.
//

import UIKit

class DetailViewController: UIViewController {

    var result: PokeResult?
    var detailResult: PokemonDetail?
    let parser = Webservice()

    private var pokemonDetailViewModel: PokemonDetailViewModel!
    
    @IBOutlet var pokeImage: UIImageView!
    @IBOutlet var pokeName: UILabel!
    @IBOutlet var pokeType: UILabel!
    @IBOutlet var pokeHealt: UILabel!
    @IBOutlet var pokeAttack: UILabel!
    @IBOutlet var pokeDefense: UILabel!
    @IBOutlet var pokeSpeed: UILabel!
    @IBOutlet var pokeSpAttack: UILabel!
    @IBOutlet var pokeSpDefense: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let url = URL(string: result!.url) {
            
            parser.parsePokeDetail(url: url) { data in
                self.detailResult = data
                self.pokemonDetailViewModel = PokemonDetailViewModel(pokemonDetail: data)
                DispatchQueue.main.async {
                    self.pokeType.text = "Type: \(self.pokemonDetailViewModel.type.capitalized)"
                    self.pokeHealt.text = "Healt: \(self.pokemonDetailViewModel.stats(prop: "", propCase: "hp"))"
                    self.pokeAttack.text = "Attack: \(self.pokemonDetailViewModel.stats(prop: "", propCase: "attack"))"
                    self.pokeDefense.text = "Defense: \(self.pokemonDetailViewModel.stats(prop: "", propCase: "defense"))"
                    self.pokeSpeed.text = "Speed: \(self.pokemonDetailViewModel.stats(prop: "", propCase: "speed"))"
                    self.pokeSpAttack.text = "Sp-Attack: \(self.pokemonDetailViewModel.stats(prop: "", propCase: "special-attack"))"
                    self.pokeSpDefense.text = "Sp-Defense: \(self.pokemonDetailViewModel.stats(prop: "", propCase: "special-defense"))"
                    self.pokeImage.load(urlString: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/\(self.pokemonDetailViewModel.id).png")
                }
            }
        }
        
        if let name = result?.name {
            pokeName.text = name.capitalized
        }
        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
