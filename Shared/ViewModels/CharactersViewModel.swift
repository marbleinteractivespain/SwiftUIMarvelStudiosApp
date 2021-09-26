//
//  CharactersViewModel.swift
//  AvengersAppSwiftUI (iOS)
//
//  Created by David dela Puente on 20/9/21.
//

import SwiftUI
import Combine

class CharactersViewModel: ObservableObject {
    
    @Published var status = Status.none
    @Published var dataCharacters: Character?
    
    var suscriptors = Set<AnyCancellable>()
    
    init(testing:Bool = false){
        
        if !testing {
            //Datos reales
            getCharactersAPI()
        }else{
            //datos de prueba
            getCharactersTest()
        }
    }
    
    
    func getCharactersAPI(){
        self.status = Status.loading
        
        URLSession.shared
            .dataTaskPublisher(for: BaseNetwork().getCharacters())
            .tryMap{
                guard let response = $0.response as? HTTPURLResponse, response.statusCode == 200 else{
                    self.status = Status.error(error: "Error de servidor")
                    throw URLError(.badServerResponse)
                }
                
                return $0.data // Estado == 200, delvolvemos los personajes
            }
            .decode(type: Character.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion{
                case .failure:
                    self.status = Status.error(error: "No se ha podido realizar la petición. :(")
                case .finished:
                    self.status = Status.loaded
                }
            } receiveValue: { data in
                self.dataCharacters = data
            }
            .store(in: &suscriptors)
    }
    
    func getCharactersTest(){
        self.status = Status.loaded
        
        let character1 = Result(id: 1011334,
                                name: "3-D Man",
                                resultDescription: "",
                                thumbnail: Thumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784", thumbnailExtension: "jpg"),
                                resourceURI: "http://gateway.marvel.com/v1/public/characters/1011334")
        let character2 = Result(id: 1017100,
                                name: "A-Bomb (HAS)",
                                resultDescription: "Rick Jones has been Hulk's best bud since day one, but now he's more than a friend...he's a teammate! Transformed by a Gamma energy explosion, A-Bomb's thick, armored skin is just as strong and powerful as it is blue. And when he curls into action, he uses it like a giant bowling ball of destruction! ",
                                thumbnail: Thumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/3/20/5232158de5b16", thumbnailExtension: "jpg"),
                                resourceURI: "http://gateway.marvel.com/v1/public/characters/1017100")
        
        let data = DataClass(offset: 0, limit: 0, total: 2, count: 2, results: [character1, character2])
        self.dataCharacters = Character(code: 200, status: "success", copyright: "2021", attributionText: "", attributionHTML: "", etag: "", data: data)
        
    }
    
    
    func getCharacter() -> Result{
        return Result(id: 1011334,
                       name: "3-D Man",
                       resultDescription: "",
                       thumbnail: Thumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784", thumbnailExtension: "jpg"),
                       resourceURI: "http://gateway.marvel.com/v1/public/characters/1011334")
    }
    
}
