import UIKit

extension String {
    func dateWithISO8601String() -> Date? {
        var formattedDateString = self
        
        if self.hasSuffix("Z") {
            let lastIndex = self.indices.last!
            formattedDateString = self.substring(to: lastIndex) + "-000"
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ssZZZ"
        return dateFormatter.date(from: formattedDateString)
    }
    
    func dateFromString(str: String, withFormat dateFormat: String) -> NSDate? {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        formatter.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale?
        return formatter.date(from: str) as NSDate?
    }
}
    
extension Date {

    func toString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM yyyy - HH:mm"
        return dateFormatter.string(from: self as Date)
    }
    
    func getTime() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: self as Date)
    }
    
    func getDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter.string(from: self as Date)
    }
}
