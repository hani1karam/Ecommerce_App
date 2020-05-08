//
//  RegisterModel.swift
//  Ecommerce_App
//
//  Created by Hany Karam on 5/7/20.
//  Copyright © 2020 Hany Karam. All rights reserved.
//

 import Foundation

// MARK: - RegisterModel
struct RegisterModel: Codable {
    let status: Bool?
    let message: String?
    let data: RegisterModelDataClass?
}

// MARK: - DataClass
struct RegisterModelDataClass: Codable {
    let phone: String?
    let activationToken, id: Int?
    let image: String?
    let city: City
    let totalPoints, totalBalance: Int?
    
    enum CodingKeys: String, CodingKey {
        case phone
        case activationToken = "activation_token"
        case id, image, city
        case totalPoints = "total_points"
        case totalBalance = "total_balance"
    }
}

