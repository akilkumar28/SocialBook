//
//  FeedVC.swift
//  SocialBook
//
//  Created by AKIL KUMAR THOTA on 1/5/17.
//  Copyright © 2017 AKIL KUMAR THOTA. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper
import Firebase

class FeedVC: UIViewController {
    
    @IBOutlet weak var postbtn: FancyButton!
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        postbtn.generalButn()
        
    }

    
    
    @IBAction func SignOutPrssd(_ sender: Any) {
        
        
        let removeResult = KeychainWrapper.standard.removeObject(forKey: "uid")
        print("keychain removed = \(removeResult)")
        try! FIRAuth.auth()?.signOut()
        self.dismiss(animated: true, completion: nil)
        
        
    }

    

}
