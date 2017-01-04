//
//  ViewController.swift
//  SocialBook
//
//  Created by AKIL KUMAR THOTA on 1/4/17.
//  Copyright © 2017 AKIL KUMAR THOTA. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import Firebase

class SignInVC: UIViewController {

    @IBOutlet weak var signInBtn: FancyButton!
    @IBOutlet weak var fbBtn: FancyButton!
    
    @IBOutlet weak var emailTxtFld: FancytxtFld!
    
    @IBOutlet weak var pswdTxtFld: FancytxtFld!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fbBtn.fancyFbBtn()
        signInBtn.textFldBtn()
        
    }

    
    @IBAction func fbBtnPrssd(_ sender: Any) {
        
        let faceBookLogin = FBSDKLoginManager()
        
        faceBookLogin.logIn(withReadPermissions: ["email"], from: self) { (result, error) in
            
            if error != nil {
                print("Facebook authentication falied")
            } else if result?.isCancelled == true {
                print("User Cancelled FaceBook Authentication")
            } else {
                let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                print("Authentication Successfull with Facebook")
                self.firbaseAuth(Credential: credential)
            }
        }
        
    }
    
    func firbaseAuth(Credential credential:FIRAuthCredential) {
        
        FIRAuth.auth()?.signIn(with: credential, completion: { (user, error) in
            if error != nil {
                print("Firebase authentication Failed")
            } else {
                print("Authentication Successfull With Firebase")
            }
        })
        
    }


    @IBAction func signInBtnPrssd(_ sender: Any) {
        
        guard let email = emailTxtFld.text, !email.isEmpty else{
            print("Invalid Email ID")
            return
        }
        guard let pwd = pswdTxtFld.text, !pwd.isEmpty else {
            print("Invalid Password")
            return
        }
        FIRAuth.auth()?.signIn(withEmail: email, password: pwd, completion: { (user, error) in
            if error == nil {
                print("Successfull Authentication With Email")
            }else {
                FIRAuth.auth()?.createUser(withEmail: email, password: pwd, completion: { (user, error) in
                    if error != nil {
                        print("Email Authentication Failed")
                    } else {
                        print("Successfull Authentication With Email")
                    }
                })
            }
        })
    }
    
    
 
    
    
}

