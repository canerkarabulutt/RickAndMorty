//
//  RMCharacterStatus.swift
//  RickAndMorty
//
//  Created by Caner Karabulut on 12.12.2023.
//

import Foundation

enum RMCharacterStatus: String, Codable {
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "Unknown"
    
    var text: String {
        switch self {
            case .alive, .dead:
                return rawValue
            case .unknown:
                return "Unknown"
        }
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let rawValue = try container.decode(String.self)

        switch rawValue {
        case "Alive", "Dead":
            self = .init(rawValue: rawValue)!
        default:
            self = .unknown
        }
    }
}
