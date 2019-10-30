//
//  RepositoryResponse.swift
//  LosGit
//
//  Created by Marco Tullio Braga Filho on 30/10/19.
//  Copyright © 2019 Marco Tullio Braga Filho. All rights reserved.
//

import Foundation
import ObjectMapper

class RepositoryResponse: Mappable {
    
    var totalCount: Int?
    var items: [Repository]?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        totalCount <- map["total_count"]
        items <- map["items"]
    }
    
}
