import Foundation

class DatesFormatter {
    
    // MARK: - Internal methods
    
    static func dateFormater(date: Date, format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        let allTimeStr = dateFormatter.string(from: date)
        return allTimeStr
    }
    
    static func compare(
        _ date: Date,
        equalTo: Date,
        by dateComponents: Set<Calendar.Component>
    ) -> Bool {
        dateFromComponents(by: dateComponents, date: date) == dateFromComponents(by: dateComponents, date: equalTo)
    }
    
    // MARK: - Private methods
    
    private static func dateFromComponents(by dateComponents: Set<Calendar.Component>, date: Date) -> Date {
        let components = Calendar.current.dateComponents(dateComponents, from: date)
        return Calendar.current.date(from: components) ?? .now
    }
}
