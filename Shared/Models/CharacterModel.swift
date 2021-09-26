//
//  CharacterModel.swift
//  AvengersAppSwiftUI (iOS)
//
//  Created by David dela Puente on 19/9/21.
//


import Foundation

// MARK: - Character
struct Character: Codable {
    let code: Int
    let status, copyright, attributionText, attributionHTML: String
    let etag: String
    let data: DataClass
}

// MARK: - DataClass
struct DataClass: Codable {
    let offset, limit, total, count: Int
    let results: [Result]
}

// MARK: - Result
struct Result: Codable, Identifiable {
    let id: Int
    let name, resultDescription: String
    let thumbnail: Thumbnail
    let resourceURI: String
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case resultDescription = "description"
        case resourceURI, thumbnail
    }
}

// MARK: - Thumbnail
struct Thumbnail: Codable {
    let path: String
    let thumbnailExtension: String

    enum CodingKeys: String, CodingKey {
        case path
        case thumbnailExtension = "extension"
    }
}
