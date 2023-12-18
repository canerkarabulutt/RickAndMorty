//
//  RMEndpoint.swift
//  RickAndMorty
//
//  Created by Caner Karabulut on 12.12.2023.
//

import Foundation

//MARK: - Represents unique API endpoint
@frozen enum RMEndpoint : String {
    /// Endpoint to get character, location, episode informations
    case character
    case location
    case episode
}
