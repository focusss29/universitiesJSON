//
//  Model.swift
//  universitiesJSON
//
//  Created by Ilya Pogozhev on 18.08.2023.
//

import Foundation

struct CountryResponse: Codable {
    let status: String
    let statusCode: Int
    let version, access: String
    let data: [String: Datum]

    enum CodingKeys: String, CodingKey {
        case status
        case statusCode = "status-code"
        case version, access, data
    }
}

struct Datum: Codable {
    let country: String
    let region: Region
}

enum Region: String, Codable {
    case africa = "Africa"
    case antarctic = "Antarctic"
    case asia = "Asia"
    case centralAmerica = "Central America"
}
