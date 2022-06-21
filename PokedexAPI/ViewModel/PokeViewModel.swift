//
//  PokeViewModel.swift
//  PokedexAPI
//
//  Created by MAA on 21.06.2022.
//

import Foundation

struct PokemonListViewModel {
    let pokeList: [PokeResult]
    
    func numberOfItemSection() -> Int {
        return self.pokeList.count
    }
    
    func pokemonAtIndex(_ index: Int) -> PokemonViewModel {
        let poke = self.pokeList[index]
        return PokemonViewModel(poke)
    }
        
    func pokemonSelectIndex(_ index: Int) -> PokemonViewModel{
        let select = self.pokeList[index]
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
