//
//  WebViewController.swift
//  LiveOnChallenge
//
//  Created by Pedro Albuquerque on 11/11/19.
//

import UIKit
import SnapKit

class WebViewController: ModuleController {
    
    let manager = WebViewManager()
    
    lazy var web: WebViewComponent = {
        let web = WebViewComponent()
        web.translatesAutoresizingMaskIntoConstraints = false
        return web
    }()
    
    override func viewDidLoad() {
        self.title = manager.pullRequest?.title
        super.viewDidLoad()
        
        self.loadComponents()
    }
    
    func loadComponents(){
        self.clearComponents()
        
        guard let link = manager.pullRequest?.html_url else {return}
        self.view.addSubview(web)
        web.set(urlString: link)
        web.snp.makeConstraints { (obj) in
            obj.top.equalTo(self.view.snp.topMargin)
            obj.bottom.equalTo(self.view.snp.bottom)
            obj.left.equalTo(self.view.snp.left)
            obj.right.equalTo(self.view.snp.right)
        }
    }
}
