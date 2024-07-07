//
//  MainPageView.swift
//  Superheroes
//
//  Created by Админ on 09.05.2024.
//

import SwiftUI

// MARK: - MainPageView

struct MainPageView: View {
    
    // MARK: - Properties
    
    @EnvironmentObject var dataService: DataService
    
    @State private var showFavorite = false
  
    var category: String

    var displayedHeroes: [HeroModel] {
        dataService.heroes.filter { hero in
            ((!showFavorite || hero.isFavorite) && hero.category.rawValue == category)
        }
    }
    
    // MARK: - View
    
    var body: some View {
        NavigationView {
            VStack {
                HStack(alignment: .top) {
                    VStack {
                        Text(category.capitalized)
                            .font(.system(size: 34, weight: .bold))
                            .padding(.leading, 12)
                    }
                    Spacer()
                    FavoriteToggle(showFavorite: $showFavorite)
                        .padding(.trailing, 12)
                }
                if displayedHeroes.isEmpty {
                    Spacer()
                    Text("No Favorites")
                        .foregroundColor(.gray)
                    Spacer()
                } else {
                    ScrollView {
                        ForEach(displayedHeroes) { hero in
                            NavigationLink {
                                HeroPageView(hero: hero)
                            } label: {
                                CardMainPage(hero: hero)
                            }
                        }
                    }
                    .padding(.leading, 16)
                    .padding(.trailing, 16)
                    .scrollIndicators(.hidden)
                }
                
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

// MARK: - Private

// MARK: - FavoriteToggle

private struct FavoriteToggle: View {
    
    // MARK: - Properties
    
    @Binding var showFavorite: Bool
    
    // MARK: - View
    
    var body: some View {
        Button {
            showFavorite.toggle()
        } label: {
            Image(showFavorite ? "star.fill" : "star")
                .labelStyle(.iconOnly)
        }
    }
}

// MARK: - CardMainPage

private struct CardMainPage: View {
    
    // MARK: - Properties
    
    @EnvironmentObject var dataService: DataService
    
    var hero: HeroModel
    
    // MARK: - View
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                HStack {
                    starFavoriteButton
                    Text(hero.name.capitalized)
                        .font(.system(size: 22, weight: .bold))
                        .lineLimit(1)
                        .fixedSize()
                }
                .padding(.bottom, 12)
                HStack {
                    Text("\(hero.stats.intelligents)")
                    Text("INT")
                        .opacity(0.38)
                }
                HStack {
                    Text("\(hero.stats.power)")
                    Text("POW")
                        .opacity(0.38)
                }
                HStack {
                    Text("\(hero.stats.speed)")
                    Text("SPD")
                        .opacity(0.38)
                }
                HStack {
                    Text("\(hero.stats.endurance)")
                    Text("END")
                        .opacity(0.38)
                }
                HStack {
                    Text("\(hero.stats.reaction)")
                    Text("REA")
                        .opacity(0.38)
                }
                HStack {
                    Text("\(hero.stats.protection)")
                    Text("PRO")
                        .opacity(0.38)
                }
            }
            .font(.system(size: 17))
            .foregroundColor(.white)
            .bold()
            Spacer()
            Image("\(hero.name)")
                .resizable()
                .frame(width: 164, height: 164)
        }
        .padding(16)
        .background(Color("\(hero.name)Color"))
        .cornerRadius(24)
    }
    
    // MARK: - SrarFavoriteButton
    
    private var starFavoriteButton: some View {
        
        // MARK: - View
        Button {
            dataService.changeFavorite(id: hero.id, isFavorite: !hero.isFavorite)
        } label: {
            Label("Favorite hero", image: hero.isFavorite ? "star.fill" : "star")
                .labelStyle(.iconOnly)
        }
    }
}

// MARK: - Preview

struct MainPageView_Previews: PreviewProvider {
    static var previews: some View {
        MainPageView(category: HeroCategory.superheroes.rawValue)
           .preferredColorScheme(.dark)
           .environmentObject(DataService())
    }
}
