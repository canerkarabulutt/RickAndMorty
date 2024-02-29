//
//  RMEpisodeDetailViewModel.swift
//  RickAndMorty
//
//  Created by Caner Karabulut on 28.02.2024.
//

import UIKit

protocol RMEpisodeDetailViewModelDelegate: AnyObject {
    func didFetchEpisodeDetails()
}

class RMEpisodeDetailViewModel {
    //MARK: - Properties
    private let endpointUrl: URL?
        
    private var dataTuple: (RMEpisode, [RMCharacter])? {
        didSet {
            delegate?.didFetchEpisodeDetails()
        }
    }
    enum SectionType {
        case information(viewModels: [RMEpisodeInfoCollectionViewCellViewModel])
        case characters(viewModel: [RMCharacterCollectionViewCellViewModel])
    }
    public weak var delegate: RMEpisodeDetailViewModelDelegate?
    
    public private(set) var sections: [SectionType] = []
    
    //MARK: - Init
    init(endpointUrl: URL?) {
        self.endpointUrl = endpointUrl
    }
    //Fetch backing episode model
    public func fetchEpisodeData() {
        guard let url = endpointUrl, let request = RMRequest(url: url) else { return }
        
        RMService.shared.execute(request, expecting: RMEpisode.self) { [weak self] result in
            switch result {
                case .success(let model):
                    self?.fetchReleatedCharacters(episode: model)
                case .failure:
                    break
            }
        }
    }
    private func fetchReleatedCharacters(episode: RMEpisode) {
        //Karakterlerin her biri için istek başlatmak istiyoruz
        let requests: [RMRequest] = episode.characters.compactMap({
            return URL(string: $0)
        }).compactMap({
            return RMRequest(url: $0)
        })
        // 10 of parallel requests
        //Notified once all done
        let group = DispatchGroup()
        var characters: [RMCharacter] = []
        for request in requests {
            group.enter() // +20 loop (her seferinde döngü sonrası artıracak)
            RMService.shared.execute(request, expecting: RMCharacter.self) { result in
                defer {
                    group.leave() // -20
                }
                switch result {
                    case .success(let model):
                        characters.append(model)
                    case .failure:
                        break
                }
            }
        }
        group.notify(queue: .main) {
            self.dataTuple = (episode, characters)
        }
    }
}
