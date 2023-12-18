//
//  RMCharacterGender.swift
//  RickAndMorty
//
//  Created by Caner Karabulut on 12.12.2023.
//

import Foundation

enum RMCharacterGender: String, Codable {
    case male = "Male"
    case female = "Female"
    case genderless = "Genderless"
    case unknown = "Unknown"

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let rawValue = try container.decode(String.self)

        switch rawValue {
        case "Male", "Female", "Genderless":
            self = .init(rawValue: rawValue)!
        default:
            self = .unknown
        }
    }
}
