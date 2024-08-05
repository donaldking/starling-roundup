import Foundation

public enum SBTimeAgo {
    case oneWeek
    case twoWeeks
    case threeWeeks
    case fourWeeks
    
    // Computed property to get the date range for the specified case
    public var dateRange: (minDate: Date, maxDate: Date) {
        let calendar = Calendar.current
        let currentDate = Date()
        
        // Calculate the start date (minDate) based on the enum case
        let weeksAgo: Int
        switch self {
        case .oneWeek:
            weeksAgo = 1
        case .twoWeeks:
            weeksAgo = 2
        case .threeWeeks:
            weeksAgo = 3
        case .fourWeeks:
            weeksAgo = 4
        }
        
        // Calculate the minDate (start of the week)
        let minDate = calendar.date(byAdding: .weekOfYear, value: -weeksAgo, to: currentDate) ?? Date.now
        
        // Calculate the maxDate (end of the week)
        let maxDate = calendar.date(byAdding: .day, value: 7, to: minDate) ?? Date.now
        
        return (minDate, maxDate)
    }
}

// MARK: - Date Extension
extension Date {
    public func formattedDateString(format: String = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'") -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.timeZone = TimeZone.current
        return formatter.string(from: self)
    }
}
