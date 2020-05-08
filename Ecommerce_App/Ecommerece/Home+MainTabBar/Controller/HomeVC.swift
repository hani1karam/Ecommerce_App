//
//  HomeVC.swift
//  Ecommerce_App
//
//  Created by Hany Karam on 5/7/20.
//  Copyright © 2020 Hany Karam. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
class HomeVC: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    
    
    
    @IBOutlet weak var SliderCV: UICollectionView!
    @IBOutlet weak var pagecontroller: UIPageControl!
    @IBOutlet weak var HomeCV: UICollectionView!
    
    
    var IamgeArray = ["https://test.otc.net.sa/img/main_slider/assets/images/sliders/5e4778edc7c37.jpg",
                      "https://test.otc.net.sa/img/main_slider/assets/images/sliders/5e47792c746d8.jpg",
                      "https://test.otc.net.sa/img/main_slider/assets/images/sliders/5e47e67b9242f.jpg"] as [String]
    var counter = 0
    var timer = Timer()
    var items = [Company]()
    var index = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pagecontroller.numberOfPages = IamgeArray.count
        pagecontroller.currentPage = 0
        DispatchQueue.main.async {
            self.timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(self.changeImage), userInfo: nil, repeats: true)
            
        }
        // call func compaine
        loadCompaine()
        // Data source && Delegate
        SliderCV.delegate = self
        SliderCV.dataSource = self
        HomeCV.dataSource = self
        HomeCV.delegate = self
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let Deatils = segue.destination as! DetailsVC
        Deatils.item = items[index]
    }
    
    @objc func changeImage() {
        
        if counter < IamgeArray.count {
            let index = IndexPath.init(item: counter, section: 0)
            self.SliderCV.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
            pagecontroller.currentPage = counter
            counter += 1
        } else {
            counter = 0
            let index = IndexPath.init(item: counter, section: 0)
            self.SliderCV.scrollToItem(at: index, at: .centeredHorizontally, animated: false)
            pagecontroller.currentPage = counter
            counter = 1
        }
        
    }
    func loadCompaine(){
        startAnimation()
        NetworkApi.sendRequest(method: .get, url: GET_COMPANIES, completion:
            
            {(err,status,response: Compines?) in
                
                if err == nil{
                    guard let data = response?.data else{return}
                    self.items = data.companies
                    self.HomeCV.reloadData()
                    
                }
        })
        
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == SliderCV {
            return IamgeArray.count
        }
        else {
            return items.count
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == SliderCV{
            let SliderCV = collectionView.dequeueReusableCell(withReuseIdentifier: "SliderCell", for: indexPath)
            if let vc = SliderCV.viewWithTag(111) as? UIImageView {
                vc.loadImageUsingCache(withUrl: "\(IamgeArray[indexPath.row])")
                
            }
            
            return SliderCV
        }
        else {
            let Home = HomeCV.dequeueReusableCell(withReuseIdentifier: "HomeCV", for: indexPath) as! HomeCollectionCell
            Home.name.text = items[indexPath.row].name
            Home.desrcbtion.text = "الحد الادني من التوصيل   \(items[indexPath.row].minAmount ?? 0)"
            Home.configure(compines: self.items[indexPath.row])
            
            return Home
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        index = indexPath.row
        performSegue(withIdentifier: "Home", sender: self)
        
    }
    
}
let imageCache = NSCache<NSString, AnyObject>()

extension UIImageView {
    func loadImageUsingCache(withUrl urlString : String) {
        let url = URL(string: urlString)
        self.image = nil
        
        // check cached image
        if let cachedImage = imageCache.object(forKey: urlString as NSString) as? UIImage {
            self.image = cachedImage
            return
        }
        
        // if not, download image from url
        URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
            if error != nil {
                print(error!)
                return
            }
            
            DispatchQueue.main.async {
                if let image = UIImage(data: data!) {
                    imageCache.setObject(image, forKey: urlString as NSString)
                    self.image = image
                }
            }
            
        }).resume()
    }
    
}
extension UIView{
    func animationZoom(scaleX: CGFloat, y: CGFloat) {
        self.transform = CGAffineTransform(scaleX: scaleX, y: y)
    }
    
    func animationRoted(angle : CGFloat) {
        self.transform = self.transform.rotated(by: angle)
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



 
