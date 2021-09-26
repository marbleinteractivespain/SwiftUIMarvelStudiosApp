//
//  MainView.swift
//  AvengersAppSwiftUI (iOS)
//
//  Created by David dela Puente on 20/9/21.
//

import SwiftUI

struct MainView: View {
    
    @EnvironmentObject var viewModelCharacters: CharactersViewModel
    
    var body: some View {
        
        switch viewModelCharacters.status {
            case Status.none:
                Text("Estado none")
            case Status.loading:
                LoadingView()
            case Status.loaded:
                CharactersView()
            case Status.error(error: let errorString):
                Text("Error: \(errorString)")
        }
    }
    
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(CharactersViewModel())
    }
}
