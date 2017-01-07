//
//  Post.swift
//  SocialBook
//
//  Created by AKIL KUMAR THOTA on 1/6/17.
//  Copyright © 2017 AKIL KUMAR THOTA. All rights reserved.
//

import Foundation
import Firebase

class Post {
    
    private var _caption: String!
    private var _img_Url: String!
    private var _likes: Int!
    private var _postkey: String!
    private var _postRef: FIRDatabaseReference!
    
    var caption: String {
        return _caption
    }
    
    var img_Url: String {
        return _img_Url
    }
    
    var likes: Int {
        return _likes
    }
    
    var postkey: String {
        return _postkey
    }
    
    init(caption: String, img_url: String, likes: Int) {
        self._caption = caption
        self._img_Url = img_url
        self._likes = likes
    }
    
    init(postkey: String, postdata: Dictionary<String,AnyObject>) {
        self._postkey = postkey
        
        if let caption = postdata["caption"] as? String {
            self._caption = caption
        }
        if let imageUrl = postdata["imageUrl"] as? String {
            self._img_Url = imageUrl
        }
        if let likes = postdata["likes"] as? Int {
            self._likes = likes
        }
        
        _postRef = DataService.ds.ref_post.child(_postkey)
    }
    
    func adjustLikes(addLike: Bool) {
        if addLike {
            _likes = _likes + 1
        } else {
            _likes = _likes - 1
        }
        _postRef.child("likes").setValue(_likes)
    }

    
}
