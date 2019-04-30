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
    var overallRating:Double = 0
    var numRatings = 0
    //Vibe list
    let vibeArray:[String] = ["Cheap", "Chill", "DJ", "Party", "Dance Floor", "Good Music", "Loud", "Packed", "Sports"];
    //Selected list of vibes
    var selectedVibes:[String] = [];
    var ratings:[ReviewInformation] = []
    let MAX_CHARS = 128
    
    
    @IBOutlet weak var barNameLabel: UILabel!
    @IBOutlet weak var ratingValueLabel: UILabel!
    @IBOutlet weak var ratingValue: UISlider!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var reviewText: UITextView!
    @IBOutlet weak var curCharCountLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        collectionView.allowsMultipleSelection = true
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        
        //Adding placeholder text
        reviewText.delegate = self
        reviewText.text = "Write a review with max \(MAX_CHARS) chars."
        reviewText.textColor = UIColor.lightGray
        curCharCountLabel.text = "Character count: 0"
        
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
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
        var review = reviewText.text
        
        if(review == "Write a review with max \(MAX_CHARS) chars.") {
            review = ""
        }
        
        let tempRating = String(format: "%.1f", (round((ratingValue.value * 10)) / 10))
        let rating = Double(tempRating)!
        let vibe = selectedVibes
        
        db.collection("Ratings").addDocument(data: [
            "barName": barName,
            "review": review ?? "",
            "rating": rating,
            "vibes": vibe,
            "userID": Auth.auth().currentUser!.uid,
            "timeStamp": FieldValue.serverTimestamp()
        ]) {err in
            if let err = err {
                print("Error adding rating \(err)")
            } else {
                print("Document added with ID: \ref!.documentID")
                self.updateBar()
                self.performSegue(withIdentifier: "rateSubmitted", sender: self)
            }
            
        }
        //Update the bar with new data

        
    }
    
    /*////////////////////////////////////////////////////////
     * MARK: Set of methods that control the functionality of the collection view
     */
    
    //number of views
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return vibeArray.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! VibesCollectionViewCell
        
        //cell.layer.borderColor = UIColor.black.cgColor
        //cell.layer.borderWidth = 2
        cell.isSelected = true
        cell.changeImage(imageName: vibeArray[indexPath.row] + "-selected.png")

        selectedVibes.append(vibeArray[indexPath.row])
        
    }

    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        selectedVibes.removeAll { $0 == vibeArray[indexPath.row]}
        
        let cell = collectionView.cellForItem(at: indexPath) as! VibesCollectionViewCell
        
        //cell.layer.borderColor = UIColor.clear.cgColor
        //cell.layer.borderWidth = 2
        cell.changeImage(imageName: vibeArray[indexPath.row] + ".png")
        cell.isSelected = false
    }
   
    //Populate cells
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! VibesCollectionViewCell;
        cell.cellImage.image = UIImage(named: vibeArray[indexPath.row] + ".png");
        
        
        if(cell.isSelected) {
            //cell.layer.borderColor = UIColor.black.cgColor
            //cell.layer.borderWidth = 2
            cell.isSelected = true
        } else {
            //cell.layer.borderColor = UIColor.clear.cgColor
            //cell.layer.borderWidth = 2
            cell.isSelected = false

        }
        
        return cell;
    }
    //////////////////////////////////////////////////////////
    
    
    //Updates the text to equal the value of the slider directly below it
    func updateRatingLabel() {
        let value = round((ratingValue.value * 10))/10
        let stringValue = String(value)
        ratingValueLabel.text = "Rating: " + (stringValue as String) + " out of 5";
    }
    
    /*
     * Mark: -Methods for textView handling the reviews
     */
    //Creates the max char limit that is set
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText string: String) -> Bool {
        if(string == "\n") {
            textView.resignFirstResponder()
            return false
        }
        
        curCharCountLabel.text = "Character count: " + String(reviewText.text.count)
    
        let newText = (textView.text as NSString).replacingCharacters(in: range, with: string)
        let numberOfChars = newText.count
        return numberOfChars < MAX_CHARS
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if(textView.textColor == UIColor.lightGray) {
            textView.text = nil
            textView.textColor = UIColor.black
            curCharCountLabel.text = "Character count: " + String(reviewText.text.count)
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if(textView.text.isEmpty) {
            textView.text = "Write a review with max \(MAX_CHARS) chars."
            textView.textColor = UIColor.lightGray
            curCharCountLabel.text = "Character count: 0"
        }
        
    }

    
    func updateBar() {

        let noSpaceBarName = barName.replacingOccurrences(of: " ", with: "")
        let docRef = db.collection("Bars").document(noSpaceBarName)

        // get current data from database
        docRef.getDocument { (document, error) in
            if let document = document, document.exists{
                self.numRatings = (document.data()!["numRatings"] as! Int)
                self.overallRating = (document.data()!["overallRating"] as! Double)
                self.popularity = (document.data()!["popularity"] as! Int)
            } else {
                print("Doc does not exist")
            }
        }
        
        //update the vibes for this bar
        var vibeMap:[String : Int] = [:]//["CheapDrinks", "Chill", "DJ", "Party"]
        for vibe in vibeArray {
            vibeMap[vibe] = 0
        }
        
        for rating in ratings {
            for vibe in rating.vibes {
                vibeMap[vibe] = vibeMap[vibe]! + 1
            }
        }
        
        let sortedMap = vibeMap.sorted { (first: (key: String, value: Int), second: (key: String, value: Int)) -> Bool in
            return first.value < second.value
        }
        
        
        //update local bar data
        let tempRating = String(format: "%.1f", (round((ratingValue.value * 10)) / 10))
        let rating = Double(tempRating)!
        
        print("rating being sent: \(rating)")
        print("overallRating: \(overallRating)")
        
        
        numRatings += 1
        overallRating += rating
        popularity += 1
        
        let roundedRating = Double(String(format: "%.1f", (round(overallRating * 10)) / 10))!
        print("add rating: \(roundedRating)")
        
        //update server side bar data
        docRef.updateData([
            "popularity": popularity,
            "overallRating": roundedRating,
            "numRatings": numRatings,
            "vibeRating": "\(sortedMap[0].key), \(sortedMap[1].key)"
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
