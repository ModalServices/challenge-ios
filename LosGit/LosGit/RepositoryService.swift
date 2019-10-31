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
import CoreData

class RepositoryService {
    
    weak var controller: RepositoryController?
    
    init(controller: RepositoryController) {
        self.controller = controller
    }
    
    func loadPage() -> Void {
        if NetworkReachabilityManager()?.isReachable ?? false {
            loadPageFromInternet()
        } else {
            loadPageFromDisk()
        }
    }
    
    func loadPageFromInternet() -> Void {
        let pageNumber = controller?.currentPage ?? 1
        let pageUrl = "https://api.github.com/search/repositories?q=language:Swift&sort=stars&page=\(pageNumber)"
        
        Alamofire.request(pageUrl).responseObject { (response: DataResponse<RepositoryResponse>) in
            guard let items = response.value?.items, items.count > 0 else {
                return
            }
            
            DispatchQueue.main.async {
                let delegate = UIApplication.shared.delegate as! AppDelegate
                let context = delegate.persistentContainer.newBackgroundContext()
                
                DispatchQueue.global(qos: .background).async {
                    let request = NSFetchRequest<RepositoryEntityMO>(entityName: "RepositoryEntity")
                    let predicate = NSPredicate(format: "page == %@", argumentArray: [Int32(pageNumber)])
                    
                    request.predicate = predicate
                    
                    if let results = try? context.fetch(request), results.count > 0 {
                        for result in results {
                            context.delete(result)
                        }
                    }
                    
                    for item in items {
                        let repository = NSEntityDescription.insertNewObject(forEntityName: "RepositoryEntity", into: context) as! RepositoryEntityMO
                        repository.page = Int32(pageNumber)
                        
                        repository.name = item.name
                        repository.observations = item.description
                        
                        repository.ownerName = item.owner?.name
                        repository.ownerPhotoUrl = item.owner?.photoUrl
                        
                        repository.forksCount = Int32(item.forksCount ?? 0)
                        repository.starsCount = Int32(item.starsCount ?? 0)
                    }
                    
                    if context.hasChanges {
                        try? context.save()
                    }
                }
            }
            
            self.controller?.updateContent(items)
        }
    }
    
    func loadPageFromDisk() -> Void {
        let pageNumber = controller?.currentPage ?? 1
        
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let context = delegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<RepositoryEntityMO>(entityName: "RepositoryEntity")
        let predicate = NSPredicate(format: "page == %@", argumentArray: [Int32(pageNumber)])
        
        request.predicate = predicate
        
        if let results = try? context.fetch(request) {
            controller?.updateContent(results.map { Repository(entity: $0) })
        }
    }
    
}
