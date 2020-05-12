//
//  CartVC.swift
//  Ecommerce_App
//
//  Created by Hany Karam on 5/8/20.
//  Copyright © 2020 Hany Karam. All rights reserved.
//

import UIKit

class CartVC: UIViewController ,UITableViewDelegate,UITableViewDataSource{
    
    
    @IBOutlet weak var CartTableView: UITableView!
    
    var header = ["Authorization": "Bearer\(NetworkHelper.getAccessToken() ?? "" )"]
    var items = [Item]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        CartTableView.delegate = self
        CartTableView.dataSource = self
        loadCart()
        
    }
    
    func loadCart() {
        NetworkApi.sendRequest(method: .get, url: cart, header: header, completion: { (err,status,response: CartResponse?) in
            if err == nil{
                if status!{
                    guard let message = response?.message else{return}
                    
                    print(message)
                }else{
                    // Here you have to Fill the array item with items come from API then reload
                }
                self.items = response?.data as! [Item]
                self.CartTableView.reloadData()
               
                
            }
            
            
        })
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CartVC", for: indexPath) as! CartTVC
        cell.configure(item: items[indexPath.row])
        return cell
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 190
    }
}
