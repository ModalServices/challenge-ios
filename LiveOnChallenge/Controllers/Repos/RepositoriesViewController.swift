//
//  ViewController.swift
//  LiveOnChallenge
//
//  Created by Pedro Albuquerque on 09/11/19.
//

import UIKit

class RepositoriesViewController: ModuleController {

    let viewModel = RepositoriesViewModel.shareInstance
    
    override func viewDidLoad() {
        self.title = "Repositories"
        super.viewDidLoad()
        
        self.loadAPIData()
    }
    
    override func loadMore() {
        viewModel.page += 1
        viewModel.getRepos(page: viewModel.page, completion: { (repos) in
            self.loadComponents(repos: repos)
        })
            
    }

    func loadComponents(repos: [RepositoryModel]){
        
        self.view.backgroundColor = .backgroundColor
        
        viewModel.repos.forEach{
            self.addComponent(view: RepoViewComponent(repo: $0))
        }
    }
    
    func loadAPIData(){
        self.showLoadingComponent()
        viewModel.getRepos(page: viewModel.page, completion: { (repos) in
            self.endLoadingComponent()
            self.loadComponents(repos: self.viewModel.repos)
        }) { (error) in
            self.endLoadingComponent()
            print(error)
        }
    }

}

