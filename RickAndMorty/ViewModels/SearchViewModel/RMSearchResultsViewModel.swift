//
//  RMSearchResultsViewModel.swift
//  RickAndMorty
//
//  Created by Caner Karabulut on 29.02.2024.
//

import UIKit

enum RMSearchResultsViewType{
    case characters([RMCharacterCollectionViewCellViewModel])
    case episodes([RMCharacterEpisodeCollectionViewCellViewModel])
    case locations([RMLocationTableViewCellViewModel])
}
