//
//  Date+Extension.swift
//  Personal-Diary
//
//  Created by Isaac on 11/20/22.
//

import UIKit

extension Date{
    func dateFromStringWithFormat(format: DateFormat, string: String) -> Date?{
       let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ID")
        dateFormatter.timeZone = TimeZone.autoupdatingCurrent
        dateFormatter.dateFormat = format.rawValue
        
        return dateFormatter.date(from: string)
    }
}
