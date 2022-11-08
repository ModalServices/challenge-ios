//
//  WebViewComponent.swift
//  LiveOnChallenge
//
//  Created by Pedro Albuquerque on 11/11/19.
//

import UIKit

class WebViewComponent: UIView {
    
    var urlToPreview: URL?
    
    lazy var web: UIWebView = {
        let btn = UIWebView(frame: .zero)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    init() {
        super.init(frame: CGRect.zero)
    }
    
    init(urlString: String) {
        super.init(frame: CGRect.zero)
        
        self.urlToPreview = URL(string: urlString)
        self.loadSubViews()
    }
    
    func set(urlString: String) {
        
        self.urlToPreview = URL(string: urlString)
        self.loadSubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func loadSubViews(){
        
        self.addSubview(web)
        web.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        web.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        //        web.heightAnchor.constraint(equalToConstant: height).isActive = true
        web.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        web.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        self.loadWebView()
    }
    
    func loadWebView() {
        guard let urlPreview = urlToPreview else {return}
        web.loadRequest(URLRequest(url: urlPreview))
        web.scalesPageToFit = true
    }
}





