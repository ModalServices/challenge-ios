//
//  PullRequestModel.swift
//  LiveOnChallenge
//
//  Created by Pedro Albuquerque on 10/11/19.
//

import Foundation
import HandyJSON

class PullRequestModel: HandyJSON {
    
    var id: Int = 0
    var title: String?
    var body: String?
    var url: String?
    var created_at: String?
    var user: OwnerModel?
    
    required init() {}
}
