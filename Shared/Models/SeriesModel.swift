//
//  SeriesModel.swift
//  AvengersAppSwiftUI (iOS)
//
//  Created by David dela Puente on 21/9/21.
//

import Foundation

// MARK: - Serie
struct Serie: Codable {
    let code: Int
    let status, copyright, attributionText, attributionHTML: String
    let etag: String
    let data: SerieDataClass
}

// MARK: - DataClass
struct SerieDataClass: Codable {
    let offset, limit, total, count: Int
    let results: [ResultSerie]
}

// MARK: - Result
struct ResultSerie: Codable, Identifiable {
    let id: Int
    let title: String
    let resultDescription: String?
    let resourceURI: String
    let startYear, endYear: Int
    let rating: String
    let thumbnail: ThumbnailSerie

    enum CodingKeys: String, CodingKey {
        case id, title
        case resultDescription = "description"
        case resourceURI, startYear, endYear, rating, thumbnail
    }
}

// MARK: - Thumbnail
struct ThumbnailSerie: Codable {
    let path: String
    let thumbnailExtension: String

    enum CodingKeys: String, CodingKey {
        case path
        case thumbnailExtension = "extension"
    }
}
