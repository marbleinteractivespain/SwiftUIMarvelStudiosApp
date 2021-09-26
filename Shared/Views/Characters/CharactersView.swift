//
//  HomeView.swift
//  AvengersAppSwiftUI (iOS)
//
//  Created by David dela Puente on 19/9/21.
//

import SwiftUI

struct CharactersView: View {
    
    @EnvironmentObject var viewModeloCharacter: CharactersViewModel
    
    @State var isActive = false
    
    init() {
        UITableView.appearance().allowsSelection = false
        UITableViewCell.appearance().selectionStyle = .none
    }
    
    var body: some View {
        NavigationView{
            if let characters = viewModeloCharacter.dataCharacters?.data.results{
                List(characters){ character in
                    ZStack {
                        CharacterRowView(character: character)
                        NavigationLink(destination: SeriesView(character: character)) {
                            EmptyView()
                        }
                    }
                }
                .navigationBarTitle(!isActive ? "Marvel Studios" : "")
                .navigationBarBackButtonHidden(true)
            }
        }
        .accentColor(Color("RedMarvel"))

    }
}

struct CharactersView_Previews: PreviewProvider {
    static var previews: some View {
        CharactersView()
            .environmentObject(CharactersViewModel(testing: true))
    }
}
