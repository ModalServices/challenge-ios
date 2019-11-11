//
//  PullsViewModel.swift
//  LiveOnChallenge
//
//  Created by Pedro Albuquerque on 10/11/19.
//

import UIKit

class PullsManager {
    
    var repo: RepositoryModel?
    var prs = [PullRequestModel]()
    
    func set(repo: RepositoryModel){
        self.repo = repo
    }
    
    func getPulls(completion: @escaping ([PullRequestModel]) -> Void, error: @escaping (String) -> Void = { (error) in }){
        guard let ownerName = repo?.owner?.login, let repoName = repo?.name else {return}
        let route = RouterManager(router: ReposRouter.getPulls(owner: ownerName, repo: repoName))
        APIManager.sharedInstance.request(route: route) { (json) in
            let status = json["statusCode"].intValue
            guard status == 200, let results = json["resultValue"].array else {
                if !HelperDevice.checkConnection(), let saved = (DAOManager.get(type: PullRequestModel.self) as? [PullRequestModel])?.filter({$0.repo?.id == self.repo?.id}), saved.count > 0 {
                    self.prs = saved
                    completion(saved)
                }else{
                    error(json["statusMessage"].string ?? APIManager.errorStandard)
                }
                return
            }
            
            results.forEach { result in
                if let pr = PullRequestModel.create(json: result) as? PullRequestModel {
                    if !(self.prs.filter{$0.id == pr.id}.count > 0) {
                        self.prs.append(pr)
                    }
                }
            }
            
            DAOManager.save(type: PullRequestModel.self, obj: self.prs)
            completion(self.prs)
        }
    }
}

