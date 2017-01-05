//
//  PostCell.swift
//  SocialBook
//
//  Created by AKIL KUMAR THOTA on 1/5/17.
//  Copyright © 2017 AKIL KUMAR THOTA. All rights reserved.
//

import UIKit

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

   

}
