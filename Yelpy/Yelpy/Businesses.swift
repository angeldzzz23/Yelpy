//
//  Businesses.swift
//  Yelpy
//
//  Created by Angel Zambrano on 9/14/22.

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)


import Foundation


import Foundation

// MARK: - Welcome
struct Response: Codable {
    let businesses: [Business]
    let total: Int
}

// MARK: - Business
struct Business: Codable {
    let id, alias, name: String
    let imageURL: String
    let isClosed: Bool
    let url: String
    let reviewCount: Int
    let categories: [Category]
    let rating: Double
    let coordinates: Coordinates
    let transactions: [Transaction]
    let price: Price?
    let location: Location
    let phone, displayPhone: String

    enum CodingKeys: String, CodingKey {
        case id, alias, name
        case imageURL = "image_url"
        case isClosed = "is_closed"
        case url
        case reviewCount = "review_count"
        case categories, rating, coordinates, transactions, price, location, phone
        case displayPhone = "display_phone"
    }
}

// MARK: - Category
struct Category: Codable {
    let alias, title: String
}

// MARK: - Coordinates
struct Coordinates: Codable {
    let latitude, longitude: Double
}

// MARK: - Location
struct Location: Codable {
    let address1: String
    let address2, address3: String?
    let city: City
    let zipCode: String
    let country: Country
    let state: State
    let displayAddress: [String]

    enum CodingKeys: String, CodingKey {
        case address1, address2, address3, city
        case zipCode = "zip_code"
        case country, state
        case displayAddress = "display_address"
    }
}

enum City: String, Codable {
    case sanFrancisco = "San Francisco"
}

enum Country: String, Codable {
    case us = "US"
}

enum State: String, Codable {
    case ca = "CA"
}

enum Price: String, Codable {
    case empty = "$"
    case price = "$$"
}

enum Transaction: String, Codable {
    case delivery = "delivery"
    case pickup = "pickup"
    case restaurantReservation = "restaurant_reservation"
}
