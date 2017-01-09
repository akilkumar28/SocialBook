//
//  PostCell.swift
//  SocialBook
//
//  Created by AKIL KUMAR THOTA on 1/5/17.
//  Copyright © 2017 AKIL KUMAR THOTA. All rights reserved.
//

import UIKit
import Firebase

class PostCell: UITableViewCell {
    
    @IBOutlet weak var picture: FancyImageView!
    @IBOutlet weak var nameLbl: Fancylabel!
    @IBOutlet weak var likeBtn: FancyButton!
    @IBOutlet weak var centerImg: FancyImageView!
    @IBOutlet weak var caption: UITextView!
    @IBOutlet weak var likecountLbl: Fancylabel!
    @IBOutlet weak var generalLikebtn: Fancylabel!
    
    var likesRef : FIRDatabaseReference!
    var post: Post!


    override func awakeFromNib() {
        super.awakeFromNib()
        
        likeBtn.fancyFbBtn()
        nameLbl.corner()
        likecountLbl.roundLbl()
        generalLikebtn.corner()
    }
    
    func configureCell(post: Post, img: UIImage? = nil) {
        self.post = post
        likesRef = DataService.ds.Ref_Current_User.child("likes").child(post.postkey)
        caption.text = post.caption
        likecountLbl.text = "\(post.likes)"
//        nameLbl.text = DataService.ds.Ref_Current_User.value(forKey: "Name") as! String?
        if img != nil {
            self.centerImg.image = img
        } else {
            let ref = FIRStorage.storage().reference(forURL: post.img_Url)
            ref.data(withMaxSize: 2 * 1024 * 1024, completion: { (data, error) in
                if error != nil {
                    print("Unable to download the images")
                } else {
                    print("Images Downloaded Succesfully")
                    if let imgData = data {
                        let img = UIImage(data: imgData)
                        self.centerImg.image = img
                        FeedVC.imageCache.setObject(img!, forKey: post.img_Url as NSString)
                    }
                }
            })
        }
        
        likesRef.observeSingleEvent(of: .value, with: { (snapshot) in
            if let _ = snapshot.value as? NSNull {
                self.likeBtn.setImage(UIImage(named: "empty-heart"), for: .normal)
            } else {
                self.likeBtn.setImage(UIImage(named: "filled-heart"), for: .normal)
            }
        })
    }
    
    @IBAction func likeTapped(_ sender: Any) {
        
        likesRef.observeSingleEvent(of: .value, with: { (snapshot) in
            if let _ = snapshot.value as? NSNull {
                self.likeBtn.setImage(UIImage(named: "filled-heart"), for: .normal)
                self.post.adjustLikes(addLike: true)
                self.likesRef.setValue(true)
            } else {
                self.likeBtn.setImage(UIImage(named: "empty-heart"), for: .normal)
                self.post.adjustLikes(addLike: false)
                self.likesRef.removeValue()
            }
        })
        
    }
    

   

}
