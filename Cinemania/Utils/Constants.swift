import UIKit
import RealmSwift

//struct Constants {
//    static let tmdbImageBaseUrl = "https://image.tmdb.org/t/p/original"
//    static let tmdbApiKey = "c41873ea67b88f6ae314459f7b75f68e"
//    static let tmdbBaseUrl = "https://api.themoviedb.org"
//}

// MARK: - APIs path and constans
enum APIs: String {
    case apiKey = "c41873ea67b88f6ae314459f7b75f68e"
    case baseURL = "https://api.themoviedb.org/3/"
    case getImage = "https://image.tmdb.org/t/p/original"
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
