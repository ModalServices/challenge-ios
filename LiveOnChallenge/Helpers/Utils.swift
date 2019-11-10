//
//  Utils.swift
//  LiveOnChallenge
//
//  Created by Pedro Albuquerque on 09/11/19.
//

import UIKit
import HandyJSON
import SwiftyJSON

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
            let object = Self.deserialize(from: jsonString)
            else {return nil}
        
        return object
    }
}
