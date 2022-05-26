//
//  Monsters.swift
//  MHDatabaseIOS
//
//  Created by Che Alexander on 5/25/22.
//

import Foundation

struct Monster: Codable {
    let generation: Int
    let group: String
    let id: Int
    let name: String
    let variation: Int
}


struct ItemRepsond: Codable {
    let item_weak: [ItemWeakness]
}

struct ItemWeakness: Codable {
    let id: Int
    let flash_bomb: Bool
    let pitfall_trap: Bool
    let shock_trap: Bool
    let sonic_bomb: Bool
}

struct WeakPointRespond: Codable {
    let weakpoints: [Weakpoint]
}
struct Weakpoint: Codable {
    let id: Int
    let cut: String
    let impact: String
    let projectile: String
}


struct WeaknessRespond: Codable {
    let weakness: [Weakness]
}
struct Weakness: Codable {
    let id: Int
    let dragon: Bool
    let fire: Bool
    let ice: Bool
    let thunder: Bool
    let para: Bool
    let poison: Bool
    let sleep: Bool
    let blast: Bool

}


struct StrenghtRespond: Codable {
    let strength: [Strength]
}
struct Strength: Codable {
    let id: Int
    let dragon: Bool
    let fire: Bool
    let ice: Bool
    let thunder: Bool
    let water: Bool
}

struct AilmentsRespond: Codable {
    let ailments: [Ailments]
}
struct Ailments: Codable {
    let id: Int
    let blight: Bool
    let natural: String
    let status: String
    
}

struct GameRespond: Codable {
    let games: [Games]
}
struct Games: Codable {
    let id: Int
    let MH3U: Bool?
    let MH3rd: Bool?
    let MH4U: Bool?
    let MHF: Bool?
    let MHF2: Bool?
    let MHGU: Bool?
    let MHRS: Bool?
    let MHWI: Bool?
}

