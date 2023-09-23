import UIKit
import RealmSwift

// MARK: - Path and constans
struct Constants {
    static let apiKey = "c41873ea67b88f6ae314459f7b75f68e"
    static let trendingBaseUrl = "https://api.themoviedb.org/3/trending/"
    static let baseUrl = "https://api.themoviedb.org/3/"
    static let getImage = "https://image.tmdb.org/t/p/original"
    static let getMoviesGenreList = "https://api.themoviedb.org/3/genre/movie/list"
    static let getTVsGenreList = "https://api.themoviedb.org/3/genre/tv/list"
    static let videos = "/videos"
}

// MARK: - Time window parameter 
enum TimeWindow: String {
    case day = "day"
    case week = "week"
}

// MARK: - Type of media
enum TypeOfMedia: String, PersistableEnum {
    case movie = "movie"
    case tv = "tv"
}

// MARK: - Fonts
enum CustomFont {
    case comfortaaRegular
    case comfortaaMedium
    case comfortaaSemiBold
    case manropeRegular
    case manropeMedium
    
    var fontName: String {
        switch self {
        case .comfortaaRegular: return "Comfortaa-Regular"
        case .comfortaaMedium: return "Comfortaa-Medium"
        case .comfortaaSemiBold: return "Comfortaa-SemiBold"
        case .manropeRegular: return "Manrope-Regular"
        case .manropeMedium: return "Manrope-Medium"
        }
    }
}
