//
//  Fancylabel.swift
//  SocialBook
//
//  Created by AKIL KUMAR THOTA on 1/5/17.
//  Copyright © 2017 AKIL KUMAR THOTA. All rights reserved.
//

import UIKit

class Fancylabel: UILabel {

   
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowRadius = 5.0
        layer.shadowOffset = CGSize.zero
        layer.shadowOpacity = 0.7
        
    }
    
    func corner() {
        layer.masksToBounds = true
        layer.cornerRadius = 5.0

    }
    func roundLbl(){
        layer.masksToBounds = true
        layer.cornerRadius = self.frame.width / 2

    }
    
    
        
    
    
}
