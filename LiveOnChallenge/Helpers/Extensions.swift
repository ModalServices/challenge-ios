//
//  Extensions.swift
//  LiveOnChallenge
//
//  Created by Pedro Albuquerque on 10/11/19.
//

import UIKit
import SwiftDate

extension Region {
    
    static var brazil: Region {
        return Region(calendar: Calendars.gregorian,
                      zone: TimeZone(identifier: "UTC") ?? Zones.current,
                      locale: Locales.portugueseBrazil)
    }
}

extension Date {
    
    var yyyyMMdd: String {
        return toDateWithOutHours(formart: "yyyy-MM-dd")
    }
    
    var ddMMyyyy: String {
        return toDateWithOutHours(formart: "dd/MM/yyyy")
    }
    
    var dMMMyyyy: String {
        return toDateWithOutHours(formart: "d MMMM yyyy")
    }
    
    var dMMM: String {
        return toDateWithOutHours(formart: "d MMMM")
    }
    
    var dd: String {
        return toDateWithOutHours(formart: "dd")
    }
    
    var ddMMM: String {
        return toDateWithOutHours(formart: "dd/MMM")
    }
    
    var ddMMyyyyHHmm: String {
        return toBrazillian(formart:"dd/MM/yyyy - HH:mm")
    }
    
    var MMMM: String {
        return toBrazillian(formart:"MMMM")
    }
    
    var HHmm: String {
        return toBrazillian(formart:"HH:mm")
    }
    
    func toBrazillian(formart: String) -> String {
        return self.toFormat(formart, locale: Locales.portugueseBrazil)
    }
    
    func toDateWithOutHours(formart: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = formart
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        return dateFormatter.string(from: self)
    }
}

extension Decimal {
    var number: NSDecimalNumber { return NSDecimalNumber(decimal: self) }
    
    var doubleValue:Double {
        return NSDecimalNumber(decimal:self).doubleValue
    }
}


extension Collection where Element == UInt8 {
    var string: String { return map(String.init).joined() }
    var decimal: Decimal { return Decimal(string: string) ?? 0 }
}

extension NumberFormatter {
    convenience init(numberStyle: Style) {
        self.init()
        self.numberStyle = numberStyle
    }
}

extension String {
    var brazillianISODate: Date {
        guard let date = self.toISODate(region: .brazil)?.date else {
            return Date(timeIntervalSince1970: 1)
        }
        return date
    }
    
    func toDate(format: String = "dd/MM/yyyy") -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        let date = dateFormatter.date(from: self)
        return date
    }
    
    func toDateAll(format: String = "yyyy-MM-dd'T'HH:mm:ssZ") -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        let date = dateFormatter.date(from: self)
        return date
    }
}
