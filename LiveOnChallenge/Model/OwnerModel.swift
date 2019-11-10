//
//  OwnerModel.swift
//  LiveOnChallenge
//
//  Created by Pedro Albuquerque on 10/11/19.
//

import Foundation
import HandyJSON

class OwnerModel: HandyJSON {
    
    var id: Int = 0
    var login: String?
    var avatar_url: String?
    
    required init() {}
}
