//
//  SerieDetailView.swift
//  AvengersAppSwiftUI (iOS)
//
//  Created by David dela Puente on 23/9/21.
//

import SwiftUI

struct SerieDetailView: View {
    
    @StateObject private var photoViewModel = PhotoViewModel()
    @Environment(\.presentationMode) var presentationMode
    
    var serie: ResultSerie
    
    var body: some View {
        ScrollView{
            VStack{
                Group{
                    if let img = photoViewModel.photo{
                        img
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(height: 350)
                            .clipped()
                    }else{
                        Image("404")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(height: 350)
                            .clipped()
                    }
                }
                .padding([.bottom], 25)
                    
                Group{
                    Text("\(serie.title)")
                    .font(.custom("Bebas-Regular", size: 35))
                    .lineLimit(3)
                    .minimumScaleFactor(0.5)
                    
                }
                .padding(.bottom, 0)
                .padding(.horizontal)
                
                let years = "Desde el \(serie.startYear) al \(serie.endYear)"
                let newYears = years.replacingOccurrences(of: ",", with: ".", options: .literal, range: nil)
                
                Text("\(newYears)")
                    .font(.custom("Bebas-Regular", size: 18))
                    .padding(.bottom, 0)
                    .padding(.horizontal)
                    .foregroundColor(Color("RedMarvel"))
                
                if let description = serie.resultDescription{
                    Text("\(description)")
                        .font(.system(size: 16))
                        .lineSpacing(6.0)
                        .padding()
                        .lineLimit(1000)
                        .multilineTextAlignment(.leading)
                }
                
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }, label: {
                    VStack{
                        Image(systemName: "xmark.circle")
                            .background(Color("RedMarvel"))
                            .clipShape(Circle())
                            .foregroundColor(.white)
                            .font(.custom("Bebas-Regular", size: 60))
                            .padding([.top], 30)
                        
                        Text("Cerrar")
                            .font(.custom("Bebas-Regular", size: 20))
                            .foregroundColor(Color("RedMarvel"))
                            .padding([.top], 10)
                    }
                })
            }
        }
        .edgesIgnoringSafeArea(.top)
        .onAppear(){
            
            let photo = serie.thumbnail.path + ".\(serie.thumbnail.thumbnailExtension)"
            if !photo.contains("image_not_available"){ // quitamos las imagenes sin dibujo "image_not_available"
                self.photoViewModel.loadImage(url: photo)
            }
        }
    }
}

struct SerieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        SerieDetailView(serie: SeriesViewModel().getSerie())
    }
}
