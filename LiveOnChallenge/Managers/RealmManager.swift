//
//  RealmManager.swift
//  LiveOnChallenge
//
//  Created by Pedro Albuquerque on 10/11/19.
//

import UIKit
import RealmSwift
import Disk

class RealmManager: NSObject {
    
    static let sharedInstance = RealmManager()
    
    static let group = "group.br.com.liveonchallenge"
    static let indentifier = "group.br.com.liveonchallenge"
    
    class func getRealm() -> Realm {
        let dest = "default.realm"
        let fileManager = FileManager.default
        let containerURL = fileManager.containerURL(forSecurityApplicationGroupIdentifier: group)
        let fileURL = containerURL!.appendingPathComponent(dest)
        var configuration = Realm.Configuration(fileURL: fileURL, encryptionKey: getKey() as Data)
        configuration.schemaVersion = 5
        configuration.migrationBlock = { _, _ in }
        
        do {
            let realm = try Realm(configuration: configuration)
            securityRem(dest, directory: .sharedContainer(appGroupName: group))
            return realm
        } catch _ as NSError {
            // use the error object such as error.localizedDescription
            try! FileManager.default.removeItem(at: configuration.fileURL!)
            let realm = try! Realm(configuration: configuration)
            securityRem(dest, directory: .sharedContainer(appGroupName: group))
            return realm
        }
    }
    
    fileprivate class func securityRem(_ path: String, directory: Disk.Directory) {
        do {
            try Disk.doNotBackup(path, in: directory)
        } catch let erro as NSError {
            debugPrint(erro.localizedDescription)
        }
    }
    
    fileprivate class func getKey() -> NSData {
        // Identifier for our keychain entry - should be unique for your application
        let keychainIdentifier = indentifier
        let keychainIdentifierData = keychainIdentifier.data(using: String.Encoding.utf8, allowLossyConversion: false)!
        
        // First check in the keychain for an existing key
        var query: [NSString: AnyObject] = [
            kSecClass: kSecClassKey,
            kSecAttrApplicationTag: keychainIdentifierData as AnyObject,
            kSecAttrKeySizeInBits: 512 as AnyObject,
            kSecReturnData: true as AnyObject
        ]
        
        // To avoid Swift optimization bug, should use withUnsafeMutablePointer() function to retrieve the keychain item
        // See also: http://stackoverflow.com/questions/24145838/querying-ios-keychain-using-swift/27721328#27721328
        var dataTypeRef: AnyObject?
        var status = withUnsafeMutablePointer(to: &dataTypeRef) { SecItemCopyMatching(query as CFDictionary, UnsafeMutablePointer($0)) }
        if status == errSecSuccess {
            return dataTypeRef as! NSData
        }
        
        // No pre-existing key from this application, so generate a new one
        let keyData = NSMutableData(length: 64)!
        let result = SecRandomCopyBytes(kSecRandomDefault, 64, keyData.mutableBytes.bindMemory(to: UInt8.self, capacity: 64))
        assert(result == 0, "Failed to get random bytes")
        
        // Store the key in the keychain
        query = [
            kSecClass: kSecClassKey,
            kSecAttrApplicationTag: keychainIdentifierData as AnyObject,
            kSecAttrKeySizeInBits: 512 as AnyObject,
            kSecValueData: keyData
        ]
        
        status = SecItemAdd(query as CFDictionary, nil)
        assert(status == errSecSuccess, "Failed to insert the new key in the keychain")
        
        return keyData
    }
}


