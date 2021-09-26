//
//  CharacterRowView.swift
//  AvengersAppSwiftUI (iOS)
//
//  Created by David dela Puente on 20/9/21.
//

import SwiftUI

struct CharacterRowView: View {
    
    @StateObject private var photoViewModel = PhotoViewModel()
    @State private var fade = false
    
    var character: Result
    
    init(character: Result){
        self.character = character
    }
    
    var body: some View {
        ZStack(alignment: .bottom){
            Group{
                if let img = photoViewModel.photo{
                    img
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(15)
                    
                }else{
                    Image("404")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(15)
                }
                
                HStack(alignment: .center){
                    Text("\(character.name)")
                        .font(.custom("Bebas-Regular", size: 20))
                        .fontWeight(.bold)
                        .lineLimit(1)
                        .foregroundColor(.white)
                        .padding(15)
                        .background(Color("RedMarvel"))
                        .cornerRadius(50)
                        .padding([.horizontal], 15)
                        .offset(x: 0, y: 30)
                        .shadow(color: .gray, radius: 10, x: 5, y: 5)
                        .opacity(fade ? 1 : 0)
                }
                .animation(.easeInOut(duration: 0.8))
                
            }
            .padding([.bottom],50)
            .onAppear{
                self.fade = true
                let photo = character.thumbnail.path + ".\(character.thumbnail.thumbnailExtension)"
                if !photo.contains("image_not_available"){ // quitamos las imagenes sin dibujo "image_not_available"
                    self.photoViewModel.loadImage(url: photo)
                }
            }
        }
        
    }
}

struct CharacterRowView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterRowView(character: CharactersViewModel().getCharacter())
    }
}
