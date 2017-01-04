//
//  FancyButton.swift
//  SocialBook
//
//  Created by AKIL KUMAR THOTA on 1/4/17.
//  Copyright © 2017 AKIL KUMAR THOTA. All rights reserved.
//

import UIKit

class FancyButton: UIButton {

    func fancyFbBtn() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowRadius = 5.0
        layer.shadowOffset = CGSize.zero
        layer.shadowOpacity = 0.7
        layer.cornerRadius = self.frame.width / 2

        
    }
    
    func textFldBtn() {
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowRadius = 5.0
        layer.shadowOffset = CGSize.zero
        layer.shadowOpacity = 0.7
        layer.cornerRadius = 2
        
    }

}
