import UIKit

// MARK: - ValueFormatting

struct ValueFormatting {
    
    static func formattingPerMonthDateYear(_ date: String?) -> String {
        guard let dateInput = date else { return "No date found" }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let newDate = dateFormatter.date(from: dateInput) {
            dateFormatter.dateFormat = "MMM d, yyyy"
            return dateFormatter.string(from: newDate)
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
