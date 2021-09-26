//
//  SerieRowView.swift
//  AvengersAppSwiftUI
//
//  Created by David dela Puente on 23/9/21.
//

import SwiftUI

struct SerieRowView: View {
    @StateObject private var photoViewModel = PhotoViewModel()
    @State private var fade = false
    var serie: ResultSerie
    
    var body: some View {
        HStack{
            VStack{
                if let foto = photoViewModel.photo{
                    foto
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 150)
                        .cornerRadius(10)
                        .opacity(fade ? 1 : 0)
                    
                } else {
                    // sin foto
                    Image("404Serie")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 150)
                        .cornerRadius(10)
                        .opacity(fade ? 1 : 0)
                }
                let years = "\(serie.startYear) - \(serie.endYear)"
                let newYears = years.replacingOccurrences(of: ",", with: ".", options: .literal, range: nil)
                Text("\(newYears)")
                    .padding([.top], 10)
                    .font(.custom("Bebas-Regular", size: 20))
                Spacer()
            }
            .frame(width:150)
            .animation(.easeInOut(duration: 0.8))
        }
        .onAppear{
            let photo = serie.thumbnail.path + ".\(serie.thumbnail.thumbnailExtension)"
            if !photo.contains("image_not_available"){ // quitamos las imagenes sin dibujo "image_not_available"
                self.fade = true
                self.photoViewModel.loadImage(url: photo)
            }else{
                self.fade = false
            }
        }
    }
}

struct SerieRowView_Previews: PreviewProvider {
    static var previews: some View {
        SerieRowView(serie: SeriesViewModel().getSerie())
    }
}
