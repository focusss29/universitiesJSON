//
//  Model.swift
//  universitiesJSON
//
//  Created by Ilya Pogozhev on 18.08.2023.
//

import Foundation

struct CountryData: Codable {
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

struct UniversityDatum: Codable {
    let country: String
    let domains: [String]
    let alphaTwoCode: String?
    let stateProvince: String?
    let webPages: [String]?
    let name: String

    enum CodingKeys: String, CodingKey {
        case country, domains
        case alphaTwoCode = "alpha_two_code"
        case stateProvince = "state-province"
        case webPages = "web_pages"
        case name
    }
}

typealias UniversityData = [UniversityDatum]
