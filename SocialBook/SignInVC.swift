//
//  ViewController.swift
//  SocialBook
//
//  Created by AKIL KUMAR THOTA on 1/4/17.
//  Copyright © 2017 AKIL KUMAR THOTA. All rights reserved.
//

import UIKit

class SignInVC: UIViewController {

    @IBOutlet weak var signInBtn: FancyButton!
    @IBOutlet weak var fbBtn: FancyButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fbBtn.fancyFbBtn()
        signInBtn.textFldBtn()
        
    }

    


}

