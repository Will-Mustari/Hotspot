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

class BarRateViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    
    
    var barName = ""
    //Vibe list
    let array:[String] = ["CheapDrinks", "Chill", "DJ", "Party"];
    @IBOutlet weak var barNameLabel: UILabel!
    @IBOutlet weak var ratingValueLabel: UILabel!
    @IBOutlet weak var ratingValue: UISlider!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateRatingLabel()
        //Set label to name given from previous view
        barNameLabel.text = barName;
        
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
    
    func updateRatingLabel() {
        let value = ratingValue.value;
        let stringValue = NSString(format: "%.2f", value);
        ratingValueLabel.text = "Rating: " + (stringValue as String) + " out of 5";
    }
    /*
     * ACTION - press submit rating button
     * Creates barRating object and sends the information
     * to Firebase server.
     */
    @IBAction func submitRatingButton(_ sender: UIButton) {
        //TODO
        
    }
    
    
    //number of views
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return array.count;
    }
    
    //Populate cells
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! VibesCollectionViewCell;
        cell.cellImage.image = UIImage(named: array[indexPath.row] + ".jpg");
        return cell;
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
