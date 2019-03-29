//
//  CategorizedFeedViewController.swift
//  HotSpot
//
//  Created by Kman on 3/23/19.
//  Copyright © 2019 CS506 HotSpot. All rights reserved.
//

import UIKit
import Firebase

struct bar {
    let barName : String!
    let address : String!
}

class CategorizedFeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var bars:[BarInformation] = []
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bars.count
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? CategorizedFeedTableViewCell else {
            fatalError("Could not dequeue a cell")
        }
        let bar = bars[indexPath.row]
        cell.address.text = bar.address
        cell.barName.text = bar.uniqueBarNameID
        
        return cell
    }
    func getBars(){
        
    }
    @IBOutlet weak var barTableView: UITableView!
    override func viewDidLoad() {
        //        let databaseRef = FIRDatabase.database().reference()
//        databaseRef.child("Bars").queryOrderedByKey().observedEventType(.ChildAdded, withBlock: { snapshot in
//            
//            let barName = snapshot.value!["barName"]
//            let address = snapshot.value!["address"]
//
//            self.posts.insert(postStruct(barName: barName, address: address), atIndex: 0)
//        })
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
