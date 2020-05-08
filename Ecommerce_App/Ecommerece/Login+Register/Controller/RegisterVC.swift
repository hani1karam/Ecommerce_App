//
//  RegisterVC.swift
//  Ecommerce_App
//
//  Created by Hany Karam on 5/7/20.
//  Copyright © 2020 Hany Karam. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
class RegisterVC: UIViewController {
    static func instance () -> RegisterVC {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: "RegisterVC") as! RegisterVC
    }
    //phone number
    @IBOutlet weak var PhoneNumberTextField: UITextField!
    //password
    @IBOutlet weak var PasswordTextField: UITextField!
    //confirm password
    @IBOutlet weak var ConfirmPasswordTextField: UITextField!
    //Register Button
    @IBOutlet weak var SignUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //change style button (sign in)
        SignUpButton.layer.borderColor = #colorLiteral(red: 1, green: 0.5082569122, blue: 0.1457059681, alpha: 1)
        SignUpButton.layer.cornerRadius = 5
        SignUpButton.layer.cornerRadius = 30
        SignUpButton.layer.borderWidth = 6
        
    }
    // bach to sing in sing in
    @IBAction func BackToSignIn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    // when click Sign Up
    @IBAction func SignUpButton(_ sender: Any) {
        
        let param = ["phone":PhoneNumberTextField.text ?? "",
                     "password":PasswordTextField.text ?? "",
                     "password_confirmation":ConfirmPasswordTextField.text ?? ""]
        startAnimation()
        NetworkManager.Register(userInfoDict: param) { (respone, err) in
            if err == nil {
                if respone!.status! {
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
