//
//  ContentView.swift
//  Superheroes
//
//  Created by Админ on 09.05.2024.
//

import SwiftUI
import UIKit

// MARK: - ContentView

struct ContentView: View {

    // MARK: - Properties
    
    let categories = HeroCategory.allCases.map {$0.rawValue}
    
    // MARK: - Initializers

    init() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundEffect = nil
        appearance.backgroundColor = .clear
        appearance.shadowColor = .clear
        
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }

    // MARK: - View

    var body: some View {
        TabView {
            ForEach(categories, id: \.self) { category in
                MainPageView(category: category)
                    .tabItem{
                        Image(category)
                            .renderingMode(.template)
                        Text(category)
                    }
                    .preferredColorScheme(.dark)
            }
        }
        .accentColor(.white)
    }
}

// MARK: -Preview

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(DataService())
    }
}
