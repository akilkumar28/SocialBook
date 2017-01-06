//
//  DataService.swift
//  SocialBook
//
//  Created by AKIL KUMAR THOTA on 1/5/17.
//  Copyright © 2017 AKIL KUMAR THOTA. All rights reserved.
//

import Foundation
import Firebase
import SwiftKeychainWrapper

let DB_Base = FIRDatabase.database().reference()
let Storeage_Base = FIRStorage.storage().reference()

class DataService {
    
    static let ds = DataService()
    
    private var _Ref_User = DB_Base.child("user")
    private var _Red_Post = DB_Base.child("post")
    private var _Ref_Storage_PostPics = Storeage_Base.child("post-pics")
    
    var ref_user: FIRDatabaseReference {
        return _Ref_User
    }
    
    var ref_post: FIRDatabaseReference {
        return _Red_Post
    }
    
    var ref_storage_postpics: FIRStorageReference {
        return _Ref_Storage_PostPics
    }
    
    var Ref_Current_User : FIRDatabaseReference {
        let uid = KeychainWrapper.standard.string(forKey: "uid")
        let user = ref_user.child(uid!)
        return user
    }
    
    func createFirebaseDbUser(uid: String, userData:Dictionary<String, String>) {
        ref_user.child(uid).updateChildValues(userData)
    }
}
