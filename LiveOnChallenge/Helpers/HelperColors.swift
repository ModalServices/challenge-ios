//
//  HelperColors.swift
//  LiveOnChallenge
//
//  Created by Pedro Albuquerque on 09/11/19.
//

import UIKit

extension UIColor {
    
    class var firstColor: UIColor {
        return #colorLiteral(red: 0.003921568627, green: 0.4274509804, blue: 0.4784313725, alpha: 1)
    }
    
    class var secondaryLightColor: UIColor {
        return #colorLiteral(red: 0.8745098039, green: 0.9058823529, blue: 0.9607843137, alpha: 1)
    }
    
    class var detailsColor: UIColor {
        return #colorLiteral(red: 0.5411764706, green: 0.5411764706, blue: 0.5411764706, alpha: 1)
    }
    
    class var secondaryColor: UIColor {
        return #colorLiteral(red: 0.4666666667, green: 0.5254901961, blue: 0.6196078431, alpha: 1)
    }
    
    class var facebookBlue: UIColor {
        return #colorLiteral(red: 0.231372549, green: 0.3490196078, blue: 0.6, alpha: 1)
    }
    
    class var lightGray: UIColor {
        return #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.9490196078, alpha: 1)
    }
    
    class var mediumGray: UIColor {
        return #colorLiteral(red: 0.7568627451, green: 0.7568627451, blue: 0.7568627451, alpha: 1)
    }
    
    class var darkGray: UIColor {
        return #colorLiteral(red: 0.5960784314, green: 0.5960784314, blue: 0.5960784314, alpha: 1)
    }
    
    class var darkBoldGray: UIColor {
        return #colorLiteral(red: 0.4039215686, green: 0.4039215686, blue: 0.4039215686, alpha: 1)
    }
    
    class var blackGray: UIColor {
        return #colorLiteral(red: 0.05098039216, green: 0.05098039216, blue: 0.05098039216, alpha: 1)
    }
    
    class var shadowColor: UIColor {
        return #colorLiteral(red: 0.5568627451, green: 0.5568627451, blue: 0.5568627451, alpha: 0.5)
    }
}

class Colors {
    var gl:CAGradientLayer!
    
    init(frame: CGRect) {
        let colorTop = UIColor.secondaryColor.cgColor
        let colorBottom = UIColor.firstColor.cgColor
        
        self.gl = CAGradientLayer()
        self.gl.colors = [colorTop, colorBottom]
        self.gl.locations = [0.0, 1.0]
        self.gl?.frame = frame
    }
    
    func imageFromLayer() -> UIImage? {
        let layer = gl
        UIGraphicsBeginImageContext(layer?.frame.size ?? CGSize(width: 0, height: 0))
        layer?.render(in: UIGraphicsGetCurrentContext()!)
        
        let outputImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext();
        
        return outputImage
    }
}

