//
//  RepositoryModel.swift
//  LiveOnChallenge
//
//  Created by Pedro Albuquerque on 10/11/19.
//

import Foundation
import HandyJSON
import RealmSwift

class RepositoryModel: Object, HandyJSON {
    
    @objc dynamic var id: String?
    @objc dynamic var name: String?
    @objc dynamic var desc: String?
    @objc dynamic var stargazers_count: Int = 0
    @objc dynamic var forks_count: Int = 0
    @objc dynamic var owner: OwnerModel?
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
