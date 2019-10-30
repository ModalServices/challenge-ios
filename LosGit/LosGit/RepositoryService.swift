//
//  RepositoryService.swift
//  LosGit
//
//  Created by Marco Tullio Braga Filho on 30/10/19.
//  Copyright © 2019 Marco Tullio Braga Filho. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

class RepositoryService {
    
    weak var controller: RepositoryController?
    
    init(controller: RepositoryController) {
        self.controller = controller
    }
    
    func loadPage() -> Void {
        let pageNumber = controller?.currentPage ?? 1
        let pageUrl = "https://api.github.com/search/repositories?q=language:Swift&sort=stars&page=\(pageNumber)"
        
        Alamofire.request(pageUrl).responseObject { (response: DataResponse<RepositoryResponse>) in
            guard let items = response.value?.items, items.count > 0 else {
                return
            }
            
            self.controller?.updateContent(items)
        }
    }
    
}
