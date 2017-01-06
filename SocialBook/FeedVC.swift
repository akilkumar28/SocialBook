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

class FeedVC: UIViewController, UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var postbtn: FancyButton!
    
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var postArray = [Post]()

    override func viewDidLoad() {
        super.viewDidLoad()

        postbtn.generalButn()
        tableView.delegate = self
        tableView.dataSource = self
        
        DataService.ds.ref_post.observe(.value, with: { (Snapshot) in
            self.postArray = []
            if let snapshot = Snapshot.children.allObjects as? [FIRDataSnapshot] {
                for snap in snapshot {
                    print("Individual Snal \(snap.value)")
                    
                    if let postDict = snap.value as? Dictionary<String,AnyObject>{
                        let key = snap.key
                        let post = Post(postkey: key, postdata: postDict)
                        self.postArray.append(post)
                    }
                    
                }
            }
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
            cell.configureCell(post: post)
            return cell
        } else {
            return UITableViewCell()
        }
        
    }
    
    
    

    

}
