//
//  SuperheroesApp.swift
//  Superheroes
//
//  Created by Админ on 09.05.2024.
//

import SwiftUI

// MARK: - SuperheroesApp

@main
struct SuperheroesApp: App {
    
    // MARK: - Properties
    
    @State private var dataService: DataService
    @State private var downloadService: DataDownloadService
    
    // MARK: - Initializers
        
    init() {
        downloadService = DataDownloadService()
        let heroes: [HeroModel] = DataDownloadService().load("Hero.json")
        dataService = DataService(heroes: heroes)
    }
    
    // MARK: - View
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(dataService)
        }
    }
}
