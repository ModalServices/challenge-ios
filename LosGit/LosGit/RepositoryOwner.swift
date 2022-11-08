//
//  RepositoryOwner.swift
//  LosGit
//
//  Created by Marco Tullio Braga Filho on 30/10/19.
//  Copyright © 2019 Marco Tullio Braga Filho. All rights reserved.
//

import Foundation
import ObjectMapper

class RepositoryOwner: Mappable {
    
    var name: String?
    var photoUrl: String?
    
    required init?(map: Map) {
    }
    
    init(name: String?, photoUrl: String?) {
        self.name = name
        self.photoUrl = photoUrl
    }
    
    func mapping(map: Map) {
        name <- map["login"]
        photoUrl <- map["avatar_url"]
    }
    
}
