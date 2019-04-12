//
//  UserProfileViewController.swift
//  HotSpot
//
//  Created by Kman on 3/23/19.
//  Copyright © 2019 CS506 HotSpot. All rights reserved.
//

import UIKit
import Firebase

class UserProfileViewController: UIViewController {

    @IBOutlet var emailLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        emailLabel.text = Auth.auth().currentUser?.email
    }
    
    @IBAction func handleLogout(_ sender: UIBarButtonItem) {
        try! Auth.auth().signOut()
        self.dismiss(animated: false, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
