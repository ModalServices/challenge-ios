//
//  PullViewComponent.swift
//  LiveOnChallenge
//
//  Created by Pedro Albuquerque on 10/11/19.
//

import UIKit
import SnapKit

protocol PullViewDelegate: class {
    func selected(pr: PullRequestModel)
}

class PullViewComponent: UIView {
    
    weak var delegate: PullViewDelegate?
    var pr: PullRequestModel?
    
    lazy var container: UIView = {
        let vw = UIView(frame: .zero)
        vw.translatesAutoresizingMaskIntoConstraints = false
        vw.backgroundColor = .white
        vw.layer.shadowColor = UIColor.shadowColor.cgColor
        vw.layer.shadowOpacity = 1
        vw.layer.cornerRadius = 4
        vw.layer.shadowOffset = CGSize(width: 0, height: 0)
        return vw
    }()
    
    lazy var title: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .avenirBlack(17)
        label.textColor = UIColor.firstColor
        return label
    }()
    
    lazy var subTitle: UILabel = {
        var text = UILabel(frame: .zero)
        text.translatesAutoresizingMaskIntoConstraints = false
        text.font = .avenirMedium(13)
        text.textAlignment = .left
        text.numberOfLines = 0
        text.textColor = .detailsColor
        return text
    }()
    
    lazy var userView: UserView = {
        var obj = UserView()
        obj.translatesAutoresizingMaskIntoConstraints = false
        return obj
    }()
    
    lazy var date: UILabel = {
        var text = UILabel(frame: .zero)
        text.translatesAutoresizingMaskIntoConstraints = false
        text.font = .avenirHeavy(12)
        text.textAlignment = .right
        text.numberOfLines = 1
        text.textColor = .detailsColor
        return text
    }()
    
    lazy var arrow: UIImageView = {
        let obj = UIImageView(frame: .zero)
        obj.translatesAutoresizingMaskIntoConstraints = false
        obj.contentMode = .scaleAspectFit
        obj.clipsToBounds = true
        obj.image = #imageLiteral(resourceName: "arrowIcon")
        return obj
    }()
    
    init(pr: PullRequestModel) {
        super.init(frame: CGRect.zero)
        
        self.backgroundColor = .clear
        
        self.loadSubViews()
        self.title.text = pr.title
        self.subTitle.text = pr.body
        self.userView.set(pictureUrl: pr.user?.avatar_url, name: pr.user?.login)
        self.date.text = pr.created_at?.toDateAll()?.ddMMyyyyHHmm
        
        self.pr = pr
        
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:))))
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        guard let pr = pr else {return}
        delegate?.selected(pr: pr)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func loadSubViews(){
        
        self.addSubview(container)
        container.snp.makeConstraints { (obj) in
            obj.top.equalTo(self.snp.top).offset(14)
            obj.left.equalTo(self.snp.left).offset(20)
            obj.right.equalTo(self.snp.right).offset(-20)
            obj.bottom.equalTo(self.snp.bottom).offset(-4)
        }
        
        container.addSubview(arrow)
        arrow.snp.makeConstraints { (obj) in
            obj.centerY.equalTo(container.snp.centerY)
            obj.right.equalTo(container.snp.right).offset(-12)
            obj.height.equalTo(10)
            obj.width.equalTo(10)
        }
        
        container.addSubview(title)
        title.snp.makeConstraints { (obj) in
            obj.top.equalTo(container.snp.top).offset(14)
            obj.left.equalTo(container.snp.left).offset(14)
            obj.right.equalTo(arrow.snp.left).offset(-6)
            obj.height.equalTo(22)
        }
        
        container.addSubview(subTitle)
        subTitle.snp.makeConstraints { (obj) in
            obj.top.equalTo(title.snp.bottom).offset(3)
            obj.left.equalTo(container.snp.left).offset(14)
            obj.right.equalTo(arrow.snp.left).offset(-6)
        }
        
        container.addSubview(date)
        date.snp.makeConstraints { (obj) in
            obj.height.equalTo(16)
            obj.top.equalTo(subTitle.snp.bottom).offset(10)
            obj.bottom.equalTo(container.snp.bottom).offset(-10)
            obj.right.equalTo(container.snp.right).offset(-14)
        }
        
        container.addSubview(userView)
        userView.snp.makeConstraints { (obj) in
            obj.top.equalTo(subTitle.snp.bottom).offset(10)
            obj.bottom.equalTo(container.snp.bottom).offset(-10)
            obj.left.equalTo(container.snp.left).offset(14)
            obj.right.equalTo(container.snp.right).offset(-14)
        }
    
    }
}


