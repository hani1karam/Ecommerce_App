//
//  DetailsCell.swift
//  Ecommerce_App
//
//  Created by Hany Karam on 5/7/20.
//  Copyright © 2020 Hany Karam. All rights reserved.
//

import UIKit

class DetailsCell: UITableViewCell {
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var CartButton: UIButton!
    
    var header = ["Authorization": "Bearer\(NetworkHelper.getAccessToken() ?? "" )"]
    var product : Datum?
    var counterItem = 0
    var delegate:CartDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        ui()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    func configure(compines: Datum) {
        
        DispatchQueue.main.async {
            if let img = compines.image{
                self.img.setImage(imageUrl: img)
            }
        }
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
    
    @IBAction func AddToCart(_ sender: Any) {
        guard let id = product?.id else{return}
        
        NetworkApi.sendRequest(method: .get, url: cart, parameters: ["product_id": id], header: header, completion: { (err,status,response: CartResponse?) in
            if err == nil{
                guard let message = response?.message else{return}
                
                if status!{
                    self.counterItem += 1
                    print(message)
                    let alert = UIAlertController(title: "شكرا لك ", message: "تم اضافه المنتج بنجاح", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Click", style: UIAlertAction.Style.default, handler: nil))
                    UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)

                                                   
                }else{
                }
            }
        })
    }
}

