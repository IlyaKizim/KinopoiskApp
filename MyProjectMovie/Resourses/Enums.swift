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


