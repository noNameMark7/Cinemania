import UIKit
import RealmSwift

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
