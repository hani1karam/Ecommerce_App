//
//  ViewController.swift
//  Ecommerce_App
//
//  Created by Hany Karam on 5/6/20.
//  Copyright © 2020 Hany Karam. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
class ViewController: UIViewController {
    //phone number
    @IBOutlet weak var PhoneNumberTextField: UITextField!
    //password
    @IBOutlet weak var PasswordTextField: UITextField!
    //sign in button
    @IBOutlet weak var SignInButton: UIButton!
    //Register Button
    @IBOutlet weak var SignUpButtton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //change style button (sign in)
        SignInButton.layer.borderColor = #colorLiteral(red: 1, green: 0.5082569122, blue: 0.1457059681, alpha: 1)
        SignInButton.layer.cornerRadius = 5
        SignInButton.layer.cornerRadius = 30
        SignInButton.layer.borderWidth = 6
        
        
        
    }
    
    //push to Register View Controller
    @IBAction func SignUpButton(_ sender: Any) {
        let ToRehister = RegisterVC.instance()
        ToRehister.modalPresentationStyle = .fullScreen
        self.present(ToRehister, animated: true, completion: nil)
        
    }
    // when click login
    @IBAction func LoginButton(_ sender: Any) {
        let param = ["phone":PhoneNumberTextField.text ?? "",
                     "password":PasswordTextField.text ?? ""]
        startAnimation()
        NetworkManager.LoginUser(userInfoDict: param) { (respone, err) in
            if err == nil {
                if respone!.status!
                {
                    NetworkHelper.accessToken = respone?.accessToken ?? "" 
                    
                 let HomeVC = MainTabBar.instance()
                                                   HomeVC.modalPresentationStyle = .fullScreen
                                                   self.present(HomeVC, animated: true, completion: nil)
                    
                    
                }
                else {
                    let alert = UIAlertController(title: "Some Error", message: "Enter Data!", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    
                }
            }
            
        }
        
    }
    
    @IBAction func GoToHome(_ sender: Any) {
        let HomeVC = MainTabBar.instance()
                                          HomeVC.modalPresentationStyle = .fullScreen
                                          self.present(HomeVC, animated: true, completion: nil)

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
//0592108571
//123123
