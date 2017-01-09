//
//  InfoVC.swift
//  SocialBook
//
//  Created by AKIL KUMAR THOTA on 1/8/17.
//  Copyright © 2017 AKIL KUMAR THOTA. All rights reserved.
//

import UIKit
import Firebase
import SwiftKeychainWrapper

class InfoVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    @IBOutlet weak var initialProfielPic: FancyImageView!
    
    @IBOutlet weak var initialNameFld: FancytxtFld!
    
    
    @IBOutlet weak var initialEmailidFld: FancytxtFld!
    
    @IBOutlet weak var initialPswdFld: FancytxtFld!
    
    @IBOutlet weak var initialSignupBtn: FancyButton!
    
    var signin: SignInVC!
    let imagePicker2 =  UIImagePickerController()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        initialSignupBtn.textFldBtn()
        signin = SignInVC()
        imagePicker2.delegate = self
        imagePicker2.allowsEditing = true
        
    }
    
    
    @IBAction func signUpbtnPrsd(_ sender: Any) {
        
        guard let initialFullName = initialNameFld.text, initialFullName != "" else {
            
            print("Please Enter your name")
            self.view.makeToast("Please Enter your name", duration: 3, position: .center)
            return
        }
        
        guard let initialEmailId = initialEmailidFld.text, initialEmailId != "" else {
            
            print("Invalid Email Id")
            self.view.makeToast("Invalid Email Id", duration: 3, position: .center)
            return
        }
        
        guard let initialPswd = initialPswdFld.text, initialPswd != "" else {
            
            print("Invalid Password")
            self.view.makeToast("Invalid Password", duration: 3, position: .center)
            return
        }
        
        FIRAuth.auth()?.createUser(withEmail: initialEmailId, password: initialPswd, completion: { (user, error) in
            if error != nil {
                print("Email Authentication Failed")
                self.view.makeToast("Email Authentication Failed", duration: 3, position: .center)
            } else {
                print("Authentication Successfull With Email")
                self.view.makeToast("Authentication Successfull With Email", duration: 1, position: .center)
                
                if let user = user {
                    let user_data = ["provider":user.providerID]
                    let name_data = ["Name": initialFullName]
                    DataService.ds.ref_user.child(user.uid).updateChildValues(name_data)
                    self.signin.completeSignIn(id: user.uid, userData: user_data)
                }
            }
        })
    }
    
    
    
    
    
    @IBAction func profilePicSelected(_ sender: Any) {
        
        present(imagePicker2, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
            self.initialProfielPic.image = image
        } else {
            print("Invalid Image")
            self.view.makeToast("Invalid Image", duration: 3, position: .center)
        }
        dismiss(animated: true, completion: nil)
    }
}
