//
//  FancyImageView.swift
//  SocialBook
//
//  Created by AKIL KUMAR THOTA on 1/5/17.
//  Copyright © 2017 AKIL KUMAR THOTA. All rights reserved.
//

import UIKit

class FancyImageView: UIImageView {

    override func layoutSubviews() {
        layer.masksToBounds = true
        layer.cornerRadius = self.frame.width / 2
        clipsToBounds = true
    }
}
