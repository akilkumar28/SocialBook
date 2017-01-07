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

class FeedVC: UIViewController, UITableViewDelegate,UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var woymTxtFld: FancytxtFld!
    @IBOutlet weak var addimgView: FancyImageView!
    @IBOutlet weak var postbtn: FancyButton!
    @IBOutlet weak var tableView: UITableView!
    
    var postArray = [Post]()
    
    var imageSelectd = false
    
    static var imageCache: NSCache<NSString, UIImage> = NSCache()
    
    let imagePicker = UIImagePickerController()

    override func viewDidLoad() {
        super.viewDidLoad()

        postbtn.generalButn()
        tableView.delegate = self
        tableView.dataSource = self
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        
        DataService.ds.ref_post.observe(.value, with: { (Snapshot) in
            self.postArray = []
            if let snapshot = Snapshot.children.allObjects as? [FIRDataSnapshot] {
                for snap in snapshot {
                    print("Individual Snal \(snap.value)")
                    
                    if let postDict = snap.value as? Dictionary<String,AnyObject> {
                        let key = snap.key
                        let post = Post(postkey: key, postdata: postDict)
                        self.postArray.append(post)
                    }
                    
                }
            }
            self.postArray.reverse()
            self.tableView.reloadData()
        })
        
    }

    
    
    @IBAction func SignOutPrssd(_ sender: Any) {
        
        
        let removeResult = KeychainWrapper.standard.removeObject(forKey: "uid")
        print("keychain removed = \(removeResult)")
        try! FIRAuth.auth()?.signOut()
        self.dismiss(animated: true, completion: nil)
        
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as? PostCell {
            let post = postArray[indexPath.row]
            if let img = FeedVC.imageCache.object(forKey: post.img_Url as NSString) {
                cell.configureCell(post: post, img: img)
                return cell
            } else {
                cell.configureCell(post: post)
                return cell
            }
        }else {
            return UITableViewCell()
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage{
            addimgView.image = image
            imageSelectd = true
        } else {
            print("Invalid Image provided")
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func addImageViewPrssd(_ sender: Any) {
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    
    @IBAction func postBtnPrssd(_ sender: Any) {
        
        guard let img = addimgView.image, imageSelectd == true else {
            print("Invalid. Please Add an Image")
            self.view.makeToast("Invalid. Please Add an Image", duration: 5, position: .center)
            return
        }
        guard let txtdata = woymTxtFld.text, txtdata != "" else {
            print("Please Enter Some Text To Post")
            return
        }
        
        if let imgData = UIImageJPEGRepresentation(img, 0.2) {
            
            let uid = NSUUID().uuidString
            let metaData = FIRStorageMetadata()
            metaData.contentType = "image/jpeg"
            DataService.ds.ref_storage_postpics.child(uid).put(imgData, metadata: metaData, completion: { (metadata, error) in
                if error != nil {
                    print("Failed To upload to FireBase")
                } else {
                    print("Successfully Uploaded to FireBase")
                    let downloadURL = metadata?.downloadURL()?.absoluteString
                    if let url1 = downloadURL{
                        self.postDataToFirebase(imageURL: url1)
                    }
                }
            })
        }
    }

    func postDataToFirebase(imageURL: String) {
        let post: Dictionary<String,AnyObject> = [
        "caption": woymTxtFld.text as AnyObject,
        "imageUrl": imageURL as AnyObject,
        "likes": 0 as AnyObject
        ]
        let firebasePost = DataService.ds.ref_post.childByAutoId()
        firebasePost.setValue(post)
        
        woymTxtFld.text = ""
        addimgView.image = UIImage(named: "add-image")
        imageSelectd = false
        tableView.reloadData()
        
    }
 
    
}
