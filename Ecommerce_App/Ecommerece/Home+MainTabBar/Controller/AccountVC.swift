//
//  AccountVC.swift
//  Ecommerce_App
//
//  Created by Hany Karam on 5/8/20.
//  Copyright © 2020 Hany Karam. All rights reserved.
//

import UIKit

class AccountVC: UIViewController {
    var header = ["Authorization": "Bearer\(NetworkHelper.getAccessToken() ?? "" )"]
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var phoneTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadUserProfile()
        
    }
    
    
    func loadUserProfile() {
        NetworkApi.sendRequest(method: .get, url: Profile, header: header, completion: { (err, status, response: UserResponse?) in
            if err == nil{
                if status!{
                    if let user = response?.data{
                        DispatchQueue.main.async {
                            self.nameTextField.text = user.name
                            self.emailTextField.text = user.email
                            self.phoneTextField.text = user.phone
                        }
                    }
                }else{
                }
            }else{
            }
        })
    }
    
    @IBAction func DonUpdateInformation(_ sender: Any) {
        
        let param = ["name": nameTextField.text ?? "", "email": emailTextField.text ?? "", "phone": phoneTextField.text ?? ""]
        NetworkApi.sendRequest(method: .post, url: updateProfile, parameters: param, header: header, completion: { (err,status,response: UserResponse?) in
            if err == nil{
                guard let msg = response?.message else{return}
                if status!{
                    guard let name  = response?.data?.name,
                        let phone   = response?.data?.phone,
                        let email   = response?.data?.email else{return}
                    let alert = UIAlertController(title: "شكرا لك", message: "تم التعديل بنجاح", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "تم", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    
                    UserDefaults.standard.synchronize()
                }else{
                }
            }else{
            }
        })
    }
    
}

 
