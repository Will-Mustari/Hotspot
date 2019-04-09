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
    var selectedBarName = ""
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
        cell.overallRating.text = String(bar.overallRating)
        cell.vibeRating.text = bar.vibeRating
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedBarName = bars[indexPath.row].uniqueBarNameID
        performSegue(withIdentifier: "feedToBarSelect", sender: self)
    }
    
    func getBars(){
        loadBars { (loadedBars) in
            self.bars = loadedBars
            self.barTableView.reloadData()
        }
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
        barTableView.dataSource = self
        barTableView.delegate = self
        getBars()
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if let newView = segue.destination as? BarSelectViewController {
            newView.barName = selectedBarName
        }
    }
    

}
