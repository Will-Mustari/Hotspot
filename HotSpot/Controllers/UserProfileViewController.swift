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
        //self.dismiss(animated: false, completion: nil)
        exit(0)
    }
    
    @IBAction func resetPassword(_ sender: Any) {
        let alert = UIAlertController(title: "WAIT", message: "Are you sure that you want to reset your password?", preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "YES", style: UIAlertAction.Style.default, handler: { (action) in
            alert.dismiss(animated:true, completion: nil)
            
            Auth.auth().sendPasswordReset(withEmail: (Auth.auth().currentUser?.email)!) { error in
                print("Error sending reset Password")
            }
        }))
        
        alert.addAction(UIAlertAction(title: "CANCEL", style: UIAlertAction.Style.default, handler: { (action) in
            alert.dismiss(animated:true, completion: nil)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
     @IBAction func deleteAccount(_ sender: Any) {
        let alert = UIAlertController(title: "Hold UP", message: "Are you sure that you want to delete your account permanently?", preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "YES", style: UIAlertAction.Style.default, handler: { (action) in
            alert.dismiss(animated:true, completion: nil)
            
            let user = Auth.auth().currentUser
            
            user?.delete { error in
                if let error = error {
                    print("user not delete properly")
                } else {
                    print("user deleted")
                }
            }
        }))
        
        alert.addAction(UIAlertAction(title: "NO", style: UIAlertAction.Style.default, handler: { (action) in
            alert.dismiss(animated:true, completion: nil)
        }))
        
        self.present(alert, animated: true, completion: nil)
     }

}
