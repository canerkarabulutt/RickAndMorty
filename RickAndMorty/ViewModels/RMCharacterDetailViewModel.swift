//
//  RMCharacterDetailViewModel.swift
//  RickAndMorty
//
//  Created by Caner Karabulut on 14.12.2023.
//

import Foundation

class RMCharacterDetailViewModel {
    private let character: RMCharacter
    init(character: RMCharacter) {
        self.character = character
    }
    public var title: String {
        character.name.uppercased()
    }
}
