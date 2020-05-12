//
//  DetailsVC.swift
//  Ecommerce_App
//
//  Created by Hany Karam on 5/7/20.
//  Copyright © 2020 Hany Karam. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

protocol CartDelegate {
    func addedToCart(price: Double, msg: String)
}
class DetailsVC: UIViewController,UITableViewDelegate,UITableViewDataSource{
    
    
    @IBOutlet weak var DetailsTV: UITableView!
    var item:Company?
    var details = [Datum]()
    var delegate:CartDelegate?
    var cartArray = [Item]()
    var product : Datum?
    var counterItem = 0
    var header = ["Authorization": "Bearer\(NetworkHelper.getAccessToken() ?? "" )"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadProducts()
        //  loadCart()
        DetailsTV.delegate = self
        DetailsTV.dataSource = self
        
    }
    
    @IBAction func BackToHome(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        
    }
    
    
    func loadProducts() {
        
        guard let id = item?.id else { return }
        startAnimation()
        NetworkApi.sendRequest(method: .get, url: GET_PRODUCTS+"\(id)", header: header, completion: { (err,status,response: Details?) in
            
            if err == nil{
                if status!{
                    guard let productArray = response?.data?.data else{return}
                    
                    self.details = productArray
                    self.DetailsTV.reloadData()
                }
            }
        })
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return details.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailsCell", for: indexPath) as! DetailsCell
        cell.name.text = details[indexPath.row].name
        cell.price.text = "السعر:  \(details[indexPath.row].price ?? "")"
        cell.configure(compines: self.details[indexPath.row])
        cell.CartButton.tag = indexPath.row
        cell.CartButton.addTarget(self, action: #selector(subscribeTapped(_:)), for: .touchUpInside)
        
        
        return cell
    }
    @objc func subscribeTapped(_ sender: UIButton){
        // use the tag of button as index
        let youtuber = details[sender.tag]
        let alert = UIAlertController(title: "شكرا لك ", message: "تم اضافه المنتج بنجاح: \(youtuber.name)", preferredStyle: .alert)
        let okaction = UIAlertAction(title: "ok", style: .default, handler: nil)
        alert.addAction(okaction)
        
        guard let id = product?.id else{return}
        
        
        NetworkApi.sendRequest(method: .get, url: cart, parameters: ["product_id": id], header: header, completion: { (err,status,response: CartResponse?) in
            if err == nil{
                guard let message = response?.message else{return}
                
                if status!{
                    self.counterItem += 1
                    print(message)
                    
                }else{
                }
            }
        })
    }
    
    
}
extension UIViewController{
    fileprivate func startAnimation() {
        let loading = NVActivityIndicatorView(frame: .zero, type: .ballClipRotatePulse, color: .black, padding: 0)
        loading.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loading)
        NSLayoutConstraint.activate([
            loading.widthAnchor.constraint(equalToConstant: 40),
            loading.heightAnchor.constraint(equalToConstant: 40),
            loading.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loading.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            
        ])
        loading.startAnimating()
        DispatchQueue.main.asyncAfter(deadline:DispatchTime.now() + 2){
            loading.stopAnimating()
        }
    }
}
