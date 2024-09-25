import UIKit

// MARK: - TrendingMedia

struct TrendingMedia: Codable {
    let page: Int
    let results: [MediaResult]
    let totalPages: Int
    let totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page
        case results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}


// MARK: - MediaResult

struct MediaResult: Codable {
    let id: Int
    let title: String?
    let name: String?
    let posterPath: String?
    let backdropPath: String?
    let overview: String
    let genreIDS: [Int]?
    let popularity: Double
    let releaseDate: String?
    let firstAirDate: String?
    let voteAverage: Double
    let voteCount: Int
    let mediaType: String

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case name
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case overview
        case genreIDS = "genre_ids"
        case popularity
        case releaseDate = "release_date"
        case firstAirDate = "first_air_date"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case mediaType = "media_type"
    }

    var typeOfMedia: TypeOfMedia {
        return mediaType == "movie" ? .movie : .tv
    }
}
