import Foundation
import RxSwift

enum APIError: Error {
    case failedTogetData
    case invalidURL
    case invalidResponse
}

protocol Apiclient {  
    func getTitles(from path: String) -> Observable<[Title]>
}

protocol ApiclientSearch {
    func search (with query: String, completion: @escaping (Result<[Title], Error>) -> Void)
}

protocol ApicleintGetPopularPeople {
    func getPopularPeople(completion: @escaping (Result<[People], Error>) -> Void)
}

protocol ApiclientGetDetailActor {
    func getDetailActor(with query: String, completion: @escaping (Result<DetailActor, Error>) -> Void)
}

protocol  ApiclientGetMovie {
    func getMovie(with query: String, completion: @escaping (Result<VideoElement, Error>) -> Void)
}

protocol ApiclientGetListMoviewsForActors {
    func getListMoviesForActors(with query: String, completion: @escaping (Result<[List], Error>) -> Void)
}

protocol ApiclientGetNews {
    func getNews() -> Observable<[News]>
}

protocol ApiclientGetActorsWhoPlaingInMovie {
    func getActorsWhoPlayingInMovie(with query: String, completion: @escaping (Result<[ActrosWhoPlaying], Error>) -> Void)
}

final class APICaller: Apiclient, ApiclientGetMovie, ApiclientGetActorsWhoPlaingInMovie, ApiclientGetNews, ApiclientGetListMoviewsForActors, ApiclientGetDetailActor, ApicleintGetPopularPeople, ApiclientSearch {
    
    
    func getTitles(from path: String) -> Observable<[Title]> {
        return Observable.create { observer in
            guard let url = URL(string: "\(ConstantsURL.basicURL)/3/\(path)?api_key=\(ConstantsURL.APIKey)&language=en-US&page=1") else {
                observer.onError(APIError.invalidURL)
                return Disposables.create()
            }
            
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                guard let data = data, error == nil else {
                    observer.onError(APIError.failedTogetData)
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse, 200 ..< 300 ~= httpResponse.statusCode else {
                    observer.onError(APIError.invalidResponse)
                    return
                }
                
                do {
                    let results = try JSONDecoder().decode(TitleMovie.self, from: data)
                    observer.onNext(results.results)
                    observer.onCompleted()
                } catch {
                    observer.onError(APIError.failedTogetData)
                }
            }
            
            task.resume()
            
            return Disposables.create {
                task.cancel()
            }
        }
    }
    
    func getMovie(with query: String, completion: @escaping (Result<VideoElement, Error>) -> Void) {
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
        guard let url = URL(string: "\(ConstantsURL.YouTubeBaseUrl)q=\(query)&key=\(ConstantsURL.YouTubeAPI_Key)") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { (data, response, error) in
            guard let data = data, error == nil else {
                completion(.failure(APIError.failedTogetData))
                return
            }
            guard let httpResponse = response as? HTTPURLResponse, 200 ..< 300 ~= httpResponse.statusCode else {
                completion(.failure(APIError.invalidResponse))
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
        guard let url = URL(string: "\(ConstantsURL.basicURL)/3/search/movie?api_key=\(ConstantsURL.APIKey)&query=\(query)") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { (data, response, error) in
            guard let data = data, error == nil else {
                completion(.failure(APIError.failedTogetData))
                return
            }
            guard let httpResponse = response as? HTTPURLResponse, 200 ..< 300 ~= httpResponse.statusCode else {
                completion(.failure(APIError.invalidResponse))
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
        guard let url = URL(string: "\(ConstantsURL.basicURL)/3/person/popular?api_key=\(ConstantsURL.APIKey)&language=en-US&page=1") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { (data, response, error) in
            guard let data = data, error == nil else {
                completion(.failure(APIError.failedTogetData))
                return
            }
            guard let httpResponse = response as? HTTPURLResponse, 200 ..< 300 ~= httpResponse.statusCode else {
                completion(.failure(APIError.invalidResponse))
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
        guard let url = URL(string: "\(ConstantsURL.basicURL)/3/person/\(query)?api_key=\(ConstantsURL.APIKey)&language=en-US") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) {(data, response, error) in
            guard let data = data, error == nil else {
                completion(.failure(APIError.failedTogetData))
                return
            }
            guard let httpResponse = response as? HTTPURLResponse, 200 ..< 300 ~= httpResponse.statusCode else {
                completion(.failure(APIError.invalidResponse))
                return
            }
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
        guard let url = URL(string: "\(ConstantsURL.basicURL)/3/person/\(query)/movie_credits?api_key=\(ConstantsURL.APIKey)&language=en-US") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)){(data, response, error) in
            guard let data = data, error == nil else {
                completion(.failure(APIError.failedTogetData))
                return
            }
            guard let httpResponse = response as? HTTPURLResponse, 200 ..< 300 ~= httpResponse.statusCode else {
                completion(.failure(APIError.invalidResponse))
                return
            }
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
    
    func getNews() -> Observable<[News]> {
        return Observable.create { observer in
            guard let url = URL(string: "\(ConstantsURL.BasicURLForNews)q=movies&apiKey=\(ConstantsURL.APIKeyForNews)") else {
                observer.onError(APIError.invalidURL)
                return Disposables.create()
            }
            let task = URLSession.shared.dataTask(with: URLRequest(url: url)){(data, response, error) in
                guard let data = data, error == nil else {
                    observer.onError(APIError.failedTogetData)
                    return
                }
                guard let httpResponse = response as? HTTPURLResponse, 200 ..< 300 ~= httpResponse.statusCode else {
                    observer.onError(APIError.invalidResponse)
                    return
                }
                do {
                    let results = try JSONDecoder().decode(TitleNews.self, from: data)
                    observer.onNext(results.articles)
                    observer.onCompleted()
                } catch {
                    observer.onError(APIError.failedTogetData)
                }
            }
            task.resume()
            
            return Disposables.create {
                task.cancel()
            }
            
        }
    }
    
    func getActorsWhoPlayingInMovie(with query: String, completion: @escaping (Result<[ActrosWhoPlaying], Error>) -> Void) {
        let query = query
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/\(query)/credits?api_key=\(ConstantsURL.APIKey)&language=en-US") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)){(data, response, error) in
            guard let data = data, error == nil else {
                completion(.failure(APIError.failedTogetData))
                return
            }
            guard let httpResponse = response as? HTTPURLResponse, 200 ..< 300 ~= httpResponse.statusCode else {
                completion(.failure(APIError.invalidResponse))
                return
            }
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

