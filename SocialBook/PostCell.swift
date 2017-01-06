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

    override func awakeFromNib() {
        super.awakeFromNib()
        
        likeBtn.fancyFbBtn()
        nameLbl.corner()
        likecountLbl.roundLbl()
        generalLikebtn.corner()
    }
    
    func configureCell(post: Post, img: UIImage? = nil) {
        
        caption.text = post.caption
        likecountLbl.text = "\(post.likes)"
        
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
    }

   

}
