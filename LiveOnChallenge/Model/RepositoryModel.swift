//
//  RepositoryModel.swift
//  LiveOnChallenge
//
//  Created by Pedro Albuquerque on 10/11/19.
//

import Foundation
import HandyJSON

class RepositoryModel: HandyJSON {
    
    var id: Int = 0
    var name: String?
    var description: String?
    var stargazers_count: Int?
    var forks_count: Int?
    
    var owner: OwnerModel?
    
    required init() {}
}
