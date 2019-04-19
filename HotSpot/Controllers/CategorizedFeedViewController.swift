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

class CategorizedFeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var sortBy: UIPickerView!
    var bars:[BarInformation] = []
    var sortByOptions: [String] = ["Name", "Best", "Vibe", "Popularity"]
    var selectedBar:BarInformation = BarInformation.init(uniqueBarNameID: "", vibeRating: "", overallRating: 0, locationLatitude: 0, locationLongitude: 0, address: "", popularity: 0, numRatings: 0)
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
        if(bar.numRatings == 0) {
            cell.overallRating.text = "Rating: " + String(format: "%.1f", bar.overallRating)
        } else {
            let actualRating = Double(bar.overallRating / Double(bar.numRatings))
            cell.overallRating.text = "Rating: " + String(format: "%.1f", actualRating)
        }
        
        if(bar.popularity > 50) {
            cell.imageFire.image = UIImage(named: "fire7.png")
        } else if(bar.popularity > 35) {
            cell.imageFire.image = UIImage(named: "fire6.png")
        } else if(bar.popularity > 25) {
            cell.imageFire.image = UIImage(named: "fire5.png")
        } else if(bar.popularity > 15) {
            cell.imageFire.image = UIImage(named: "fire4.png")
        } else if(bar.popularity > 10) {
            cell.imageFire.image = UIImage(named: "fire3.png")
        } else if(bar.popularity > 5) {
            cell.imageFire.image = UIImage(named: "fire2.png")
        } else if(bar.popularity > 2) {
            cell.imageFire.image = UIImage(named: "fire1.png")
        } else {
            cell.imageFire.image = UIImage(named: "fire0.png")
        }

        cell.vibeRating.text = "Vibes: " + bar.vibeRating
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedBar = bars[indexPath.row]
        performSegue(withIdentifier: "feedToBarSelect", sender: self)
    }
    
    func getBars(){
        loadBars { (loadedBars) in
            self.bars = loadedBars
            self.barTableView.reloadData()
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return sortByOptions.count
    }
    
    // The data to return fopr the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return sortByOptions[row]
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch row {
        case 0:
            //Name
            bars = bars.sorted(by: {$0.uniqueBarNameID < $1.uniqueBarNameID})
            break
        case 1:
            //Best
            bars = bars.sorted(by: {($0.overallRating / Double($0.numRatings)) > ($1.overallRating / Double($1.numRatings))})

            break
        case 2:
            //Vibe

            break
        case 3:
            //Popularity
            bars = bars.sorted(by: {$0.popularity > $1.popularity})
            break
        default:
            bars = bars.sorted(by: {$0.uniqueBarNameID < $1.uniqueBarNameID})
            break
        }
        barTableView.reloadData()
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
        self.sortBy.delegate = self
        self.sortBy.dataSource = self
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if let newView = segue.destination as? BarSelectViewController {
            newView.barName = selectedBar.uniqueBarNameID
            newView.address = selectedBar.address
            newView.popularity = selectedBar.popularity
            newView.overallRating = selectedBar.overallRating
            newView.currentVibe = selectedBar.vibeRating
            newView.numRatings = selectedBar.numRatings
        }
    }
    

}
