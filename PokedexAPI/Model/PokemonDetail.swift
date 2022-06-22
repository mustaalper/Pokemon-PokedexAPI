//
//  PokemonDetail.swift
//  PokedexAPI
//
//  Created by MAA on 21.06.2022.
//

import Foundation

struct PokemonDetail: Codable {
    let abilities: [Ability]
    let height: Int
    let id: Int
    let stats: [Stat]
    let types: [TypeElement]
    let weight: Int
}

struct Ability: Codable {
    let ability: Species
    let isHidden: Bool
    let slot: Int

    enum CodingKeys: String, CodingKey {
        case ability
        case isHidden = "is_hidden"
        case slot
    }
}

struct Species: Codable {
    let name: String
    let url: String
}

struct Stat: Codable {
    let baseStat, effort: Int
    let stat: Species

    enum CodingKeys: String, CodingKey {
        case baseStat = "base_stat"
        case effort, stat
    }
}

struct TypeElement: Codable {
    let slot: Int
    let type: Species
}
