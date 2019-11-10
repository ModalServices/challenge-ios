//
//  RepositoriesViewModel.swift
//  LiveOnChallenge
//
//  Created by Pedro Albuquerque on 10/11/19.
//

import UIKit

class RepositoriesManager {
    
    var page = 1
    var repos = [RepositoryModel]()
    
    func getRepos(page: Int, completion: @escaping ([RepositoryModel]) -> Void, error: @escaping (String) -> Void = { (error) in }){
        let route = RouterManager(router: ReposRouter.getRepos(page: page))
        APIManager.sharedInstance.request(route: route) { (json) in
            let status = json["statusCode"].intValue
            guard status == 200, let results = json["items"].array else {
                error(json["statusMessage"].string ?? APIManager.errorStandard)
                return
            }
            
            var pageRepo = [RepositoryModel]()
            results.forEach { result in
                if let repo = RepositoryModel.create(json: result) as? RepositoryModel {
                    if !(self.repos.filter{$0.id == repo.id}.count > 0) {
                        self.repos.append(repo)
                    }
                    pageRepo.append(repo)
                }
            }
            completion(pageRepo)
        }
    }
}
