//
//  CartTVC.swift
//  Ecommerce_App
//
//  Created by Hany Karam on 5/8/20.
//  Copyright © 2020 Hany Karam. All rights reserved.
//

import UIKit

class CartTVC: UITableViewCell {
    @IBOutlet weak var img: UIImageView!
    
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var view: UIView!
    var product:Item?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        ui()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func ui() {
        view.backgroundColor = UIColor.white
        contentView.backgroundColor = UIColor(red: 240/255.0, green: 240/255.0, blue: 240/255.0, alpha: 1.0)
        view.layer.cornerRadius = 3.0
        view.layer.masksToBounds = false
        view.layer.shadowColor = UIColor.black.withAlphaComponent(0.2).cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        
        view.layer.shadowOpacity = 0.8
        
    }
    
    func configure(item: Item) {
        self.product = item
        guard let imgURL = item.product_image, let qnt = item.quantity, let priceString = item.price, let price = Double(priceString) else{return}
        self.name.text = item.product_name
        func configure(compines: Datum) {
            
            DispatchQueue.main.async {
                if let img = compines.image{
                    self.img.setImage(imageUrl: img)
                }
            }
        }
        
        
    }
}
