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
        self.title = manager.repo?.name
        super.viewDidLoad()
        
        self.addRefresh()
        self.loadData()
    }
    
    func loadComponents(){
        
        self.view.backgroundColor = .backgroundColor
        self.addComponent(view: TitleView(title: "Pull Requests"))
        manager.prs.forEach{
            let prComponent = PullViewComponent(pr: $0)
            self.addComponent(view: prComponent)
            prComponent.delegate = self
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

extension PullsViewController: PullViewDelegate {
    func selected(pr: PullRequestModel) {
        let vc = WebViewController()
        vc.manager.set(pr: pr)
        self.navigationController?.show(vc, sender: nil)
    }
}


