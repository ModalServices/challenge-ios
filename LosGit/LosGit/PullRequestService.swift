//
//  PullRequestService.swift
//  LosGit
//
//  Created by Marco Tullio Braga Filho on 30/10/19.
//  Copyright © 2019 Marco Tullio Braga Filho. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

class PullRequestService {
    
    weak var controller: PullRequestController?
    
    init(controller: PullRequestController) {
        self.controller = controller
    }
    
    func load() -> Void {
        guard let owner = controller?.ownerName, !owner.isEmpty, let repository = controller?.repositoryName, !repository.isEmpty else {
            return
        }
        
        let url = "https://api.github.com/repos/\(owner)/\(repository)/pulls"
        
        Alamofire.request(url).responseArray { (response: DataResponse<[PullRequest]>) in
            guard let items = response.value, items.count > 0 else {
                return
            }
            
            self.controller?.updateContent(items)
        }
    }
    
}
