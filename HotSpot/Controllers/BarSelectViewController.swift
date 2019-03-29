//
//  BarSelectViewController.swift
//  HotSpot
//
//  Created by Kman on 3/23/19.
//  Copyright © 2019 CS506 HotSpot. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore

class BarSelectViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var barNameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    
    let barName = "Sconnie Bar"
    let address = "101 Regent St, Madison WI 53714"
    var ratings:[ReviewInformation] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Initialize database
        let database = Firestore.firestore()
        
        
        barNameLabel.text = barName
        addressLabel.text = address
        
        loadReviews()
        print(ratings)
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ratings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath) as! ReviewsTableViewCell
        let rating = ratings[indexPath.row]
        
        cell.tableTextLabel.text = rating.review
        
        return cell
    }


    func loadReviews() {
        db.collection("Ratings").whereField("barName", isEqualTo: barName)
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        var newRating = ReviewInformation.init(review: "",rating: 0,vibes: [],barName: "",userId: "")
                        
                        print(document.data())
                        newRating.rating = document.data()["rating"] as! Double
                        newRating.review = document.data()["review"] as! String
                        newRating.barName = document.data()["barName"] as! String
                        newRating.userId = document.data()["userID"] as! String
                        newRating.vibes = document.data()["vibes"] as! [String]
                        
                        self.ratings.append(newRating)
                    }
                }
        }
    }

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if let newView = segue.destination as? BarRateViewController {
            newView.barName = barName
        }
        
    }
    

}
