//
//  SeriesView.swift
//  AvengersAppSwiftUI (iOS)
//
//  Created by David dela Puente on 21/9/21.
//

import SwiftUI

struct SeriesView: View {
    
    @StateObject private var seriesViewModel = SeriesViewModel()
    @StateObject private var photoViewModel = PhotoViewModel()
    @State var selectedSerie: ResultSerie?
    
    var character: Result
    var serie: ResultSerie?
    
    init(character: Result){
        self.character = character
    }
    
    var body: some View {
        VStack{
            switch seriesViewModel.status{
            
            case Status.none:
                Text("")
            case Status.loading:
                LoadingView()
            case Status.loaded:
                Group{
                    if let img = photoViewModel.photo{
                        img
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(height: 200)
                    }else{
                        Image("404")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(height: 200)
                    }
                }
                .padding([.top], 40)
                ScrollView(.horizontal, showsIndicators: false){
                    HStack{
                        if let series = seriesViewModel.dataSeries?.data.results{
                            ForEach(series){ serie in
                                SerieRowView(serie: serie)
                                    .onTapGesture {
                                        self.selectedSerie = serie
                                    }
                                    .sheet(item: self.$selectedSerie){ serie in
                                        SerieDetailView(serie: serie)
                                    }
                            }
                        }
                    }
                }
                .navigationTitle("\(character.name)")
                .padding([.top, .bottom],50)
                .padding([.leading, .trailing], 20)
                
                
                
            case Status.error(error: let errorSeries):
                Text("Error: \(errorSeries)")
            }
        }
        .onAppear(){
            
            seriesViewModel.getSeriesAPI(id: character.id)
            
            let photo = character.thumbnail.path + ".\(character.thumbnail.thumbnailExtension)"
            if !photo.contains("image_not_available"){ // quitamos las imagenes sin dibujo "image_not_available"
                self.photoViewModel.loadImage(url: photo)
            }
        }
    }
}

struct SeriesView_Previews: PreviewProvider {
    static var previews: some View {
        SeriesView(character: CharactersViewModel(testing: true).getCharacter())
    }
}


