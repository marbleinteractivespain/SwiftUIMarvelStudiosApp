//
//  CharactersViewModel.swift
//  AvengersAppSwiftUI (iOS)
//
//  Created by David dela Puente on 21/9/21.
//

import SwiftUI
import Combine

class SeriesViewModel: ObservableObject {
    
    @Published var status = Status.none
    @Published var dataSeries: Serie?
    
    var suscriptors = Set<AnyCancellable>()
    
    
    func getSeriesAPI(id: Int){
        self.status = Status.loading
        URLSession.shared
            .dataTaskPublisher(for: BaseNetwork().getSerieOfCharacter(idCharacter: id))
            .tryMap{
                guard let response = $0.response as? HTTPURLResponse, response.statusCode == 200 else{
                  
                    self.status = Status.error(error: "Error de servidor")
                    throw URLError(.badServerResponse)
                }
                return $0.data // Estado == 200, delvolvemos los personajes
            }
            .decode(type: Serie.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion{
                case .failure:
                    self.status = Status.error(error: "No se ha podido realizar la petición. :(")
                case .finished:
                    self.status = Status.loaded
                }
            } receiveValue: { data in
                self.dataSeries = data
            }
            .store(in: &suscriptors)
    }

    
    func getSerie() -> ResultSerie{
        return ResultSerie(id: 27624,
                           title: "Agents of Atlas (2019)",
                           resultDescription: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries,",
                           resourceURI: "http://gateway.marvel.com/v1/public/series/27624",
                           startYear: 2019,
                           endYear: 2019,
                           rating: "5",
                           thumbnail: ThumbnailSerie(path: "http://i.annihil.us/u/prod/marvel/i/mg/6/40/5d41b04849a7b", thumbnailExtension: "jpg"))
    }
    
}
