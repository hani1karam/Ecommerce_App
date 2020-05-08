//
//  Details.swift
//  Ecommerce_App
//
//  Created by Hany Karam on 5/7/20.
//  Copyright © 2020 Hany Karam. All rights reserved.
//

import Foundation

// MARK: - Details
struct Details: Codable {
    let status: Bool?
    let message: String?
    let data: DetailsDataClass?
}

// MARK: - DataClass
struct DetailsDataClass: Codable {
    let currentPage: Int?
    let data: [Datum]
    let firstPageURL: String?
    let from, lastPage: Int?
    let lastPageURL: String?
    let nextPageURL: JSONNul?
    let path: String?
    let perPage: Int?
    let prevPageURL: JSONNul?
    let to, total: Int?

    enum CodingKeys: String, CodingKey {
        case currentPage = "current_page"
        case data
        case firstPageURL = "first_page_url"
        case from
        case lastPage = "last_page"
        case lastPageURL = "last_page_url"
        case nextPageURL = "next_page_url"
        case path
        case perPage = "per_page"
        case prevPageURL = "prev_page_url"
        case to, total
    }
}

// MARK: - Datum
struct Datum: Codable {
    let id: Int?
    let slug: String?
    let companyID: Int?
    let name, datumDescription, unit: String?
    let image: String?
    let size, price, newPrice: String?
    let rate, available, deliveryPrice: Int?
    let characteristics: [Characteristic]
    let company: Compani?

    enum CodingKeys: String, CodingKey {
        case id, slug
        case companyID = "company_id"
        case name
        case datumDescription = "description"
        case unit, image, size, price
        case newPrice = "new_price"
        case rate, available
        case deliveryPrice = "delivery_price"
        case characteristics, company
    }
}

// MARK: - Characteristic
struct Characteristic: Codable {
    let name, value: String?
}

// MARK: - Company
struct Compani: Codable {
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

// MARK: - Encode/decode helpers

class JSONNul: Codable, Hashable {

    public static func == (lhs: JSONNul, rhs: JSONNul) -> Bool {
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
