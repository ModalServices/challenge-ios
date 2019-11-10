//
//  UserView.swift
//  LiveOnChallenge
//
//  Created by Pedro Albuquerque on 10/11/19.
//

import UIKit
import SnapKit
import AlamofireImage

class UserView: UIView {
    
    private var height = 16
    
    lazy var name: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .avenirHeavy(12)
        label.textColor = UIColor.detailsColor
        return label
    }()
    
    lazy var picture: UIImageView = {
        let obj = UIImageView(frame: .zero)
        obj.translatesAutoresizingMaskIntoConstraints = false
        obj.contentMode = .scaleAspectFit
        obj.clipsToBounds = true
        obj.layer.cornerRadius = CGFloat(height/2)
        return obj
    }()
    
    init() {
        super.init(frame: CGRect.zero)
        
        self.backgroundColor = .clear
        self.loadSubViews()
    }
    
    func set(pictureUrl: String?, name: String?) {
        self.name.text = name
        guard let urlImage = URL(string: pictureUrl ?? "") else {return}
        self.picture.af_setImage(withURL: urlImage)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadSubViews() {
        
        self.snp.makeConstraints { (obj) in
            obj.height.equalTo(height)
        }
        
        self.addSubview(picture)
        picture.snp.makeConstraints { (obj) in
            obj.left.equalTo(self.snp.left)
            obj.centerY.equalTo(self.snp.centerY)
            obj.height.equalTo(height)
            obj.width.equalTo(height)
        }
        
        self.addSubview(name)
        name.snp.makeConstraints { (obj) in
            obj.left.equalTo(picture.snp.right).offset(4)
            obj.right.equalTo(self.snp.right).offset(-6)
            obj.centerY.equalTo(self.snp.centerY)
            obj.height.equalTo(height)
        }
    }
}

