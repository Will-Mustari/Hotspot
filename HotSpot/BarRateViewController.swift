//
//  BarRateViewController.swift
//  HotSpot
//
//  Created by Kman on 3/23/19.
//  Copyright © 2019 CS506 HotSpot. All rights reserved.
//

import UIKit
import Firebase
//TODO must use podfile to also import FirebaseDatabase
//import FirebaseDatabase

class BarRateViewController: UIViewController {
    
    var barName = ""

    @IBOutlet weak var barNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Set label to name given from previous view
        barNameLabel.text = barName;
    }
    
    /*
     * ACTION - press submit rating button
     * Creates barRating object and sends the information
     * to Firebase server.
     */
    @IBAction func submitRatingButton(_ sender: UIButton) {
        //TODO
        
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
