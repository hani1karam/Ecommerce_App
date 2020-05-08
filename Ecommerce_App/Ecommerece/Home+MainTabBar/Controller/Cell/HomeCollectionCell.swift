//
//  HomeCollectionCell.swift
//  Ecommerce_App
//
//  Created by Hany Karam on 5/7/20.
//  Copyright © 2020 Hany Karam. All rights reserved.
//

import UIKit

class HomeCollectionCell: UICollectionViewCell {
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var desrcbtion: UILabel!
    func configure(compines: Company) {
        
        DispatchQueue.main.async {
            if let img = compines.image{
                self.img.setImage(imageUrl: img)
            }
        }
    }
    
    
}
