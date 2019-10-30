//
//  PullRequestAuthor.swift
//  LosGit
//
//  Created by Marco Tullio Braga Filho on 30/10/19.
//  Copyright © 2019 Marco Tullio Braga Filho. All rights reserved.
//

import Foundation
import ObjectMapper

class PullRequestAuthor: Mappable {
    
    var name: String?
    var photoUrl: String?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        name <- map["login"]
        photoUrl <- map["avatar_url"]
    }
    
}
