//
//  BaseNetwork.swift
//  AvengersAppSwiftUI (iOS)
//
//  Created by David dela Puente on 19/9/21.
//
import Foundation


//ENDPOINTS
enum endpoints : String {
    case characters = "/v1/public/characters"

}


//HTTPMethods
struct HTTPMethods {

    static let post = "POST"
    static let get = "GET"
    static let put = "PUT"
    static let delete = "DELETE"
    static let content = "application/json"

}

//LLAMADAS API MARVEL
struct BaseNetwork {
    
    //Funcion para generar la petición a la API
    private func getURL(endpoint:String, slug:String = "") -> String {
        let url = CONST_HOST_MARVEL + "\(endpoint)\(slug)" + "?apikey=\(CONST_PUBLIC_KEY)" + "&ts=\(CONST_ts)" + "&hash=\(CONST_hash)"
        
        return url
    }
    
    //Obtener Characters
    func getCharacters() -> URLRequest {
        let url:String = getURL(endpoint: endpoints.characters.rawValue) + "&orderBy=-modified"
        var request : URLRequest = URLRequest(url: URL(string: url)!)
        request.httpMethod = HTTPMethods.get
        request.addValue(HTTPMethods.content, forHTTPHeaderField: "Content-type")
        
        return request
    }

    //Obtener series de un Character
    func getSerieOfCharacter(idCharacter:Int) -> URLRequest {
        let url:String = getURL(endpoint: endpoints.characters.rawValue, slug: "/\(idCharacter)/series") + "&orderBy=-modified"
        var request : URLRequest = URLRequest(url: URL(string: url)!)
        request.httpMethod = HTTPMethods.get
        request.addValue(HTTPMethods.content, forHTTPHeaderField: "Content-type")
        
        return request
    }
}

