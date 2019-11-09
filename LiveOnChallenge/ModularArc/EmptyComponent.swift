//
//  EmptyComponent.swift
//  LiveOnChallenge
//
//  Created by Pedro Albuquerque on 09/11/19.
//

import UIKit

class EmptyComponent: UIView {
    
    lazy var icon: UIImageView = {
        let obj = UIImageView(frame: .zero)
        obj.translatesAutoresizingMaskIntoConstraints = false
        obj.contentMode = .scaleAspectFit
        return obj
    }()
    
    lazy var title: UILabel = {
        let title = UILabel(frame: .zero)
        title.translatesAutoresizingMaskIntoConstraints = false
        title.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        title.textColor = .secondaryColor
        title.textAlignment = .center
        return title
    }()
    
    lazy var desc: UILabel = {
        let title = UILabel(frame: .zero)
        title.translatesAutoresizingMaskIntoConstraints = false
        title.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        title.textColor = .secondaryColor
        title.textAlignment = .center
        title.numberOfLines = 0
        return title
    }()
    
    init(icon: UIImage, title: String, description: String) {
        super.init(frame: CGRect.zero)
        
        self.loadSubViews()
        self.icon.image = icon
        self.title.text = title
        self.desc.text = description
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func loadSubViews(){
        self.heightAnchor.constraint(equalToConstant: ScreenSize.height).isActive = true
        
        self.addSubview(icon)
        icon.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -100).isActive = true
        icon.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        icon.heightAnchor.constraint(equalToConstant: 100).isActive = true
        icon.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        self.addSubview(title)
        title.topAnchor.constraint(equalTo: icon.bottomAnchor, constant: 10).isActive = true
        title.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16).isActive = true
        title.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16).isActive = true
        title.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        self.addSubview(desc)
        desc.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 8).isActive = true
        desc.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16).isActive = true
        desc.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16).isActive = true
    }
}

