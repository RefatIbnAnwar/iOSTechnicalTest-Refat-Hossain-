//
//  GallaryCollectionViewCell.swift
//  iOSTechnicalTest
//
//  Created by iMac on 12/3/18.
//  Copyright © 2018 mcc. All rights reserved.
//

import UIKit

class GallaryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageview: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func prepareForReuse() {
        self.imageview.image = nil
    }
    
}
