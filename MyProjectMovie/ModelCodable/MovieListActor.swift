//
//  MovieListActor.swift
//  MyProjectMovie
//
//  Created by Яна Угай on 16.02.2023.
//

import Foundation

struct ListMovie: Decodable {
    var cast: [List]
}

struct List: Codable {
    var backDropPath: String?
    var originalTitle: String?
    var overView: String?
    var posterPath: String?
    var releaseDate: String?
    var voteAverage: Double?
    var voteCount: Int?
    var id: Int?
    var originalLanguage: String?
    
    enum CodingKeys: String, CodingKey {
        case backDropPath = "backdrop_path"
        case originalTitle = "original_title"
        case overView = "overview"
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case id = "id"
        case originalLanguage = "original_language"
    }
}



/*
 {
     cast =     (
                 {
             adult = 0;
             "backdrop_path" = "/yu1pdRBYcfy8Gb9bX4r45JlQqi4.jpg";
             character = Self;
             "credit_id" = 558597d792514137b700063b;
             "genre_ids" =             (
                 99
             );
             id = 345466;
             order = 0;
             "original_language" = en;
             "original_title" = Istintobrass;
             overview = "One of the most controversial, original and loved figures of Italian cinema. The most censored director of all time. An anarchist of the film, a gifted experimenter, an inventor of dreams. A truly great artist.";
             popularity = "6.353";
             "poster_path" = "/psmKwr3IathwvJLFaqeCUdbODo8.jpg";
             "release_date" = "2013-08-30";
             title = Istintobrass;
             video = 0;
             "vote_average" = "5.4";
             "vote_count" = 5;
         },
 */
