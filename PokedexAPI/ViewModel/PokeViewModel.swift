//
//  PokeViewModel.swift
//  PokedexAPI
//
//  Created by MAA on 21.06.2022.
//

import Foundation
import UIKit

class PokemonListViewModel {
    var page = 0
    var pokemons = [PokeResult]()
    
    func fetchData(page: Int, cv: UICollectionView) {
        Webservice.shared.parsePoke(page: page) { pokemons in
            self.pokemons = pokemons
            DispatchQueue.main.async {
                cv.reloadData()
            }
        }
    }
    
    func pokemonSelectIndex(_ index: Int) -> PokemonViewModel{
        let select = self.pokemons[index]
        return PokemonViewModel(select)
    }
}

struct PokemonViewModel {
    let pokemon: PokeResult
    
    init(_ pokemon: PokeResult) {
        self.pokemon = pokemon
    }
    
    var name: String {
        return pokemon.name.capitalized
    }
}

struct PokemonDetailViewModel {
    let pokemonDetail: PokemonDetail
    
    var id: Int {
        return pokemonDetail.id
    }
    
    var type: String {
        return pokemonDetail.types.first?.type.name ?? "n/a"
    }
    
    func stats(prop: String, propCase: String) -> String {
        var prop = ""
        
        for i in 0..<pokemonDetail.stats.count {
            let x = pokemonDetail.stats[i].stat.name
            switch x {
            case propCase:
                prop = "\(pokemonDetail.stats[i].baseStat)"
            default:
                break
            }
        }
        return prop
    }
}
