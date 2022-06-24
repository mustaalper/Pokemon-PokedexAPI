//
//  Webservice.swift
//  PokedexAPI
//
//  Created by MAA on 21.06.2022.
//

import Foundation

class Webservice {
    
    static let shared = Webservice()
    var pokemon = [PokeResult]()
    
    func parsePoke(page: Int, comp: @escaping ([PokeResult]) -> ()) {
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon?offset=\(page)") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let data = data else { return }
            
            var result: PokemonModel?
            do {
                result = try JSONDecoder().decode(PokemonModel.self, from: data)
            }
            catch {
                print("error")
            }
                
            let nPoke = result?.results
            self.pokemon.append(contentsOf: nPoke!)
            comp(self.pokemon)
                
        }.resume()
            
    }
    
    func parsePokeDetail(url: URL, comp: @escaping (PokemonDetail) -> ()) {
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil {
                print(error?.localizedDescription ?? "n/a")
                return
            }
            
            guard let _ = response else { return }
            
            guard let data = data else { return }
            
            do {
                let pokeDetail = try JSONDecoder().decode(PokemonDetail.self, from: data)
                comp(pokeDetail)
            } catch {
                
            }
        }.resume()
    }
}
