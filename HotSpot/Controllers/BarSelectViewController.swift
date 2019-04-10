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
    @IBOutlet weak var reviewTable: UITableView!
    @IBOutlet weak var overallRatingLabel: UILabel!
    @IBOutlet weak var currentVibeLabel: UILabel!
    @IBOutlet weak var popularityLabel: UILabel!
    
    
    var barName = ""
    var address = ""
    var popularity = 0
    var currentVibe = ""
    var overallRating:Double = 0
    var numRatings = 0
    var ratings:[ReviewInformation] = []
    var reviews:[String] = []
    
    
    override func viewDidLoad() {
        
        //Initialize database
        let database = Firestore.firestore()
        
        
        barNameLabel.text = barName
        addressLabel.text = address
        overallRatingLabel.text = "Rating: " + String(format: "%.1f", (overallRating / Double(numRatings)))
        currentVibeLabel.text = "Current Vibe: " + currentVibe
        popularityLabel.text = "Current Popularity: " + String(popularity)
        
        loadReviews { (loadedRatings) in
            self.ratings = loadedRatings
            self.reviewTable.reloadData()
        }
        
        reviewTable.delegate = self
        reviewTable.dataSource = self
        reviewTable.reloadData()
        print("ratings: \(ratings)")
        super.viewDidLoad()
        print("ratings: \(ratings)")
        
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ratings.count
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "reviewCell") as? ReviewsTableViewCell else {
            fatalError("Could not dequeue a cell")
        }
        let rating = ratings[indexPath.row]
        
        if(rating.review != "" && !rating.review.isEmpty) {
            cell.tableTextLabel.text = rating.review
        }
        
        return cell
    }


    func loadReviews(completion: @escaping ([ReviewInformation]) -> Void){
        db.collection("Ratings").whereField("barName", isEqualTo: barName)
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    var rateArray:[ReviewInformation] = []
                    for document in querySnapshot!.documents {
                        
                        let rating = document.data()["rating"] as! Double
                        let review = "\"" + (document.data()["review"] as! String) + "\""
                        let barName = document.data()["barName"] as! String
                        let userID = document.data()["userID"] as! String
                        let vibes = document.data()["vibes"] as! [String]
                        
                        let newRating = ReviewInformation.init(review: review,rating: rating,vibes: vibes,barName: barName,userId: userID)
                        print(newRating.barName)
                        print(newRating.review)

                        
                        rateArray.append(newRating)
                    }
                    
                    completion(rateArray)
                }
        }
    }

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if let newView = segue.destination as? BarRateViewController {
            newView.barName = barName
            newView.address = address
            newView.popularity = popularity
            newView.overallRating = overallRating
            newView.numRatings = numRatings
        }
        
    }
    

}
