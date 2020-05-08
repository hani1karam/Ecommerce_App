//
//  Compines.swift
//  Ecommerce_App
//
//  Created by Hany Karam on 5/7/20.
//  Copyright © 2020 Hany Karam. All rights reserved.
//

import Foundation

// MARK: - Compines
struct Compines: Codable {
    let status: Bool?
    let message: String?
    let data: CompinesDataClass?
}

// MARK: - DataClass
struct CompinesDataClass: Codable {
    let specailCompanies, companies: [Company]
    
    enum CodingKeys: String, CodingKey {
        case specailCompanies = "specail_companies"
        case companies
    }
}

// MARK: - Company
struct Company: Codable {
    let id: Int?
    let slug, name: String?
    let image: String?
    let phone: String?
    let minAmount, minDeliveryAmount, hasFreeDelivery, deliveryPrice: Int?
    let isSpecial: Int?
    
    enum CodingKeys: String, CodingKey {
        case id, slug, name, image, phone
        case minAmount = "min_amount"
        case minDeliveryAmount = "min_delivery_amount"
        case hasFreeDelivery = "has_free_delivery"
        case deliveryPrice = "delivery_price"
        case isSpecial = "is_special"
    }
}
