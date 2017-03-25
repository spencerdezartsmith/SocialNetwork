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


class FeedVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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


