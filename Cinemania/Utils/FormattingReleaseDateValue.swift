import UIKit

struct FormattingReleaseDateValue {
    
    static func convertToYearFormat(_ date: String?) -> String {
        guard let dateInput = date else { return "No date found" }
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        if let newDate = dateFormatter.date(from: dateInput) {
            dateFormatter.dateFormat = "yyyy"
            return dateFormatter.string(from: newDate)
        }
        
        dateFormatter.dateFormat = "yyyy"
        
        if let yearDate = dateFormatter.date(from: dateInput) {
            return dateFormatter.string(from: yearDate)
        }
        
        return "Invalid date"
    }
    
    static func formattingToFloat(_ voteAverage: Double?) -> String {
        if let voteAverage = voteAverage {
            let roundedValue = String(format: "%.1f", voteAverage)
            return "\(roundedValue)"
        } else {
            return "N/A"
        }
    }
    
    static func formattingToIntegerWithPercentage(_ voteAverage: Double?) -> String {
        if let voteAverage = voteAverage {
            let percentageValue = Int(voteAverage * 10)
            return "\(percentageValue)%"
        } else {
            return "N/A"
        }
    }
}
