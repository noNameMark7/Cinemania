import UIKit

struct ValueFormatting {
    static func convertDateFormat(_ date: String?) -> String {
        guard let dateInput = date else { return "No date found" }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let newDate = dateFormatter.date(from: dateInput) {
            dateFormatter.dateFormat = "MMM d, yyyy"
            return dateFormatter.string(from: newDate)
        }
        return ""
    }
    
    static func formatVoteAverage(_ voteAverage: Double?) -> String {
        if let voteAverage = voteAverage {
            let roundedValue = String(format: "%.1f", voteAverage)
            return "\(roundedValue)"
        } else {
            // Handle the case where voteAverage is nil
            return "N/A"
        }
    }
}
