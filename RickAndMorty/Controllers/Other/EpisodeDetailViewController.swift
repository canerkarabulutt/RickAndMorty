//
//  EpisodeDetailViewController.swift
//  RickAndMorty
//
//  Created by Caner Karabulut on 19.12.2023.
//

import UIKit

class EpisodeDetailViewController: UIViewController {
    //MARK: - Properties
    private let viewModel: RMEpisodeDetailViewModel
    
    private let detailView = RMEpisodeDetailView()
    //MARK: - Lifecycle
    init(url: URL?) {
        self.viewModel = RMEpisodeDetailViewModel(endpointUrl: url)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }

}
//MARK: - Selector
extension EpisodeDetailViewController {
    @objc private func didTapShare() {
        
    }
}
//MARK: - Helpers
extension EpisodeDetailViewController {
    private func style() {
        title = "Episode"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(didTapShare))
        detailView.delegate = self
        viewModel.delegate = self
        viewModel.fetchEpisodeData()
    }
    private func layout() {
        view.addSubview(detailView)
        
        NSLayoutConstraint.activate([
            detailView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            detailView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            detailView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            detailView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}
//MARK: - Protocol
extension EpisodeDetailViewController : RMEpisodeDetailViewModelDelegate, RMEpisodeDetailViewDelegate {
    //View Delegate
    func rmEpisodeDetailView(_ detailView: RMEpisodeDetailView, didSelect character: RMCharacter) {
        let vc = CharacterDetailViewController(viewModel: .init(character: character))
        vc.title = character.name
        navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    //ViewModel Delegate
    func didFetchEpisodeDetails() {
        detailView.configure(with: viewModel)
    }
}
