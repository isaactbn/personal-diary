//
//  CAValidation.swift
//  Personal-Diary
//
//  Created by Isaac on 11/20/22.
//

import Foundation

enum Regex: String {
    case email = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    case alphabet = ".*[^A-Za-z ].*"
    case numeric = "^[0-9]{1,}$"
    case date = "dd MMMM yyyy"
    case alphanumeric = ".*[a-zA-Z0-9 ].*"
}

protocol CAValidation {
    func check(s: String, regex: Regex) -> Bool
    func isEmpty(s: String) -> Bool
}

class BaseValidation: CAValidation {
    func check(s: String, regex: Regex) -> Bool {
        if regex == .alphabet {
            do {
                let expression = try NSRegularExpression(pattern: regex.rawValue, options: [])
                return expression.firstMatch(in: s, options: [], range: NSMakeRange(0, s.count)) == nil
            } catch {
                return false
            }
        } else {
            let predicate = NSPredicate(format:"SELF MATCHES %@", regex.rawValue)
            return predicate.evaluate(with: s)
        }
    }
    
    func isEmpty(s: String) -> Bool {
        return s.isEmpty()
    }
}
