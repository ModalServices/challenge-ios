//
//  RepositoryDAO.swift
//  LiveOnChallenge
//
//  Created by Pedro Albuquerque on 10/11/19.
//

import Foundation
import RealmSwift
import SwiftyJSON
import HandyJSON

// swiftlint:disable force_try
class DAOManager {
    
    static func save<T>(type: T.Type, obj: [Object]) where T:Object {
        let realm = RealmManager.getRealm()
        try! realm.write {
            obj.forEach {
                realm.add($0, update: Realm.UpdatePolicy.all)
            }
        }
    }

    static func get<T>(type: T.Type) -> [Object]? where T:Object {
        return Array(RealmManager.getRealm().objects(type.self))
    }
    
    static func clear<T>(type: T.Type) where T:Object {
        guard let objs = get(type: type.self) else {return}
        let realm = RealmManager.getRealm()
        try! realm.write {
            objs.forEach {
                realm.delete($0)
            }
        }
    }
}


