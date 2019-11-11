//
//  ViewController.swift
//  LiveOnChallenge
//
//  Created by Pedro Albuquerque on 09/11/19.
//

import UIKit

class RepositoriesViewController: ModuleController {

    let manager = RepositoriesManager()
    
    override func viewDidLoad() {
        self.title = "Repositories"
        super.viewDidLoad()
        
        self.addRefresh()
        self.loadData()
    }
    
    override func loadMore() {
        if HelperDevice.checkConnection(){
            manager.page += 1
            manager.getRepos(page: manager.page, completion: { (repos) in
                self.loadComponents(repos: repos)
            })
        }
    }

    func loadComponents(repos: [RepositoryModel]){
        
        self.view.backgroundColor = .backgroundColor
        
        repos.forEach{
            let repoComponent = RepoViewComponent(repo: $0)
            self.addComponent(view: repoComponent)
            repoComponent.delegate = self
        }
    }
    
    override func loadData(){
        super.loadData()
        self.showLoadingComponent()
        manager.getRepos(page: manager.page, completion: { (repos) in
            self.endLoadingComponent()
            if self.manager.repos.count > 0 {
                self.loadComponents(repos: self.manager.repos)
            }else{
                self.showEmptyComponent()
            }
        }) { (error) in
            self.endLoadingComponent()
            self.showEmptyComponent(title: "Ops, algo deu errado!", desc: error)
        }
    }
}

extension RepositoriesViewController: RepoViewDelegate {
    func selected(repo: RepositoryModel) {
        let vc = PullsViewController()
        vc.manager.set(repo: repo)
        self.navigationController?.show(vc, sender: nil)
    }
}

