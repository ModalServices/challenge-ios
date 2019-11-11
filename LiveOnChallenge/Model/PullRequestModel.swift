//
//  PullRequestModel.swift
//  LiveOnChallenge
//
//  Created by Pedro Albuquerque on 10/11/19.
//

import Foundation
import HandyJSON
import RealmSwift

class PullRequestModel: Object, HandyJSON {
    
    @objc dynamic var id: Int = 0
    @objc dynamic var title: String?
    @objc dynamic var body: String?
    @objc dynamic var html_url: String?
    @objc dynamic var created_at: String?
    @objc dynamic var user: OwnerModel?
    @objc dynamic var repo: RepositoryModel?
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
