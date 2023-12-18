//
//  CharacterViewController.swift
//  RickAndMorty
//
//  Created by Caner Karabulut on 12.12.2023.
//

import UIKit

class CharacterViewController: UIViewController {
    //MARK: - Properties
    private let characterListView = RMCharacterListView()
    //MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
}
//MARK: - Helpers
extension CharacterViewController {

    private func style() {
        view.backgroundColor = .systemBackground
        characterListView.delegate = self
        
    }
    private func layout() {
        view.addSubview(characterListView)
        
        NSLayoutConstraint.activate([
            characterListView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            characterListView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            characterListView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            characterListView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
        ])
    }
}
//MARK: - RMCharacterListViewDelegate Protocol
extension CharacterViewController: RMCharacterListViewDelegate {
    func rmCharacterListView(_ characterListView: RMCharacterListView, didSelectCharacter character: RMCharacter) {
        //Open detail controller for that character
        let viewModel = RMCharacterDetailViewModel(character: character)
        let detailVC = CharacterDetailViewController(viewModel: viewModel)
        detailVC.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
