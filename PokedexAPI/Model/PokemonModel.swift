//
//  PokemonModel.swift
//  PokedexAPI
//
//  Created by MAA on 21.06.2022.
//

import Foundation

// MARK: - Pokemon
struct PokemonModel: Codable {
    let results: [PokeResult]
}

// MARK: - Result
struct PokeResult: Codable {
    let name: String
    let url: String
}
