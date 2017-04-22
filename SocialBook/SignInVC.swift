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
import SwiftKeychainWrapper


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
    
    override func viewDidAppear(_ animated: Bool) {
        
        if let _ = KeychainWrapper.standard.string(forKey: "uid"){
            print("Successfully Signed In Automatically")
            self.view.makeToast("Successfully Signed In Automatically", duration: 3, position: .center)
            
            performSegue(withIdentifier: "FeedVC", sender: nil)
        }
        
    }

    
    @IBAction func fbBtnPrssd(_ sender: Any) {
        
        let faceBookLogin = FBSDKLoginManager()
        
        faceBookLogin.logIn(withReadPermissions: ["email"], from: self) { (result, error) in
            
            if error != nil {
                print("Facebook authentication falied")
                self.view.makeToast("Facebook authentication falied", duration: 3, position: .center)
            } else if result?.isCancelled == true {
                print("User Cancelled FaceBook Authentication")
            } else {
                let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                print("Successfull Authentication with Facebook")
                self.view.makeToast("Successfull Authentication with Facebook", duration: 3, position: .center)
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
                if let user = user{
                    let user_data = ["provider":credential.provider]
                    self.completeSignIn(id: user.uid, userData: user_data)
                }
            }
        })
        
    }
    
    
    @IBAction func newmemSignUpPrsd(_ sender: Any) {
        
        performSegue(withIdentifier: "InfoVC", sender: nil)
        
    }


    @IBAction func signInBtnPrssd(_ sender: Any) {
        
        guard let email = emailTxtFld.text, !email.isEmpty else{
            print("Invalid Email ID")
            self.view.makeToast("Invalid Email ID", duration: 3, position: .center)
            return
        }
        guard let pwd = pswdTxtFld.text, !pwd.isEmpty else {
            print("Invalid Password")
            self.view.makeToast("Invalid Password", duration: 3, position: .center)
            return
        }
        FIRAuth.auth()?.signIn(withEmail: email, password: pwd, completion: { (user, error) in
            if error == nil {
                print("Authentication Successfull With Email")
                self.view.makeToast("Authentication Successfull With Email", duration: 1, position: .center)
                if let user = user{
                    let user_data = ["provider":user.providerID]
                    self.completeSignIn(id: user.uid, userData: user_data)
                }
            }
        })
    }
    
    func completeSignIn(id: String, userData: Dictionary<String,String>) {
        
        DataService.ds.createFirebaseDbUser(uid: id, userData: userData)
        let saveSuccessfull = KeychainWrapper.standard.set(id, forKey: "uid")
        print("Succesfull stored keyChain = \(saveSuccessfull)")
        performSegue(withIdentifier:"FeedVC", sender: nil)
        
    }
 
    
}

