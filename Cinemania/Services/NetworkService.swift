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
        
        let url = "\(Constants.trendingBaseUrl)\(mediaType)/\(timeWindow)"
        let parameters: Parameters = [
            "api_key": Constants.apiKey,
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
            "api_key": Constants.apiKey,
            "language": "en-US"
        ]
        
        let movieGenresUrl = "\(Constants.getMoviesGenreList)"
        let tvShowGenresUrl = "\(Constants.getTVsGenreList)"
        
        let dispatchGroup = DispatchGroup()
        
        var allGenres: [Genre] = []
        
        /// Fetch movie genres
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
        
        /// Fetch TV show genres
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
        
        let url = "\(Constants.baseUrl)\(type)/\(id)\(Constants.videos)"
        
        let parameters: Parameters = [
            "api_key": Constants.apiKey,
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
    
    func search(
        with query: String,
        completion: @escaping (Result<[Movies], Error>) -> Void
    ) {
        /// Ensure the query is properly URL encoded
        guard let encodedQuery = query.addingPercentEncoding(
            withAllowedCharacters: .urlQueryAllowed
        ) else { return }
        
        /// Construct the URL for the search request
        guard let url = URL(
            string: "\(Constants.baseUrl)search/movie?query=\(encodedQuery)&api_key=\(Constants.apiKey)"
        ) else {
            completion(.failure(APIError.invalidResponse))
            return
        }
        
        /// Create the URLRequest object
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        /// Start the URL session data task
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            /// Check for error
            if let error = error {
                completion(.failure(error))
                return
            }
            
            /// Ensure we received a valid HTTP response
            guard let httpResponse = response as? HTTPURLResponse, (200...209).contains(httpResponse.statusCode) else {
                completion(.failure(APIError.invalidResponse))
                return
            }
            
            /// Ensure we have data
            guard let data = data else {
                completion(.failure(APIError.failedToGetData))
                return
            }
            
            do {
                let results = try JSONDecoder().decode(TrendingMovies.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(results.results))
                }
                debugPrint(results)
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(APIError.failedToGetData))
                }
                debugPrint("Decoding error: \(error.localizedDescription)")
            }
        }
        task.resume()
    }
}
