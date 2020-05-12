//
//  UserResponse.swift
//  Ecommerce_App
//
//  Created by Hany Karam on 5/8/20.
//  Copyright © 2020 Hany Karam. All rights reserved.
//

import Foundation
struct UserResponse: Codable{
    var status:Bool?
    var message:String?
    var data:User?
}

struct User: Codable{
    var id:Int?
    var name:String?
    var email:String?
    var phone:String?
    var image:String?
    var total_points:Double?
    var total_balance:Double?
}
