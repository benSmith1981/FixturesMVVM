import UIKit

class DateTodayFormatter {
    func stringFromDate(date: NSDate?) -> String? {
        guard let date = date else {
            return nil
        }
        
        let messageDate = roundDateToDay(date: date)
        let todayDate = roundDateToDay(date: NSDate())
        
        let formatter = DateFormatter()
        
        if messageDate == todayDate {
            formatter.dateFormat = "'Today' - hh:mma"
        }
        else {
            formatter.dateFormat = "MMM. dd - hh:mma"
        }
        
        return formatter.string(from: date as Date)
    }
    
    func roundDateToDay(date: NSDate) -> NSDate {
        let calendar  = Calendar.current
        let flags = Set<Calendar.Component>([.day, .month, .year])
        let components = calendar.dateComponents(flags, from: date as Date)
        
        return calendar.date(from:components)! as NSDate
    }
}

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
