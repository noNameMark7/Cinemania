import UIKit
import RealmSwift

// MARK: - Paths and constants

struct Constants {
    
    static let apiKey = "c41873ea67b88f6ae314459f7b75f68e"
    static let trendingBaseUrl = "https://api.themoviedb.org/3/trending/"
    static let baseUrl = "https://api.themoviedb.org/3/"
    static let getImage = "https://image.tmdb.org/t/p/original"
    static let getMoviesGenreList = "https://api.themoviedb.org/3/genre/movie/list"
    static let getTVsGenreList = "https://api.themoviedb.org/3/genre/tv/list"
    static let videos = "/videos"
    
    static let numberOfCellsPerRow: CGFloat = 3
    static let horizontalSpacing: CGFloat = 9
    static let verticalSpacing: CGFloat = 10
    static let sectionInsets = UIEdgeInsets(top: 11, left: 11, bottom: 11, right: 11)
    
    static let divider = " · "
}


// MARK: - TimeWindow

enum TimeWindow: String {
    case day = "day"
    case week = "week"
}


// MARK: - TypeOfMedia

enum TypeOfMedia: String, PersistableEnum {
    case movie = "movie"
    case tv = "tv"
}


// MARK: - CustomFont

enum CustomFont {
    
    case comfortaaLight
    case comfortaaRegular
    case comfortaaMedium
    case comfortaaSemiBold
    case comfortaaBold
    
    case suseThin
    case suseLight
    case suseRegular
    case suseMedium
    case suseSemiBold
    case suseBold
    
    
    var fontName: String {
        switch self {
        case .comfortaaLight: return "Comfortaa-Light"
        case .comfortaaRegular: return "Comfortaa-Regular"
        case .comfortaaMedium: return "Comfortaa-Medium"
        case .comfortaaSemiBold: return "Comfortaa-SemiBold"
        case .comfortaaBold: return "Comfortaa-Bold"
            
        case .suseThin: return "SUSE-Thin"
        case .suseLight: return "SUSE-Light"
        case .suseRegular: return "SUSE-Regular"
        case .suseMedium: return "SUSE-Medium"
        case .suseSemiBold: return "SUSE-SemiBold"
        case .suseBold: return "SUSE-Bold"
            
        }
    }
}


// MARK: - APIError

enum APIError: Error {
    case failedToGetData
    case invalidResponse
}
