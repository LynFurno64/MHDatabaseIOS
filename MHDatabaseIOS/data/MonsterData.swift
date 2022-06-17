//
//  Monsters.swift
//  MHDatabaseIOS
//
//  Created by Che Alexander on 5/25/22.
//

import Foundation

struct MonstersList: Codable {
    let monsters: [Monster]
}

struct Monster: Codable {
    let generation: Int
    let group: String
    let id: Int
    let name: String
    let variation: Int
}

struct Phylums: Codable {
    let id: Int
    let category: String
    let codename: String
}


struct ItemWeakness: Codable {
    let id: Int
    let mon_id: Int
    let flash_bomb: Bool
    let pitfall_trap: Bool
    let shock_trap: Bool
    let sonic_bomb: Bool
}

struct Weakpoint: Codable {
    let id: Int
    let mon_id: Int
    let cut: String
    let impact: String
    let projectile: String
}


struct Weakness: Codable {
    let id: Int
    let mon_id: Int
    let dragon: Bool
    let fire: Bool
    let water: Bool
    let ice: Bool
    let thunder: Bool
    let para: Bool
    let poison: Bool
    let sleep: Bool
    let blast: Bool

}

struct Strength: Codable {
    let id: Int
    let dragon: Bool
    let fire: Bool
    let ice: Bool
    let thunder: Bool
    let water: Bool
}

struct Ailments: Codable {
    let id: Int
    let blight: String
    let natural: String
    let status: String
    
}

// has an array object
struct Games: Codable {
    let games_in: [Game]
}
struct AllGames: Codable {
    let gamesList: [Game]
}
struct Game: Codable {
    let games: String
    let id: Int
    let mon_id: Int
}

struct Relatives: Codable {
    let relatives: [Monster]
}
