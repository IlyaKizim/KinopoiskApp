import Foundation
import RxSwift


final class APICaller: Apiclient {
    
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
    
    func getMovie(with query: String) -> Observable<VideoElement> {
        
        return Observable.create { observer in
            guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {
                observer.onError(APIError.invalidQuery)
                return Disposables.create()
            }
            guard let url = URL(string: "\(ConstantsURL.YouTubeBaseUrl)q=\(query)&key=\(ConstantsURL.YouTubeAPI_Key)") else {
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
                    let results = try JSONDecoder().decode(YoutubeModel.self, from: data)
                    if let videoElement = results.items.first {
                        observer.onNext(videoElement)
                        observer.onCompleted()
                    }
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
    
    //    private func loadUrlAndDecode<D: Decodable>(url: URL, params: [String: String]? = nil, completion: @escaping(Result<D, MovieError>) -> ()) {
    //
    //        Constants.urlSession.dataTask(with: url) {[weak self] (data, responce, error) in
    //            guard let self = self else { return }
    //            if error != nil {
    //                self.executeCompletionhendlerMainThread(with: .failure(.apiError), completion: completion)
    //                return
    //            }
    //
    //            guard let httpResponce = responce as? HTTPURLResponse, 200..<300 ~= httpResponce.statusCode else {
    //                self.executeCompletionhendlerMainThread(with: .failure(.invalidResponce), completion: completion)
    //                return
    //            }
    //
    //            guard let data = data else {
    //                self.executeCompletionhendlerMainThread(with: .failure(.noData), completion: completion)
    //                return
    //            }
    //
    //            do {
    //                let decoderResponce = try Constants.jsonDecoder.decode(D.self, from: data)
    //                self.executeCompletionhendlerMainThread(with: .success(decoderResponce), completion: completion)
    //            } catch {
    //                self.executeCompletionhendlerMainThread(with: .failure(.serializationError), completion: completion)
    //            }
    //        }.resume()
    //    }
    //
    //    private func executeCompletionhendlerMainThread<D: Decodable>(with result: Result<D, MovieError>, completion: @escaping(Result<D, MovieError>) -> ()) {
    //        DispatchQueue.main.async {
    //            completion(result)
    //        }
    //    }

