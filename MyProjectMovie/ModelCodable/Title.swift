//
//  Models.swift
//  MyProjectMovie
//
//  Created by Яна Угай on 10.01.2023.
//

import Foundation

struct TitleMovie: Decodable {
    var results: [Title]
}

struct Title: Codable {
    let id: Int
    let originalLanguage: String?
    let originalTitle: String?
    let posterPath: String?
    let overview: String?
    let voteCount: Int
    let releaseDate: String?
    let voteAverage: Double?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case posterPath = "poster_path"
        case overview = "overview"
        case voteCount = "vote_count"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
    }
}



