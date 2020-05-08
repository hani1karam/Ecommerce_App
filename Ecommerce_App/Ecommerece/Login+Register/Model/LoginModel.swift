//
//  LoginModel.swift
//  Ecommerce_App
//
//  Created by Hany Karam on 5/7/20.
//  Copyright © 2020 Hany Karam. All rights reserved.
//

import Foundation
 
// MARK: - LoginModel
struct LoginModel: Codable {
    let status: Bool?
    let message, tokenType, expiresIn, accessToken: String?
    let data: LoginModelDataClass?
    
    enum CodingKeys: String, CodingKey {
        case status, message
        case tokenType = "token_type"
        case expiresIn = "expires_in"
        case accessToken = "access_token"
        case data
    }
}

// MARK: - DataClass
struct LoginModelDataClass: Codable {
    let id: Int?
    let name, email, phone: String?
    let image: String?
    let isActive: Int?
    let androidToken: String?
    let iosToken, activationToken: JSONNull?
    let city: City?
    let totalPoints: Double?
    let totalBalance: Int?
    
    enum CodingKeys: String, CodingKey {
        case id, name, email, phone, image
        case isActive = "is_active"
        case androidToken = "android_token"
        case iosToken = "ios_token"
        case activationToken = "activation_token"
        case city
        case totalPoints = "total_points"
        case totalBalance = "total_balance"
    }
}

// MARK: - City
struct City: Codable {
    let id, countryID, regionID: Int?
    let name: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case countryID = "country_id"
        case regionID = "region_id"
        case name
    }
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {
    
    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }
    
    public var hashValue: Int {
        return 0
    }
    
    public init() {}
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
