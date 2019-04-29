//
//  SignupViewController.swift
//  HotSpot
//
//  Created by Kman on 3/23/19.
//  Copyright © 2019 CS506 HotSpot. All rights reserved.
//

import UIKit
import Firebase

class SignupViewController: UIViewController {

    @IBOutlet weak var userEmail: UITextField!
    @IBOutlet weak var userPassword: UITextField!
    @IBOutlet weak var userPasswordConfirm: UITextField!
    
    
    @IBOutlet weak var emailErrorLabel: UILabel!
    @IBOutlet weak var passwordErrorLabel: UILabel!
    @IBOutlet weak var passwordConfirmErrorLabel: UILabel!
    
    let MIN_PASS_LENGTH = 6
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    /*
     * ACTION - press of signup button
     * Calls Firebase Auth to create a new user
     * Checks for valid email
     * Check passwords match
     */
    @IBAction func signupButtonPress(_ sender: Any) {
        //Get user input and catch if fields are empty
        guard let email = userEmail.text else { return }
        guard let password = userPassword.text else { return }
        guard let passwordDup = userPasswordConfirm.text else { return }
        
        //Catch if invalid email
        if isValidEmail(email: email) == false {
            self.userEmail.layer.borderColor = UIColor.red.cgColor
            self.userEmail.layer.borderWidth = 1.0
            
            ////////TODO: ADD ERROR MESSAGE POPUP/////////
            emailErrorLabel.text = "Invalid email!"
            emailErrorLabel.isHidden = false
            
            print("Bad email!")
            return
        } else {
            userEmail.layer.borderColor = UIColor.clear.cgColor
            emailErrorLabel.isHidden = true
        }
        
        //Catch if password less than 6 chars
        if password.count < MIN_PASS_LENGTH {
            userPassword.layer.borderColor = UIColor.red.cgColor
            userPassword.layer.borderWidth = 1.0
            
            passwordErrorLabel.text = "Password too short!"
            passwordErrorLabel.isHidden = false
            
            print("Password too short")
        } else {
            userPassword.layer.borderColor = UIColor.clear.cgColor
            passwordErrorLabel.isHidden = true
        }

        //Catch if password mismatch
        if password != passwordDup {
            userPassword.layer.borderColor = UIColor.red.cgColor
            userPassword.layer.borderWidth = 1.0
            userPasswordConfirm.layer.borderColor = UIColor.red.cgColor
            userPasswordConfirm.layer.borderWidth = 1.0
            
            ///////TODO: ADD ERROR MESSAGE POPUP/////////
            passwordConfirmErrorLabel.text = "Passwords do not match!"
            passwordConfirmErrorLabel.isHidden = false
            
            print("Passwords do not match!")
            return
        } else {
            userPassword.layer.borderColor = UIColor.clear.cgColor
            userPasswordConfirm.layer.borderColor = UIColor.clear.cgColor
            passwordConfirmErrorLabel.isHidden = true
        }
        
        //Create user if auth successful, otherwise throw error
        Auth.auth().createUser(withEmail: email, password: password) { user, error in
            if error == nil && user != nil {
                self.userPassword.layer.borderColor = UIColor.clear.cgColor
                self.userPasswordConfirm.layer.borderColor = UIColor.clear.cgColor
                
                ///////TODO: ADD SUCCESS MESSAGE POPUP////////
                
                
                print("User created!")
                self.userEmail.text=""
                self.userPassword.text=""
                self.userPasswordConfirm.text=""
                self.performSegue(withIdentifier: "signupToMainMenu", sender: self)
            } else {
                self.userPassword.layer.borderColor = UIColor.red.cgColor
                self.userPassword.layer.borderWidth = 1.0
                self.userPasswordConfirm.layer.borderColor = UIColor.red.cgColor
                self.userPasswordConfirm.layer.borderWidth = 1.0
                
                ////////TODO: ADD ERROR MESSAGE POPUP////////
                
                print("Error creating user: \(error!.localizedDescription)")
            }
        }
    }
    
    /*
     * Checks if string is a valid email
     * Returns true if valid
     */
    func isValidEmail(email:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
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
