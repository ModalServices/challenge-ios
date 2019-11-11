//
//  Utils.swift
//  LiveOnChallenge
//
//  Created by Pedro Albuquerque on 09/11/19.
//

import UIKit
import HandyJSON
import SwiftyJSON
import SwiftDate

extension UIFont {
    
    var monospacedDigitFont: UIFont {
        let fontDescriptorFeatureSettings = [[UIFontDescriptor.FeatureKey.featureIdentifier: kNumberSpacingType,
                                              UIFontDescriptor.FeatureKey.typeIdentifier: kMonospacedNumbersSelector]]
        let fontDescriptorAttributes = [UIFontDescriptor.AttributeName.featureSettings: fontDescriptorFeatureSettings]
        let oldFontDescriptor = fontDescriptor
        let newFontDescriptor = oldFontDescriptor.addingAttributes(fontDescriptorAttributes)
        return UIFont(descriptor: newFontDescriptor, size: 0)
    }
    
    
    class func avenirLight(_ ofSize: CGFloat? = 15.0) -> UIFont {
        return UIFont(name: "Avenir-Light", size: ofSize!)!
    }
    
    class func avenirRegular(_ ofSize: CGFloat? = 15.0) -> UIFont {
        return UIFont(name: "Avenir-Book", size: ofSize!)!
    }
    
    class func avenirMedium(_ ofSize: CGFloat? = 15.0) -> UIFont {
        return UIFont(name: "Avenir-Medium", size: ofSize!)!
    }
    
    class func avenirHeavy(_ ofSize: CGFloat? = 15.0) -> UIFont {
        return UIFont(name: "Avenir-Heavy", size: ofSize!)!
    }
    
    class func avenirBlack(_ ofSize: CGFloat? = 15.0) -> UIFont {
        return UIFont(name: "Avenir-Black", size: ofSize!)!
    }
}

extension HandyJSON {
    static func create(json: JSON) -> HandyJSON? {
        guard let jsonString = json.rawString(),
            let object = Self.deserialize(from: jsonString.replacingOccurrences(of: "description", with: "desc"))
            else {return nil}
        
        return object
    }
}

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

