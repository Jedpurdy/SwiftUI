//
//  LootDetailView.swift
//  SwiftUIApp
//
//  Created by Jed PURDY on 1/20/25.
//

import Foundation
import SwiftUI
struct LootDetailView: View {
    let item: LootItem
    @State private var isFlipped = false // Added this variable for tracking flipping animation
    @State private var isAppeared = false // For entry animations

    var body: some View {
        VStack {
            Text(item.type.rawValue)
                .font(.system(size: 50))
                .frame(width: 100, height: 100)
                .background(
                    item.rarity.color
                        .opacity(0.8)
                )
                .cornerRadius(20) // Coins arrondis
                .shadow(color: item.rarity.color.opacity(0.6), radius: 30, x: 0, y: 0)
                .shadow(color: item.rarity.color.opacity(0.3), radius: 60, x: 0, y: 0)
                .padding()
                .rotation3DEffect(
                        .degrees(isFlipped ? 180 : 0),
                        axis: (x: 0, y: 1, z: 0)
                    )
                    .onTapGesture {
                        withAnimation(.spring()) {
                            isFlipped.toggle()
                        }
                    }
            
            // Nom de l'objet
            Text(item.name)
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(item.rarity.color)
                .padding(.bottom, 10)
            
            
            if item.rarity == Rarity.mythic {
                Text("Item Unique 🏆")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.red)
                    .cornerRadius(10)
                    .padding(.bottom, 10)
                
            }
            
            // Informations sur l'objet
            VStack(alignment: .leading, spacing: 0) {
                // Fond gris avec titre d'introduction
                Text("INFORMATIONS")
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .foregroundColor(.gray)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 10)
                    .padding(.leading)
                    .background(Color(.secondarySystemBackground)) // Fond gris clair
                
                // Contenu des informations (fond blanc avec séparateurs)
                VStack(spacing: 0) {
                    HStack(spacing: 12) {
                        if let coverName = item.game.coverName {
                            Image(coverName)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 58)
                                .cornerRadius(4)
                        } else {
                            placeholderView()
                        }
                        Text(item.game.name)
                            .font(.headline)
                        Spacer()
                    }
                    .padding()
                    .background(Color.white)
                    
                    Divider() // Ligne séparatrice
                    
                    HStack {
                        Text("In-game :")
                            .fontWeight(.bold)
                        Spacer()
                        Text(item.name)
                    }
                    .padding()
                    .background(Color.white)
                    
                    if let attackStrength = item.attackStrength {
                        Divider()
                        HStack {
                            Text("Puissance (ATQ) :")
                                .fontWeight(.bold)
                            Spacer()
                            Text("\(attackStrength)")
                        }
                        .padding()
                        .background(Color.white)
                    }
                    
                    Divider()
                    HStack {
                        Text("Possédé(s) :")
                            .fontWeight(.bold)
                        Spacer()
                        Text("\(item.quantity)")
                    }
                    .padding()
                    .background(Color.white)
                    
                    Divider()
                    HStack {
                        Text("Rareté :")
                            .fontWeight(.bold)
                        Spacer()
                        Text(item.rarity.rawValue)
                    }
                    .padding()
                    .background(Color.white)
                }
                .cornerRadius(10)
                .padding(.horizontal)
                .background(Color(.secondarySystemBackground)) // Fond global gris clair
                .cornerRadius(10)
            }
        }
    }
            
            @ViewBuilder
            func placeholderView() -> some View {
                ZStack {
                    LinearGradient(
                        gradient: Gradient(colors: [.gray.opacity(0.4), .gray]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                    .cornerRadius(4)
                    .frame(height: 58)
                    
                    Image(systemName: "rectangle.slash")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 32) // Ajustez la taille pour obtenir un padding visuel
                        .foregroundColor(.black.opacity(0.4))
                }
            }
        }
        


