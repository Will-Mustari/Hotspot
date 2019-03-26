//
//  InitialViewController.swift
//  HotSpot
//
//  Created by Will on 3/26/19.
//  Copyright © 2019 CS506 HotSpot. All rights reserved.
//

import Foundation
import UIKit

class InitialViewController: UIViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.performSegue(withIdentifier: "toLaunchScreen", sender: self)
    }
}
