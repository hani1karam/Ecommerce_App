//
//  CartResponse.swift
//  Ecommerce_App
//
//  Created by Hany Karam on 5/7/20.
//  Copyright © 2020 Hany Karam. All rights reserved.
//

import Foundation
struct CartResponse: Codable{
    var status:Bool?
    var message:String?
    var data:[Item]?
}

struct Item: Codable{
    var id:Int?
    var product_name:String?
    var product_image:String?
    var quantity:Int?
    var price:String?
    var company:Company?
}
