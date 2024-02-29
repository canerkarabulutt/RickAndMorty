//
//  RMLocationViewModel.swift
//  RickAndMorty
//
//  Created by Caner Karabulut on 29.02.2024.
//

import Foundation

protocol RMLocationViewModelDelegate: AnyObject {
    func didFetchInitialLocations()
}

class RMLocationViewModel {
    
    weak var delegate: RMLocationViewModelDelegate?
    
    private var locations: [RMLocation] = []
    //Location response info
    //Will contain next url, if present (sayfalandırma için bir sonraki URL'yi seçeceğiz)
    
    private var apiInfo: RMGetAllLocationsResponse.Info?
    
    private var cellViewModels: [String] = []
    init() {}
    
    public func fetchLocations() {
        let request = RMRequest(endpoint: .location)
        RMService.shared.execute(request, expecting: RMGetAllLocationsResponse.self) { [weak self] result in
            switch result {
                case .success(let model):
                    self?.apiInfo = model.info
                    self?.locations = model.results
                    DispatchQueue.main.async {
                        self?.delegate?.didFetchInitialLocations()
                    }
                case .failure(let model):
                    break
            }
        }
    }
    
    private var hasMoreResults: Bool {
        return false
    }
}
