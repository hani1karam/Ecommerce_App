//
//  MainTabBar.swift
//  Ecommerce_App
//
//  Created by Hany Karam on 5/7/20.
//  Copyright © 2020 Hany Karam. All rights reserved.
//

import UIKit

class MainTabBar: UITabBarController {
    static func instance () -> MainTabBar {
        let storyboard = UIStoryboard.init(name: "Home", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: "MainTabBar") as! MainTabBar
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        selectedIndex = 2
    }
    
    
}
