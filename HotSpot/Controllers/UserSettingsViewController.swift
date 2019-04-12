//
//  UserSettingsViewController.swift
//  HotSpot
//
//  Created by Joseph Pineda on 4/12/19.
//  Copyright © 2019 CS506 HotSpot. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class UserSettingsViewController: UIViewController {
    var email = "";

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        email = (Auth.auth().currentUser?.email)!
    }
  
    @IBAction func ResetButtonPressed(_ sender: Any) {
        //send email
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            
        }
        //logout
        try! Auth.auth().signOut()
        self.dismiss(animated: false, completion: nil)
    }

}
