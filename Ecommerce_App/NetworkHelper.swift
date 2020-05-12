//
//  NetworkHelper.swift
//  Ecommerce_App
//
//  Created by Hany Karam on 5/7/20.
//  Copyright © 2020 Hany Karam. All rights reserved.
//

import Foundation
class NetworkHelper {
    
    static var accessToken: String?{
        didSet{
            UserDefaults.standard.set(accessToken, forKey: "access_token")
        }
    }
    
    static func getAccessToken() -> String? {
        if let accessToken = UserDefaults.standard.value(forKey: "access_token") as? String{
            NetworkHelper.accessToken = accessToken
            print("accessToken: \(accessToken)")
        }
        return NetworkHelper.accessToken
    }
}
