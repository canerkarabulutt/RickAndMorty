//
//  CharacterDetailViewController.swift
//  RickAndMorty
//
//  Created by Caner Karabulut on 14.12.2023.
//

import UIKit

class CharacterDetailViewController: UIViewController {
    //MARK: - Properties
    private let viewModel: RMCharacterDetailViewModel
    
    init(viewModel: RMCharacterDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
}
//MARK: - Helpers
extension CharacterDetailViewController {
    private func style() {
        view.backgroundColor = .systemBackground
        title = viewModel.title
    }
    private func layout() {
        
    }
}
