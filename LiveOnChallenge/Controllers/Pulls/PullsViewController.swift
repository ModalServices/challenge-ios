//
//  PullsViewController.swift
//  LiveOnChallenge
//
//  Created by Pedro Albuquerque on 10/11/19.
//

import UIKit

class PullsViewController: ModuleController {
    
    let manager = PullsManager()
    
    override func viewDidLoad() {
        self.title = "Pull Requests"
        super.viewDidLoad()
        
        self.addRefresh()
        self.loadData()
    }
    
    func loadComponents(){
        
        self.view.backgroundColor = .backgroundColor
        manager.prs.forEach{
            self.addComponent(view: PullViewComponent(pr: $0))
        }
    }
    
    override func loadData(){
        super.loadData()
        self.showLoadingComponent()
        manager.getPulls(completion: { (prs) in
            self.endLoadingComponent()
            if prs.count > 0 {
                self.loadComponents()
            }else{
                self.showEmptyComponent()
            }
        }) { (error) in
            self.endLoadingComponent()
            self.showEmptyComponent(title: "Ops, algo deu errado!", desc: error)
        }
    }
    
}


