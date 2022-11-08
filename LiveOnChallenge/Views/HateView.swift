//
//  HateView.swift
//  LiveOnChallenge
//
//  Created by Pedro Albuquerque on 10/11/19.
//

import UIKit
import SnapKit

class HateView: UIView {
    
    private var height = 16
    
    lazy var container: UIView = {
        let vw = UIView(frame: .zero)
        vw.translatesAutoresizingMaskIntoConstraints = false
        vw.backgroundColor = .firstColor
        vw.layer.cornerRadius = CGFloat(height/2)
        vw.clipsToBounds = true
        return vw
    }()
    
    lazy var hate: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .avenirHeavy(12)
        label.textColor = UIColor.firstColor
        return label
    }()
    
    lazy var icon: UIImageView = {
        let obj = UIImageView(frame: .zero)
        obj.translatesAutoresizingMaskIntoConstraints = false
        obj.contentMode = .scaleAspectFit
        obj.clipsToBounds = true
        return obj
    }()
    
    init() {
        super.init(frame: CGRect.zero)
        
        self.backgroundColor = .firstColorLight
        self.loadSubViews()
    }
    
    func set(icon: UIImage, hate: Int?) {
        self.hate.text = "\(hate ?? 0)"
        self.icon.image = icon
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadSubViews() {
        
        self.layer.cornerRadius = CGFloat(height/2)
        
        self.snp.makeConstraints { (obj) in
            obj.height.equalTo(height)
        }
        
        self.addSubview(container)
        container.snp.makeConstraints { (obj) in
            obj.left.equalTo(self.snp.left)
            obj.centerY.equalTo(self.snp.centerY)
            obj.height.equalTo(height)
            obj.width.equalTo(height)
        }
        
        container.addSubview(icon)
        icon.snp.makeConstraints { (obj) in
            obj.left.equalTo(container.snp.left).offset(2)
            obj.right.equalTo(container.snp.right).offset(-2)
            obj.top.equalTo(container.snp.top).offset(2)
            obj.bottom.equalTo(container.snp.bottom).offset(-2)
        }
        
        self.addSubview(hate)
        hate.snp.makeConstraints { (obj) in
            obj.left.equalTo(container.snp.right).offset(4)
            obj.right.equalTo(self.snp.right).offset(-6)
            obj.centerY.equalTo(self.snp.centerY)
            obj.height.equalTo(height)
        }
    }
}
