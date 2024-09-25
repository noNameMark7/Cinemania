import UIKit
import Alamofire

// MARK: -  NetworkService

final class NetworkService {
    
    static let shared = NetworkService()
    
    private init() {}
   
    public func fetchTrendingMedia<T: Codable>(
        mediaType: TypeOfMedia,
        timeWindow: TimeWindow,
        modelType: T.Type,
        completion: @escaping ((Result<T?, Error>) -> Void)
    ) {
        
        let url = "\(TRENDING_BASE_URL)\(mediaType)/\(timeWindow)"
        let parameters: Parameters = [
            "api_key": API_KEY,
            "language": "en-US",
            "page": 1
        ]
        
        AF.request(
            url,
            parameters: parameters
        ).responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let model):
                completion(.success(model))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    public func fetchAllGenres(
        completion: @escaping (Result<[Genre], Error>) -> Void
    ) {
        
        let parameters: Parameters = [
            "api_key": API_KEY,
            "language": "en-US"
        ]
        
        let movieGenresUrl = "\(GET_MOVIES_GENRE_LIST)"
        let tvShowGenresUrl = "\(GET_TV_GENRE_LIST)"
        
        let dispatchGroup = DispatchGroup()
        
        var allGenres: [Genre] = []
        
        // Fetch movie genres
        dispatchGroup.enter()
        AF.request(
            movieGenresUrl,
            parameters: parameters
        ).responseDecodable(of: Genres.self) { response in
            defer {
                dispatchGroup.leave()
            }
            switch response.result {
            case .success(let genres):
                allGenres.append(contentsOf: genres.genres)
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
        // Fetch TV show genres
        dispatchGroup.enter()
        AF.request(
            tvShowGenresUrl,
            parameters: parameters
        ).responseDecodable(of: Genres.self) { response in
            defer {
                dispatchGroup.leave()
            }
            switch response.result {
            case .success(let genres):
                allGenres.append(contentsOf: genres.genres)
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            completion(.success(allGenres))
        }
    }
    
    public func loadTrailer(
        _ type: TypeOfMedia,
        _ id: Int,
        completion: @escaping ((URL?) -> Void)
    ) {
        
        let url = "\(BASE_URL)\(type)/\(id)\(VIDEOS)"
        
        let parameters: Parameters = [
            "api_key": API_KEY,
            "language": "en-US"
        ]
        
        AF.request(
            url,
            parameters: parameters
        ).responseDecodable(of: Trailers.self) { response in
            
            guard let trailers = response.value else {
                print("Error: Failed to load trailers - \(String(describing: response.error))")
                completion(nil)
                return
            }
            
            if trailers.results.isEmpty {
                completion(nil)
                return
            }
            
            guard let trailer = trailers.results.first else {
                print("Error: Trailer not found")
                completion(nil)
                return
            }
            
            guard let trailerUrl = URL(
                string: "https://www.youtube.com/watch?v=\(trailer.key)"
            ) else {
                print("Error: Invalid trailer URL")
                completion(nil)
                return
            }
            completion(trailerUrl)
        }
    }
    
    func universalSearch(
        with query: String,
        completion: @escaping (Result<[Media], Error>) -> Void
    ) {
        guard let encodedQuery = query.addingPercentEncoding(
            withAllowedCharacters: .urlQueryAllowed
        ) else { return }
        
        guard let url = URL(
            string: "\(BASE_URL)search/multi?query=\(encodedQuery)&api_key=\(API_KEY)"
        ) else {
            completion(.failure(APIError.invalidResponse))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...209).contains(httpResponse.statusCode) else {
                completion(.failure(APIError.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(APIError.failedToGetData))
                return
            }
            
            do {
                // Decode the response into TrendingMedia
                let results = try JSONDecoder().decode(TrendingMedia.self, from: data)
                let mediaResults = results.results
                    .filter { $0.mediaType == "movie" || $0.mediaType == "tv" } // Filter out people or irrelevant types
                    .map { Media(from: $0) }
                
                DispatchQueue.main.async {
                    completion(.success(mediaResults))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(APIError.failedToGetData))
                }
            }
        }
        task.resume()
    }
}
