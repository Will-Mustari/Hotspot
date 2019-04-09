//
//  BarRateViewController.swift
//  HotSpot
//
//  Created by Kman on 3/23/19.
//  Copyright © 2019 CS506 HotSpot. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore

class BarRateViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UITextViewDelegate {

    
    //Name of bar is passed from previous view
    var barName = ""
    var address = ""
    var popularity = 0
    var currentVibe = ""
    var overallRating:Float = 0
    var numRatings = 0
    //Vibe list
    let vibeArray:[String] = ["CheapDrinks", "Chill", "DJ", "Party"];
    //Selected list of vibes
    var selectedVibes:[String] = [];
    let MAX_CHARS = 128
    
    @IBOutlet weak var barNameLabel: UILabel!
    @IBOutlet weak var ratingValueLabel: UILabel!
    @IBOutlet weak var ratingValue: UISlider!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var reviewText: UITextView!
    @IBOutlet weak var curCharCountLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Initialize Firestore
        let database = Firestore.firestore()
        
        //Initialize text fields
        updateRatingLabel();
        barNameLabel.text = barName;
        curCharCountLabel.text = "Character count: " + String(reviewText.text.count);
        
        //collectionview layout settings
        let itemSize = UIScreen.main.bounds.width/3 - 3
        let layout = UICollectionViewFlowLayout()
        
        layout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 10, right: 0);
        layout.itemSize = CGSize(width: itemSize, height: itemSize)
        layout.minimumInteritemSpacing = 3
        layout.minimumLineSpacing = 3
        collectionView.collectionViewLayout = layout
        
        
    }
    
    @IBAction func ratingValueChanged(_ sender: UISlider) {
        updateRatingLabel()
    }
    
    /*
     * ACTION - press submit rating button
     * Creates barRating object and sends the information
     * to Firebase server.
     */
    @IBAction func submitRatingButton(_ sender: UIButton) {
        //TODO
        let review = reviewText.text;
        let rating = ratingValue.value;
        let vibe = selectedVibes;
        
        var ref: DocumentReference? = nil
        
        ref = db.collection("Ratings").addDocument(data: [
            "barName": barName,
            "review": review ?? "",
            "rating": rating,
            "vibes": vibe,
            "userID": Auth.auth().currentUser!.uid
            
        ]) {err in
            if let err = err {
                print("Error adding rating \(err)")
            } else {
                print("Document added with ID: \ref!.documentID")
            }
            
        }
        //Update the bar with new data
        updateBar()
        performSegue(withIdentifier: "rateSubmitted", sender: self)
        
    }
    
    
    //number of views
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return vibeArray.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedVibes.append(vibeArray[indexPath.row])
    }
    
    //Populate cells
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! VibesCollectionViewCell;
        cell.cellImage.image = UIImage(named: vibeArray[indexPath.row] + ".jpg");
        return cell;
    }
    
    //Updates the text to equal the value of the slider directly below it
    func updateRatingLabel() {
        let value = ratingValue.value;
        let stringValue = NSString(format: "%.2f", value);
        ratingValueLabel.text = "Rating: " + (stringValue as String) + " out of 5";
    }
    
    //Creates the max char limit that is set
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText string: String) -> Bool {
        curCharCountLabel.text = "Character count: " + String(reviewText.text.count)
    
        let newText = (textView.text as NSString).replacingCharacters(in: range, with: string)
        let numberOfChars = newText.count
        return numberOfChars < MAX_CHARS
    }
    
    func updateBar() {

        let noSpaceBarName = barName.replacingOccurrences(of: " ", with: "")
        let docRef = db.collection("Bars").document(noSpaceBarName)
        /*
        var numRatings = 0;
        var overallRating:Float = 0;
        var popularity = 0;
        
        docRef.getDocument { (document, error) in
            if let document = document, document.exists{
                numRatings = (document.data()!["numRatings"] as! Int)
                overallRating = (document.data()!["overallRating"] as! Float)
                popularity = (document.data()!["popularity"] as! Int)
            } else {
                print("Doc does not exist")
            }
        }*/
        
        docRef.updateData([
            "popularity": popularity + 1,
            "overallRating": overallRating + ratingValue.value,
            "numRatings": numRatings + 1
        ]) {err in
            if let err = err {
                print("Error updating data \(err)")
            } else {
                print("Document updated: \ref!.documentID")
            }
            
        }
        
        
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if let newView = segue.destination as? BarSelectViewController {
            newView.barName = barName
            newView.address = address
            newView.popularity = popularity
            newView.overallRating = overallRating
            newView.numRatings = numRatings
        }
    }
    

}
