//
//  APICaller.swift
//  MyProjectMovie
//
//  Created by Яна Угай on 10.01.2023.
//

import Foundation

struct Constants {
    
    static let APIKey = "1d80d5a6ac5851a945e7c8f5add7fca2"
    static let basicURL = "https://api.themoviedb.org"
    static let YouTubeAPI_Key = "AIzaSyD1p-dh3OFO92Y05thKIQ1Htm1uNXmHO74"
    static let YouTubeBaseUrl = "https://youtube.googleapis.com/youtube/v3/search?"
    static let BasicURLForNews = "https://newsapi.org/v2/everything?"
    static let APIKeyForNews = "687de243432b4efdb9bbb77a82085f4b"
}

enum APIError: Error {
    
    case failedTogetData
}
class APICaller {
    
    static let shared = APICaller()
    
    func getPopularMovies(completion: @escaping (Result<[Title], Error>) -> Void) {
        guard let url = URL(string: "\(Constants.basicURL)/3/movie/popular?api_key=\(Constants.APIKey)&language=en-US&page=1") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { (data, _, error) in
            guard let data = data, error == nil else{
                return
            }
            do {
                let results = try JSONDecoder().decode(TitleMovie.self, from: data)
                completion(.success(results.results))
            }
            catch {
                completion(.failure(APIError.failedTogetData))
            }
        }
        task.resume()
    }
    
    
    func getTopRateMovie(completion: @escaping (Result<[Title], Error>) -> Void) {
        guard let url = URL(string: "\(Constants.basicURL)/3/movie/top_rated?api_key=\(Constants.APIKey)&language=en-US&page=1") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { (data, _, error) in
            guard let data = data, error == nil else {
                return
            }
            do {
                let results = try JSONDecoder().decode(TitleMovie.self, from: data)
                completion(.success(results.results))
            }
            catch {
                completion(.failure(APIError.failedTogetData))
            }
        }
        task.resume()
    }
    
    func getUpComingMovies (completion: @escaping (Result<[Title], Error>) -> Void) {
        guard let url = URL(string: "\(Constants.basicURL)/3/movie/upcoming?api_key=\(Constants.APIKey)&language=en-US&page=1") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { (data, _, error) in
            guard let data = data, error == nil else {
                return
            }
            do {
                let results = try JSONDecoder().decode(TitleMovie.self, from: data)
                completion(.success(results.results))
            }
            catch {
                completion(.failure(APIError.failedTogetData))
            }
        }
        task.resume()
      
    }
    
    func getPlayingNowMoview (completion: @escaping (Result<[Title], Error>) -> Void) {
        guard let url = URL(string: "\(Constants.basicURL)/3/movie/now_playing?api_key=\(Constants.APIKey)&language=en-US&page=1") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { (data, _, error) in
            guard let data = data, error == nil else {
                return
            }
            do {
                let results = try JSONDecoder().decode(TitleMovie.self, from: data)
                completion(.success(results.results))
            }
            catch {
                completion(.failure(APIError.failedTogetData))
            }
        }
        task.resume()
      
    }
    
    func getTVshow (completion: @escaping (Result<[Title], Error>) -> Void) {
        guard let url = URL(string: "\(Constants.basicURL)/3/tv/on_the_air?api_key=\(Constants.APIKey)&language=en-US&page=1") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { (data, _, error) in
            guard let data = data, error == nil else {
                return
            }
            do {
                let results = try JSONDecoder().decode(TitleMovie.self, from: data)
                completion(.success(results.results))
            }
            catch {
                completion(.failure(APIError.failedTogetData))
            }
        }
        task.resume()
    }
    
    func getMovie(with query: String, completion: @escaping (Result<VideoElement, Error>) -> Void) {
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
        guard let url = URL(string: "\(Constants.YouTubeBaseUrl)q=\(query)&key=\(Constants.YouTubeAPI_Key)") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { (data, _, error) in
            guard let data = data, error == nil else {
                return
            }
            do {
                let results = try JSONDecoder().decode(YoutubeModel.self, from: data)
                completion(.success(results.items[0]))
            }
            catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    func search (with query: String, completion: @escaping (Result<[Title], Error>) -> Void) {
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
        guard let url = URL(string: "\(Constants.basicURL)/3/search/movie?api_key=\(Constants.APIKey)&query=\(query)") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { (data, _, error) in
            guard let data = data, error == nil else {
                return
            }
            do {
                let results = try JSONDecoder().decode(TitleMovie.self, from: data)
                completion(.success(results.results))
            }
            catch {
                completion(.failure(APIError.failedTogetData))
            }
        }
        task.resume()
    }
    func getPopularPeople(completion: @escaping (Result<[People], Error>) -> Void) {
        guard let url = URL(string: "\(Constants.basicURL)/3/person/popular?api_key=\(Constants.APIKey)&language=en-US&page=1") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { (data, _, error) in
            guard let data = data, error == nil else {
                return
            }
            do {
                let results = try JSONDecoder().decode(TitlePeople.self, from: data)
                completion(.success(results.results))
            }
            catch {
                completion(.failure(APIError.failedTogetData))
            }
        }
        task.resume()
    }
    func getDetailActor(with query: String, completion: @escaping (Result<DetailActor, Error>) -> Void) {
        let query = query 
        guard let url = URL(string: "\(Constants.basicURL)/3/person/\(query)?api_key=\(Constants.APIKey)&language=en-US") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) {(data, _, error) in
            guard let data = data, error == nil else {return}
            do {
                let results = try JSONDecoder().decode(DetailActor.self, from: data)
                completion(.success(results))
            }
            catch {
                completion(.failure(APIError.failedTogetData))
            }
        }
        task.resume()
    }
    func getListMoviesForActors(with query: String, completion: @escaping (Result<[List], Error>) -> Void) {
        guard let url = URL(string: "\(Constants.basicURL)/3/person/\(query)/movie_credits?api_key=\(Constants.APIKey)&language=en-US") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)){(data, _, error) in
            guard let data = data, error == nil else {return}
            do {
                let results = try JSONDecoder().decode(ListMovie.self, from: data)
                completion(.success(results.cast))
            }
            catch {
                completion(.failure(APIError.failedTogetData))
            }
        }
        task.resume()
    }
    func getNews(completion: @escaping (Result<[News], Error>) -> Void) {
        guard let url = URL(string: "\(Constants.BasicURLForNews)q=movies&apiKey=\(Constants.APIKeyForNews)") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)){(data, _, error) in
            guard let data = data, error == nil else {return}
            do {
                let results = try JSONDecoder().decode(TitleNews.self, from: data)
                completion(.success(results.articles))
            } catch  {
                completion(.failure(APIError.failedTogetData))
            }
        }
        task.resume()
    }
    
    func getActorsWhoPlayingInMovie(with query: String, completion: @escaping (Result<[ActrosWhoPlaying], Error>) -> Void) {
        let query = query
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/\(query)/credits?api_key=\(Constants.APIKey)&language=en-US") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)){(data,_,error) in
            guard let data = data, error == nil else {return}
            do {
                let results = try JSONDecoder().decode(TitleActrosWhoPlaying.self, from: data)
                completion(.success(results.cast))
            } catch  {
                completion(.failure(APIError.failedTogetData))
            }
        }
        task.resume()
    }
}
    

//    func getActorBirthday(completion: @escaping (Result<String, Error>) -> Void) {
//        let today = Date()
//        let formatter = DateFormatter()
//        formatter.dateFormat = "yyyy-MM-dd"
//        let todayString = formatter.string(from: today)
//        guard let url = URL(string: "https://api.themoviedb.org/3/discover/person?api_key=1d80d5a6ac5851a945e7c8f5add7fca2&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&primary_release_date.gte=\(todayString)&primary_release_date.lte=\(todayString)") else {return}
//        let task = URLSession.shared.dataTask(with: URLRequest(url: url)){(data, _, error) in
//            guard let data = data, error == nil else {return}
//            do {
//                let result = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
////                let results = try JSONDecoder().decode(TitleNews.self, from: data)
//                print(todayString)
//               print(result)
//            } catch  {
//                print(error.localizedDescription)
//            }
//        }
//        task.resume()
//    }
