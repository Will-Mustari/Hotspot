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
    
    @IBAction func pressEnterPassword(_ sender: Any) {
        loginButtonPress(self)
    }
    
    
    /*
     * ACTION - press of login button
     * Calls Firebase Auth to check for valid login
     */
    @IBAction func loginButtonPress(_ sender: Any) {
        if userEmail.text == "" {
            self.userEmail.layer.borderColor = UIColor.red.cgColor
            self.userEmail.layer.borderWidth = 1.0
            print("ERROR")
            return
        }
        
        //Checks if fields are empty
        guard let email = userEmail.text else { return }
        guard let pass = userPassword.text else { return }
        
        Auth.auth().signIn(withEmail: email, password: pass) { user, error in
            if error == nil && user != nil {
                self.userEmail.layer.borderColor = UIColor.clear.cgColor
                self.userPassword.layer.borderColor = UIColor.clear.cgColor
                
                /////////TODO: ADD SUCCESS MESSAGE HERE/////////
                self.userEmail.text=""
                self.userPassword.text=""
                self.performSegue(withIdentifier: "loginToMainMenu", sender: self)
            } else {
                self.userEmail.layer.borderColor = UIColor.red.cgColor
                self.userEmail.layer.borderWidth = 1.0
                self.userPassword.layer.borderColor = UIColor.red.cgColor
                self.userPassword.layer.borderWidth = 1.0
                
                /////////TODO: ADD ERROR MESSAGE HERE//////////
                
                print("Error signing in: \(error!.localizedDescription)")
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
