//
//  ModelPeople.swift
//  MyProjectMovie
//
//  Created by Яна Угай on 15.02.2023.
//

import Foundation

struct TitlePeople: Codable {
    var results: [People]
}

struct People: Codable {
    var id: Int?
    var name: String?
    var profilePath: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case profilePath = "profile_path"
    }
}



/*
 {
     page = 1;
     results =     (
                 {
             adult = 0;
             gender = 2;
             id = 75341;
             "known_for" =             (
                                 {
                     "backdrop_path" = "/brlf6CqE8GP0bxYZkuTDUB7h7w1.jpg";
                     "first_air_date" = "1978-11-03";
                     "genre_ids" =                     (
                         35,
                         10751,
                         18
                     );
                     id = 2410;
                     "media_type" = tv;
                     name = "Diff'rent Strokes";
                     "origin_country" =                     (
                         US
                     );
                     "original_language" = en;
                     "original_name" = "Diff'rent Strokes";
                     overview = "The series stars Gary Coleman and Todd Bridges as Arnold and Willis Jackson, two African American boys from Harlem who are taken in by a rich white Park Avenue businessman named Phillip Drummond and his daughter Kimberly, for whom their deceased mother previously worked. During the first season and first half of the second season, Charlotte Rae also starred as the Drummonds' housekeeper, Mrs. Garrett.";
                     "poster_path" = "/7Z8BcfA2CD0CQ0m4ltgPqT5rdr9.jpg";
                     "vote_average" = "7.1";
                     "vote_count" = 225;
                 },
                                 {
                     adult = 0;
                     "backdrop_path" = "/hKPpoZnDMYyyZwfztY1EcFWEJVI.jpg";
                     "genre_ids" =                     (
                         35
                     );
                     id = 14577;
                     "media_type" = movie;
                     "original_language" = en;
                     "original_title" = "Dirty Work";
                     overview = "Unemployed and recently dumped, Mitch and his buddy Sam start a revenge-for-hire business to raise the $50,000 that Sam's father needs to get a heart transplant.";
                     "poster_path" = "/btYKWL9SP12nhkcw8EkMG3aFtga.jpg";
                     "release_date" = "1998-06-12";
                     title = "Dirty Work";
                     video = 0;
                     "vote_average" = "6.1";
                     "vote_count" = 201;
                 },
                                 {
                     "backdrop_path" = "/uNyEVSPeAtJgUBehuQJ8WEFwatN.jpg";
                     "first_air_date" = "1989-12-17";
                     "genre_ids" =                     (
                         10751,
                         16,
                         35
                     );
                     id = 456;
                     "media_type" = tv;
                     name = "The Simpsons";
                     "origin_country" =                     (
                         US
                     );
                     "original_language" = en;
                     "original_name" = "The Simpsons";
                     overview = "Set in Springfield, the average American town, the show focuses on the antics and everyday adventures of the Simpson family; Homer, Marge, Bart, Lisa and Maggie, as well as a virtual cast of thousands. Since the beginning, the series has been a pop culture icon, attracting hundreds of celebrities to guest star. The show has also made name for itself in its fearless satirical take on politics, media and American life in general.";
                     "poster_path" = "/zI3E2a3WYma5w8emI35mgq5Iurx.jpg";
                     "vote_average" = 8;
                     "vote_count" = 8623;
                 }
             );
             "known_for_department" = Acting;
             name = "Gary Coleman";
             popularity = "436.666";
             "profile_path" = "/77YIEd2tastsT3fjEraKOjCvgyD.jpg";
         }
 */
