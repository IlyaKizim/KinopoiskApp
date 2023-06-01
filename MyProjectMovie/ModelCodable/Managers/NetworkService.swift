//
//  NetworkService.swift
//  MyProjectMovie
//
//  Created by Кизим Илья on 30.05.2023.
//

import Foundation
import RxSwift

enum APIError: Error {
    case failedTogetData
    case invalidURL
    case invalidResponse
    case invalidQuery
    case noResults
}

protocol Apiclient {
    func getTitles(from path: String) -> Observable<[Title]>
    func search (with query: String, completion: @escaping (Result<[Title], Error>) -> Void)
    func getPopularPeople(completion: @escaping (Result<[People], Error>) -> Void)
    func getDetailActor(with query: String, completion: @escaping (Result<DetailActor, Error>) -> Void)
    func getMovie(with query: String) -> Observable<VideoElement>
    func getListMoviesForActors(with query: String, completion: @escaping (Result<[List], Error>) -> Void)
    func getNews() -> Observable<[News]>
    func getActorsWhoPlayingInMovie(with query: String, completion: @escaping (Result<[ActrosWhoPlaying], Error>) -> Void)
}
