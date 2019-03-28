//
//  LoginViewController.swift
//  HotSpot
//
//  Created by Kman on 3/23/19.
//  Copyright © 2019 CS506 HotSpot. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    @IBOutlet weak var userEmail: UITextField!
    @IBOutlet weak var userPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    /*
     * ACTION - press of login button
     * Calls Firebase Auth to check for valid login
     */
    @IBAction func loginButtonPress(_ sender: Any) {
        //TODO: HANDLE INVALID EMAIL OR PASSWORD
        if userEmail == nil {
            print("ERROR")
            return
        }
        
        //Checks if fields are empty
        guard let email = userEmail.text else { return }
        guard let pass = userPassword.text else { return }
        
        Auth.auth().signIn(withEmail: email, password: pass) { user, error in
            if error == nil && user != nil {
                //TODO: SHOW USER SUCCESS MESSAGE HERE
                self.performSegue(withIdentifier: "loginToMainMenu", sender: self)
            } else {
                //TODO: SHOW USER ERROR MESSAGE HERE
                print("Error creating user: \(error!.localizedDescription)")
            }
        }
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
