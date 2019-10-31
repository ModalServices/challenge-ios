//
//  Repository.swift
//  LosGit
//
//  Created by Marco Tullio Braga Filho on 30/10/19.
//  Copyright © 2019 Marco Tullio Braga Filho. All rights reserved.
//

import Foundation
import ObjectMapper

class Repository: Mappable {
    
    var name: String?
    var description: String?
    var owner: RepositoryOwner?
    var forksCount: Int?
    var starsCount: Int?
    
    required init?(map: Map) {
    }
    
    init(entity: RepositoryEntityMO) {
        name = entity.name
        description = entity.observations
        owner = RepositoryOwner(name: entity.ownerName, photoUrl: entity.ownerPhotoUrl)
        forksCount = Int(entity.forksCount)
        starsCount = Int(entity.starsCount)
    }
    
    func mapping(map: Map) {
        name <- map["name"]
        description <- map["description"]
        owner <- map["owner"]
        forksCount <- map["forks_count"]
        starsCount <- map["stargazers_count"]
    }
    
}
