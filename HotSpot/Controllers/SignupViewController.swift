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
        //Checks if fields are empty
        guard let email = userEmail.text else { return }
        guard let password = userPassword.text else { return }
        guard let passwordDup = userPasswordConfirm.text else { return }
        
        if isValidEmail(email: email) == false {
            //TODO: SHOW USER ERROR MESSAGE HERE
            print("Bad email!")
            return
        }
        
        if password == passwordDup {
            Auth.auth().createUser(withEmail: email, password: password) { user, error in
                if error == nil && user != nil {
                    //TODO: SHOW USER SUCCESS MESSAGE HERE
                    print("User created!")
                    self.performSegue(withIdentifier: "signupToMainMenu", sender: self)
                } else {
                    //TODO: SHOW USER ERROR MESSAGE HERE
                    print("Error creating user: \(error!.localizedDescription)")
                }
            }
        } else {
            //TODO: SHOW USER ERROR MESSAGE HERE
            print("Passwords do not match!")
            return
        }
    }
    
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
