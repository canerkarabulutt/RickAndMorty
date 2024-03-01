//
//  LocationDetailViewController.swift
//  RickAndMorty
//
//  Created by Caner Karabulut on 29.02.2024.
//

import UIKit

class LocationDetailViewController: UIViewController {
    //MARK: - Properties
    private let viewModel: RMLocationDetailViewModel
    
    private let detailView = RMLocationDetailView()
    //MARK: - Lifecycle
    init(location: RMLocation) {
        let url = URL(string: location.url)
        self.viewModel = RMLocationDetailViewModel(endpointUrl: url)
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
extension LocationDetailViewController {
    @objc private func didTapShare() {
        
    }
}
//MARK: - Helpers
extension LocationDetailViewController {
    private func style() {
        title = "Location"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(didTapShare))
        detailView.delegate = self
        viewModel.delegate = self
        viewModel.fetchLocationData()
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
extension LocationDetailViewController : RMLocationDetailViewModelDelegate, RMLocationDetailViewDelegate {
    //View Delegate
    func rmLocationDetailView(_ detailView: RMLocationDetailView, didSelect character: RMCharacter) {
        let vc = CharacterDetailViewController(viewModel: .init(character: character))
        vc.title = character.name
        navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    //ViewModel Delegate
    func didFetchLocationDetails() {
        detailView.configure(with: viewModel)
    }
}
