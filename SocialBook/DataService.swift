//
//  DataService.swift
//  SocialBook
//
//  Created by AKIL KUMAR THOTA on 1/5/17.
//  Copyright © 2017 AKIL KUMAR THOTA. All rights reserved.
//

import Foundation
import Firebase

let DB_Base = FIRDatabase.database().reference()

class DataService {
    
    static let ds = DataService()
    
    private var _Ref_User = DB_Base.child("user")
    private var _Red_Post = DB_Base.child("post")
    
    var ref_user: FIRDatabaseReference {
        return _Ref_User
    }
    
    var ref_post: FIRDatabaseReference {
        return _Red_Post
    }
    
    func createFirebaseDbUser(uid: String, userData:Dictionary<String, String>) {
        ref_user.child(uid).updateChildValues(userData)
    }
}
