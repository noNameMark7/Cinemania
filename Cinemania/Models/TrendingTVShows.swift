import UIKit

// MARK: - TrendingTVShows

struct TrendingTVShows: Codable {
    
    let page: Int
    let results: [TVShows]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}


// MARK: - TVShows

struct TVShows: Codable {
    
    let adult: Bool
    let backdropPath: String
    let id: Int
    let name: String
    let originalName, overview, posterPath: String
    let genreIDS: [Int]
    let popularity: Double
    let firstAirDate: String
    let voteAverage: Double
    let voteCount: Int
    let originCountry: [String]

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case id, name
        case originalName = "original_name"
        case overview
        case posterPath = "poster_path"
        case genreIDS = "genre_ids"
        case popularity
        case firstAirDate = "first_air_date"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case originCountry = "origin_country"
    }
}
