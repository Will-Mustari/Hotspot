//
//  VibesCollectionViewCell.swift
//  HotSpot
//
//  Created by Kman on 3/25/19.
//  Copyright © 2019 CS506 HotSpot. All rights reserved.
//

import UIKit

class VibesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var cellImage: UIImageView!
    
    override var isSelected: Bool {
        didSet {
            if(isSelected == true) {
                //self.layer.borderColor = UIColor.black.cgColor
                //self.layer.borderWidth = 2
                
            } else {
                //self.layer.borderColor = UIColor.clear.cgColor
                //self.layer.borderWidth = 2
            }
        }
    }
    /*
    override func awakeFromNib() {
        super.awakeFromNib()
        isSelected = false
    }*/
    func changeImage(imageName:String) {
        cellImage.image = UIImage(named: imageName);
    }
}
