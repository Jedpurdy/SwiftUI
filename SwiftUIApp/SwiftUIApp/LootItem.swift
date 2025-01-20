//
//  LootItem.swift
//  SwiftUIApp
//
//  Created by Jed PURDY on 1/20/25.
//

import Foundation
import SwiftUI

enum GameGenre {
    case mmorpg, rpg, looter, fps, tps, strategy, unset
}

struct Game: Identifiable, Hashable {
    let name: String
    let id: UUID = UUID()
    let genre: GameGenre
    let coverName : String?
    
    static var emptyGame = Game(name: "", genre: .unset, coverName: nil)
}

// Hesitez pas mettre vos propres jeux dans la liste
let availableGames = [
    Game(name: "Elden Ring", genre: .rpg, coverName: "EldenRing"),
    Game(name: "Skyrim", genre: .rpg, coverName: "Skyrim"),
    Game(name: "WoW", genre: .mmorpg, coverName: "WoW"),
    Game(name: "CS:GO", genre: .fps, coverName: "CSGO"),
    Game(name: "Diablo V", genre: .looter, coverName: "DiabloV")
]



enum ItemType: String, CaseIterable, Identifiable {
    case magic = "⭐️"
    case fire = "🔥"
    case ice = "❄️"
    case wind = "💨"
    case poison = "☠️"
    case thunder = "⚡️"
    case dagger = "🗡️"
    case shield = "🛡️"
    case bow = "🏹"
    case ring = "💍"
    case unknown = "🎲"

    var id: String { rawValue } // Protocole Identifiable
    
    // Retourner l'émoji associé au type
    var emoji: String {
        return self.rawValue
    }
}
enum Rarity: String, CaseIterable, Identifiable {
    case common = "Common"
    case uncommon = "Uncommon"
    case rare = "Rare"
    case epic = "Epic"
    case legendary = "Legendary"
    case mythic = "Mythic"

    var id: String { rawValue } // Pour le protocole Identifiable

    // Retourner la couleur associée à chaque rareté
    var color: Color {
        switch self {
        case .common:
            return Color.gray
        case .uncommon:
            return Color.green
        case .rare:
            return Color.blue
        case .epic:
            return Color.purple
        case .legendary:
            return Color.orange
        case .mythic:
            return Color.red
        }
    }
}

class LootItem {
    var id = UUID()
    var quantity: Int
    var name: String
    var type: ItemType
    var rarity: Rarity
    var attackStrength: Int?
    var game: Game
    
    // Improved initializer
    init(name: String, type: ItemType, rarity: Rarity, game: Game, quantity: Int = 1, attackStrength: Int? = nil) {
        self.name = name
        self.type = type
        self.rarity = rarity
        self.game = game
        self.quantity = quantity
        self.attackStrength = attackStrength
    }
    


}

