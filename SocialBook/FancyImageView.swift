//
//  FancyImageView.swift
//  SocialBook
//
//  Created by AKIL KUMAR THOTA on 1/5/17.
//  Copyright © 2017 AKIL KUMAR THOTA. All rights reserved.
//

import UIKit

class FancyImageView: UIImageView {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowRadius = 5.0
        layer.shadowOffset = CGSize.zero
        layer.shadowOpacity = 0.7
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 5

    }
}
