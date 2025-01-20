//
//  ContentView.swift
//  SwiftUIApp
//
//  Created by Jed PURDY on 1/20/25.
//

import SwiftUI

    class Inventory: ObservableObject {
        // Published array of LootItem objects
        @Published var loot: [LootItem]
        
        // Initializer to set up the inventory with some default items
        init() {
            // Initializing with a default LootItem
            loot = [
                LootItem(name: "Bow", type: .bow, rarity: .mythic, game: availableGames.first!),
                LootItem(name: "Sword", type: .magic, rarity: .legendary, game: availableGames[1]),
                LootItem(name: "Shield of Valor", type: .shield, rarity: .epic, game: availableGames[2]),
                LootItem(name: "Fire Staff", type: .fire, rarity: .rare, game: availableGames[3]),
                LootItem(name: "Ice Blade", type: .ice, rarity: .uncommon, game: availableGames[4]),
                LootItem(name: "Thunder Hammer", type: .thunder, rarity: .common, game: availableGames[0]),
                LootItem(name: "Dagger of Shadows", type: .dagger, rarity: .mythic, game: availableGames[1]),
                LootItem(name: "Poison Ring", type: .ring, rarity: .epic, game: availableGames[3]),
                LootItem(name: "Wind Bow", type: .wind, rarity: .legendary, game: availableGames[4]),
                LootItem(name: "Dragon Armor", type: .shield, rarity: .rare, game: availableGames[2]),
                LootItem(name: "Mystic Wand", type: .magic, rarity: .uncommon, game: availableGames[0]),
                LootItem(name: "Unknown Artifact", type: .unknown, rarity: .common, game: availableGames[1]),
                LootItem(name: "Ring of Eternity", type: .ring, rarity: .mythic, game: availableGames[4]),
                LootItem(name: "Bow of the Ancients", type: .bow, rarity: .epic, game: availableGames[3]),
                LootItem(name: "Legendary Helmet", type: .shield, rarity: .legendary, game: availableGames[2])
            ]

        }
        
        // Function to add a LootItem to the inventory
        func addItem(item: LootItem) {
            loot.append(item)
        }
    
}

struct ContentView: View {
    @StateObject var inventory = Inventory()
    
    @State var showAddItemView = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(inventory.loot, id: \.id) { item in
                    NavigationLink {
                        LootDetailView(item: item) 
                    } label:{
                        VStack(alignment: .leading) {
                            HStack{
                                Circle()
                                    .frame(width: 12, height: 12)
                                    .foregroundColor(item.rarity.color)
                                Text(item.name)
                                Spacer()
                                Text(item.type.rawValue)
                            }
                            Text("Quantity: \(item.quantity)")
                                .font(.subheadline)
                            
                        }
                    }
                }
            }
                .sheet(isPresented: $showAddItemView, content: {
                    AddItemView()
                })
                .navigationBarTitle("Loot") // Notre titre de page, choisissez le titre que vous voulez
                .toolbar(content: { // La barre d'outil de notre page
                    ToolbarItem(placement: ToolbarItemPlacement.automatic) {
                        Button(action: {
                            showAddItemView.toggle() // L'action de notre bouton
                        }, label: {
                            Image(systemName: "plus.circle.fill")
                        })
                    }
                })
            }
            .environmentObject(inventory)
        }
    }


#Preview {
    ContentView()
}


