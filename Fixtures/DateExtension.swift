//
//  TimeIntervalExtension.swift
//  TheDiveAdvisor
//
//  Created by ben on 01/10/2017.
//  Copyright © 2017 ben smith. All rights reserved.
//

import Foundation
import UIKit

extension Date {
    
    func nicelyFormattedDate() -> String
    {
        //Create Date Formatter
        let dateFormatter = DateFormatter()
        //Specify Format of String to Parse
        dateFormatter.dateFormat = "MM-dd-yyyy HH:mm"
        //Parse into NSDate
        let unitFlags = Set<Calendar.Component>([.hour, .minute, .day, .month, .year,])
        let components = NSCalendar.current.dateComponents(unitFlags, from: self)
        
        var month = [NSLocalizedString("Jan", comment: ""),
                     NSLocalizedString("Feb", comment: ""),
                     NSLocalizedString("Mar", comment: ""),
                     NSLocalizedString("Apr", comment: ""),
                     NSLocalizedString("May", comment: ""),
                     NSLocalizedString("Jun", comment: ""),
                     NSLocalizedString("Jul", comment: ""),
                     NSLocalizedString("Aug", comment: ""),
                     NSLocalizedString("Sep", comment: ""),
                     NSLocalizedString("Oct", comment: ""),
                     NSLocalizedString("Nov", comment: ""),
                     NSLocalizedString("Dec", comment: "")]
        
        
        //Return Parsed Date
        //return "\(components.hour ?? ""):\(components.minute ?? ""), \(components.day ?? "") \(month[components.month ?? "") \(components.year ?? "0"))"
        var stringDate = ""
        if let monthNumber = components.month,
            let day = components.day {
            stringDate = "\(monthNumber - 1 >= 0 ? month[monthNumber - 1] : month[monthNumber]). \(day)"
        }
        return stringDate
    }
}
