//
//  RMSearchViewModel.swift
//  RickAndMorty
//
//  Created by Caner Karabulut on 29.02.2024.
//

import Foundation

/// Show search results
/// Show no results view
/// Kick off API requests
class RMSearchViewModel {
    let config: SearchViewController.Config
    
    init(config: SearchViewController.Config) {
        self.config = config
    }
}
