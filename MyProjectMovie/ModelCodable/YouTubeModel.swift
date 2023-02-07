//
//  YouTubeModel.swift
//  MyProjectMovie
//
//  Created by Яна Угай on 21.01.2023.
//

import Foundation

struct YoutubeModel: Codable {
    let items: [VideoElement]
}

struct VideoElement: Codable {
    let id: IdVideoElement
}

struct IdVideoElement: Codable {
    let kind: String
    let videoId: String
}
