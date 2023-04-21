import Foundation

struct TitleActrosWhoPlaying: Codable {
    let cast: [ActrosWhoPlaying]
}

struct ActrosWhoPlaying: Codable {
    let originalName: String?
    let profilePath: String?
    let id: Int?
    
    enum CodingKeys: String, CodingKey {
        case originalName = "original_name"
        case profilePath = "profile_path"
        case id = "id"
    }
}


/*
 {
     cast =     (
                 {
             adult = 0;
             "cast_id" = 3;
             character = "Andy Dufresne";
             "credit_id" = 52fe4231c3a36847f800b131;
             gender = 2;
             id = 504;
             "known_for_department" = Acting;
             name = "Tim Robbins";
             order = 0;
             "original_name" = "Tim Robbins";
             popularity = "17.003";
             "profile_path" = "/hsCu1JUzQQ4pl7uFxAVFLOs9yHh.jpg";
         },
                 {
             adult = 0;
 */
