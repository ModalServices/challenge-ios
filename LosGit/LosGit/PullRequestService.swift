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
import CoreData

class PullRequestService {
    
    weak var controller: PullRequestController?
    
    init(controller: PullRequestController) {
        self.controller = controller
    }
    
    func load() -> Void {
        if NetworkReachabilityManager()?.isReachable ?? false {
            loadFromInternet()
        } else {
            loadFromDisk()
        }
    }
    
    func loadFromInternet() -> Void {
        guard let owner = controller?.ownerName, !owner.isEmpty, let repository = controller?.repositoryName, !repository.isEmpty else {
            return
        }
        
        let url = "https://api.github.com/repos/\(owner)/\(repository)/pulls"
        
        Alamofire.request(url).responseArray { (response: DataResponse<[PullRequest]>) in
            guard let items = response.value, items.count > 0 else {
                return
            }
            
            DispatchQueue.main.async {
                let delegate = UIApplication.shared.delegate as! AppDelegate
                let context = delegate.persistentContainer.newBackgroundContext()
                
                DispatchQueue.global(qos: .background).async {
                    let request = NSFetchRequest<PullRequestEntityMO>(entityName: "PullRequestEntity")
                    let predicate = NSPredicate(format: "name == %@", argumentArray: ["\(owner)_\(repository)"])
                    
                    request.predicate = predicate
                    
                    if let results = try? context.fetch(request), results.count > 0 {
                        for result in results {
                            context.delete(result)
                        }
                    }
                    
                    for item in items {
                        let pullRequest = NSEntityDescription.insertNewObject(forEntityName: "PullRequestEntity", into: context) as! PullRequestEntityMO
                        
                        pullRequest.name = "\(owner)_\(repository)"
                        pullRequest.url = item.url
                        
                        pullRequest.title = item.title
                        pullRequest.body = item.body
                        
                        pullRequest.authorName = item.author?.name
                        pullRequest.authorPhotoUrl = item.author?.photoUrl
                        
                        pullRequest.creationDate = item.creationDate
                        pullRequest.updateDate = item.updateDate
                    }
                    
                    if context.hasChanges {
                        try? context.save()
                    }
                }
            }
            
            self.controller?.updateContent(items)
        }
    }
    
    func loadFromDisk() -> Void {
        guard let owner = controller?.ownerName, !owner.isEmpty, let repository = controller?.repositoryName, !repository.isEmpty else {
            return
        }
        
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let context = delegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<PullRequestEntityMO>(entityName: "PullRequestEntity")
        let predicate = NSPredicate(format: "name == %@", argumentArray: ["\(owner)_\(repository)"])
        
        request.predicate = predicate
        
        if let results = try? context.fetch(request) {
            controller?.updateContent(results.map { PullRequest(entity: $0) })
        }
    }
    
}
