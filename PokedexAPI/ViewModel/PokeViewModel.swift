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

struct PokemonDetailViewModel {
    let pokemonDetail: PokemonDetail
    
    var id: Int {
        return pokemonDetail.id
    }
    
    var type: String {
        return pokemonDetail.types.first?.type.name ?? "n/a"
    }
    
    var hp: String {
        var propHp = ""
        
        for i in 0..<pokemonDetail.stats.count {
            let x = pokemonDetail.stats[i].stat.name
            switch x {
            case "hp":
                propHp = "\(pokemonDetail.stats[i].baseStat)"
            default:
                break
            }
        }
        return propHp
    }
    
    var attack: String {
        var propAtt = ""
        
        for i in 0..<pokemonDetail.stats.count {
            let x = pokemonDetail.stats[i].stat.name
            switch x {
            case "attack":
                propAtt = "\(pokemonDetail.stats[i].baseStat)"
            default:
                break
            }
        }
        return propAtt
    }
    
    var defense: String {
        var propDef = ""
        
        for i in 0..<pokemonDetail.stats.count {
            let x = pokemonDetail.stats[i].stat.name
            switch x {
            case "defense":
                propDef = "\(pokemonDetail.stats[i].baseStat)"
            default:
                break
            }
        }
        return propDef
    }
    
    var specialAttack: String {
        var propSpAtt = ""
        
        for i in 0..<pokemonDetail.stats.count {
            let x = pokemonDetail.stats[i].stat.name
            switch x {
            case "special-attack":
                propSpAtt = "\(pokemonDetail.stats[i].baseStat)"
            default:
                break
            }
        }
        return propSpAtt
    }
    
    var specialDefense: String {
        var propSpDef = ""
        
        for i in 0..<pokemonDetail.stats.count {
            let x = pokemonDetail.stats[i].stat.name
            switch x {
            case "special-defense":
                propSpDef = "\(pokemonDetail.stats[i].baseStat)"
            default:
                break
            }
        }
        return propSpDef
    }
    
    var speed: String {
        var propSp = ""
        
        for i in 0..<pokemonDetail.stats.count {
            let x = pokemonDetail.stats[i].stat.name
            switch x {
            case "speed":
                propSp = "\(pokemonDetail.stats[i].baseStat)"
            default:
                break
            }
        }
        return propSp
    }
}
