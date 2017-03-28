//
//  DataService.swift
//  SocialNetwork
//
//  Created by spencerdezartsmith on 3/27/17.
//  Copyright © 2017 spencerdezartsmith. All rights reserved.
//

import Foundation
import Firebase

let DB_BASE = FIRDatabase.database().reference()
let STORAGE_BASE = FIRStorage.storage().reference()

class DataService {
  
    static let ds = DataService()
    
    // DB references
    private var _REF_POSTS = DB_BASE.child("posts")
    private var _REF_USERS = DB_BASE.child("users")
    
    // Storage references
    private var _REF_IMAGES = STORAGE_BASE.child("post-pics")
    
    var REF_POSTS: FIRDatabaseReference {
        return _REF_POSTS
    }
    
    var REF_USERS: FIRDatabaseReference {
        return _REF_USERS
    }
    
    var REF_IMAGES: FIRStorageReference {
        return _REF_IMAGES
    }
    
    func createFirebaseDBUser(uid: String, userData: Dictionary<String, String>) {
       REF_USERS.child(uid).updateChildValues(userData)
    }
    
    
}
