import UIKit
import RealmSwift

enum TimeWindow: String {
    case day = "day"
    case week = "week"
}

enum TypeOfMedia: String, PersistableEnum {
    case movie = "movie"
    case tv = "tv"
}

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
