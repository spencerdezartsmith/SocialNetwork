//
//  FeedVC.swift
//  SocialNetwork
//
//  Created by spencerdezartsmith on 3/24/17.
//  Copyright © 2017 spencerdezartsmith. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import Firebase
import SwiftKeychainWrapper


class FeedVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var posts = [Post]()
    var imagePicker: UIImagePickerController!
    static var imageCache = NSCache<NSString, UIImage>()

    @IBOutlet var addImage: CircleView!
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true 
        imagePicker.delegate = self
        
        DataService.ds.REF_POSTS.observe(.value, with: { (snapshot) in
            if let snapshots = snapshot.children.allObjects as? [FIRDataSnapshot] {
                for snap in snapshots {
                    if let postDict = snap.value as? Dictionary<String, AnyObject> {
                        let key = snap.key
                        let post = Post(postKey: key, postData: postDict)
                        self.posts.append(post)
                    }
                }
            }
            
            self.tableView.reloadData()
        })

    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let post = posts[indexPath.row]
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as? PostCell {
            
            if let img = FeedVC.imageCache.object(forKey: post.imageUrl as NSString) {
                cell.configureCell(post: post, img: img)
                
                return cell
                
            } else {
                
                cell.configureCell(post: post)
                
                return cell
            }
    
        } else {
            
            return PostCell()
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
            addImage.image = image
        } else {
            print("Valid image was not selected")
        }
        // once image is selected get rid of the picker
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func imagePickerTapped(_ sender: Any) {
        print("Image button tapped") 
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func signOutTapped(_ sender: Any) {
        do {
            try FIRAuth.auth()?.signOut()
            KeychainWrapper.standard.removeObject(forKey: KEY_UID)
            performSegue(withIdentifier: "goToSignIn", sender: nil)
        } catch {
            print("Unable to sign out of firebase")
        }
    }
}


