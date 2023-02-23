//
//  DetailActor.swift
//  MyProjectMovie
//
//  Created by Яна Угай on 15.02.2023.
//

import Foundation

struct DetailActor: Codable {
    var biography: String?
    var birthday: String?
    var deathday: String?
    var name: String?
    var placeOfBirth: String?
    var id: Int?
    var profilePath: String?
    
    enum CodingKeys: String, CodingKey {
        case biography = "biography"
        case birthday = "birthday"
        case deathday = "deathday"
        case name = "name"
        case placeOfBirth = "place_of_birth"
        case id = "id"
        case profilePath = "profile_path"
    }
}

/*
 {"adult":false,"also_known_as":[],"biography":"Gary Wayne Coleman (February 8, 1968 – May 28, 2010) was an American actor, known for his childhood role as Arnold Jackson in the American sitcom Diff'rent Strokes (1978–1986) and for his small stature as an adult. He was described in the 1980s as \"one of television's most promising stars\". After a successful childhood acting career, Coleman struggled financially later in life. In 1989, he successfully sued his parents and business advisor over misappropriation of his assets, only to declare bankruptcy a decade later.\n\nDescription above from the Wikipedia article Gary Coleman, licensed under CC-BY-SA, full list of contributors on Wikipedia.","birthday":"1968-02-08","deathday":"2010-05-28","gender":2,"homepage":null,"id":75341,"imdb_id":"nm0171041","known_for_department":"Acting","name":"Gary Coleman","place_of_birth":"Zion, Illinois, USA","popularity":436.666,"profile_path":"/77YIEd2tastsT3fjEraKOjCvgyD.jpg"}
 */
