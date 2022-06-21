//
//  Webservice.swift
//  PokedexAPI
//
//  Created by MAA on 21.06.2022.
//

import Foundation

class Webservice {
    func parsePoke(comp: @escaping ([PokeResult]) -> ()) {
        let api = URL(string: "https://pokeapi.co/api/v2/pokemon?limit=10228")!
        
        URLSession.shared.dataTask(with: api) { data, response, error in
            if error != nil {
                print(error?.localizedDescription ?? "n/a")
                return
            }
            
            guard let _ = response else { return }
            
            guard let data = data else { return }

            do {
                let jsonResult = try JSONDecoder().decode(PokemonModel.self, from: data)
                comp(jsonResult.results)
            } catch {
                
            }
        }.resume()
    }
}
