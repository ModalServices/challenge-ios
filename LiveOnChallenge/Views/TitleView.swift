//
//  TitleView.swift
//  LiveOnChallenge
//
//  Created by Pedro Albuquerque on 11/11/19.
//

import UIKit

class TitleView: UIView {
    
    lazy var title: UILabel = {
        let title = UILabel(frame: .zero)
        title.translatesAutoresizingMaskIntoConstraints = false
        title.font = .avenirBlack(20)
        title.textColor = UIColor.firstColor
        title.textAlignment = .left
        title.numberOfLines = 0
        return title
    }()
    
    init(title: String?) {
        super.init(frame: CGRect.zero)
        
        self.title.text = title
        self.loadSubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func loadSubViews(){
        
        self.addSubview(title)
        title.topAnchor.constraint(equalTo: self.topAnchor, constant: 16).isActive = true
        title.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        title.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
        title.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5).isActive = true
    }
}

