import SwiftUI

struct AddItemView: View {
    @EnvironmentObject var inventory: Inventory
    @Environment(\.dismiss) var dismiss // Dismiss environment variable
    
    @State private var name: String = ""
    @State private var rarity: Rarity = .common
    @State private var type: ItemType = .bow
    @State private var isAttack: Bool = false    
    @State private var quantity: Int = 1
    @State private var attackDmg: Int = 0

    @State private var game: Game = availableGames.first! 

    var body: some View {
        Form {
            Section {
                TextField("Nom de l'objet", text: $name)
                
                Picker("Rareté", selection: $rarity) {
                    ForEach(Rarity.allCases) { rarity in
                        Text(rarity.rawValue.capitalized)
                            .tag(rarity)
                    }
                }
                Stepper("Quantity : \(quantity)", value: $quantity)
                

            }
            
            Section{

                HStack {
                    Text("Type")
                        .font(.headline)
                    
                    Spacer()
                    
                    Text(type.rawValue.capitalized)
                        .font(.body)
                }
                Picker("Type", selection: $type) {
                    
                    ForEach(ItemType.allCases) { type in
                        Text(type.rawValue.capitalized)
                            .tag(type)
                    }
                }.pickerStyle(PalettePickerStyle())
                
                Picker("Game", selection: $game) {
                    ForEach(availableGames, id: \.self) { game in
                        Text(game.name) // Displaying the game name
                    }
                }
            }
            
            Section{
                Toggle("Est Attaque?",isOn: $isAttack)
                if isAttack { 
                    Stepper("Attaque Dmg : \(attackDmg)", value: $attackDmg)
                }
            }
            HStack{
                Section{
                    Button(action: {

                        dismiss() // Dismiss the view
                        
                    }, label: {
                        Text("Annuler")
                    })
                }
                
                Spacer()
                Section{
                    Button(action: {
                        // Handle adding the item
                        if !name.isEmpty {
                            let newItem = LootItem(name: name, type: type, rarity: rarity, game: game,quantity: quantity,attackStrength: isAttack ? attackDmg : nil)
                            inventory.addItem(item: newItem)
                            name = ""
                            rarity = .common
                            type = .bow
                            isAttack = false
                            quantity = 1
                            attackDmg = 0
                            dismiss()
                        }
                    }, label: {
                        Text("Ajouter")
                    })
                    .disabled(name.isEmpty)
                }
            }
        }
    }
}

struct AddItemView_Previews: PreviewProvider {
    static var previews: some View {
        AddItemView()
            .environmentObject(Inventory())
    }
}
