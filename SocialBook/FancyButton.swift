//
//  FancyButton.swift
//  SocialBook
//
//  Created by AKIL KUMAR THOTA on 1/4/17.
//  Copyright © 2017 AKIL KUMAR THOTA. All rights reserved.
//

import UIKit

class FancyButton: UIButton {
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowRadius = 5.0
        layer.shadowOffset = CGSize.zero
        layer.shadowOpacity = 0.7
    }

    func fancyFbBtn() {
        layer.cornerRadius = self.frame.width / 2

    }
    
    func textFldBtn() {
        layer.cornerRadius = 2
        
    }
    func generalButn () {
        layer.masksToBounds = true
        layer.cornerRadius = 5.0
        
    }

}
