//
//  PullRequestResponse.swift
//  LosGit
//
//  Created by Marco Tullio Braga Filho on 30/10/19.
//  Copyright © 2019 Marco Tullio Braga Filho. All rights reserved.
//

import Foundation
import ObjectMapper

class PullRequest: Mappable {
    
    var url: String?
    var author: PullRequestAuthor?
    var title: String?
    var creationDate: Date?
    var updateDate: Date?
    var body: String?
    
    required init?(map: Map) {
    }
    
    init(entity: PullRequestEntityMO) {
        url = entity.url
        author = PullRequestAuthor(name: entity.authorName, photoUrl: entity.authorPhotoUrl)
        title = entity.title
        creationDate = entity.creationDate
        updateDate = entity.updateDate
        body = entity.body
    }
    
    func mapping(map: Map) {
        url <- map["html_url"]
        author <- map["user"]
        title <- map["title"]
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        creationDate <- (map["created_at"], DateFormatterTransform(dateFormatter: formatter))
        updateDate <- (map["updated_at"], DateFormatterTransform(dateFormatter: formatter))
        
        body <- map["body"]
    }
    
}
