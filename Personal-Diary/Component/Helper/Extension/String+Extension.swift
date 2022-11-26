//
//  String+Extension.swift
//  Personal-Diary
//
//  Created by Isaac on 11/20/22.
//

import UIKit

enum DateFormat: String {
    case ISO = "yyyy-MM-dd HH:mm:ss "
    case monthInitial = "dd MMM yyyy"
    case dateWithStripReversed = "yyyy-MM-dd"
}
var setLocale = Locale(identifier: "ID")

extension String {
    func isEmpty() -> Bool {
        return trimmingCharacters(in: .whitespacesAndNewlines) == "" || isEmpty
    }
    
    
    func customColorString(customText: String, color: UIColor, weight: UIFont.Weight, fontSize: CGFloat, isUnderlined: Bool) -> NSMutableAttributedString {
        let myString: String = self
        let range = (myString as NSString).range(of: customText)
        let attributedText = NSMutableAttributedString.init(string: myString)
        
        attributedText.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
        attributedText.addAttribute(.font, value: UIFont.systemFont(ofSize: fontSize, weight: weight), range: range)
        if isUnderlined {
            attributedText.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: range)
        }
        
        return attributedText
    }
    
    func formatedDate(from formatDate: DateFormat, format: DateFormat = .monthInitial) -> String {
        if let originalDate: Date = Date().dateFromStringWithFormat(format: formatDate, string: self) {
            let formatter: DateFormatter = DateFormatter()
            formatter.locale = setLocale
            formatter.dateFormat = format.rawValue
            return formatter.string(from: originalDate)
        } else { return self }
    }
}
