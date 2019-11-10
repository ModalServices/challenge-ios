//
//  IconWithTitleView.swift
//  LiveOnChallenge
//
//  Created by Pedro Albuquerque on 10/11/19.
//

import UIKit
import SnapKit

class HateView: UIView {
    
    lazy var container: UIView = {
        let vw = UIView(frame: .zero)
        vw.translatesAutoresizingMaskIntoConstraints = false
        vw.backgroundColor = .firstColorLight
        return vw
    }()
    
    lazy var hate: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        obj.font = .avenirHeavy(12)
        label.textColor = UIColor.firstColor
        return label
    }()
    
    lazy var icon: UIImageView = {
        let obj = UIImageView(frame: .zero)
        obj.translatesAutoresizingMaskIntoConstraints = false
        return obj
    }()
}
