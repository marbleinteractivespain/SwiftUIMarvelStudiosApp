//
//  AvengersAppSwiftUIApp.swift
//  Shared
//
//  Created by David dela Puente on 19/9/21.
//

import SwiftUI

@main
struct AvengersAppSwiftUIApp: App {
    
    @StateObject var charactersViewModel = CharactersViewModel()
    
    init(){
        let navBarAppearance = UINavigationBarAppearance()
        
        navBarAppearance.setBackIndicatorImage(UIImage(systemName: "arrow.turn.up.left"),
                                               transitionMaskImage: UIImage(systemName: "arrow.turn.up.left"))
        navBarAppearance.configureWithTransparentBackground()
        navBarAppearance.backgroundColor = .black
  
        if let fontLarge = UIFont(name: "Bebas-Regular", size: 46.0){
            navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor(named: "RedMarvel") ?? .white,
                                                         .font : fontLarge]
        }
        
        if let fontSmall = UIFont(name: "Bebas-Regular", size: 28.0){
            navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor(named: "RedMarvel") ?? .white, .font : fontSmall]
        }
       
        UINavigationBar.appearance().standardAppearance = navBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
        UINavigationBar.appearance().compactAppearance = navBarAppearance
    }
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(charactersViewModel)
        }
    }
}
