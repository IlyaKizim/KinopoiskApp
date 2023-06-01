//
//  Enums.swift
//  MyProjectMovie
//
//  Created by Кизим Илья on 27.05.2023.
//

import Foundation

enum SystemName: String {
    case play = "play.fill"
    case addInteresting = "note.text.badge.plus"
    case minus = "minus.circle"
}

enum Font: String {
    case helveticaBold = "HelveticaNeue-Bold"
}

enum APIString: String {
    case popular = "movie/popular"
    case topRate = "movie/top_rated"
    case upcoming = "movie/upcoming"
    case favorites = "movie/now_playing"
    case wathed = "tv/on_the_air"
}

enum Section: Int {
    case PopularMovies = 0
    case TopRateMovie
    case UpComingMovies
    case PlayingNowMoview
    case TVshow
}

enum TitleHeaderSection: String {
    case popular = "Popular"
    case topRated = "Top Rate"
    case upcoming = "Upcoming"
    case favorites = "Favorites"
    case tv = "TV"
}

enum MovieData {
    case popular([Title])
    case topRated([Title])
    case upcoming([Title])
    case favorites([Title])
    case watched([Title])
}

enum MovieError: Error, CustomNSError {
    case apiError
    case invalidEndPoint
    case invalidResponce
    case noData
    case serializationError
    
    var localizeDescription: String {
        switch self {
        case .apiError: return "Failed to fetch data"
        case .invalidEndPoint: return "Invalid endPoint"
        case .invalidResponce: return "Invalid responce"
        case .noData: return "No data"
        case .serializationError: return "Failed to decode data"
        }
    }
    
    var errorUserInfo: [String : Any] {
        [NSLocalizedDescriptionKey: localizeDescription]
    }
}
