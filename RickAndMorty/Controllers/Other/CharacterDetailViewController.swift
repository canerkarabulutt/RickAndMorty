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
    
    private let detailView: RMCharacterDetailView
    
    init(viewModel: RMCharacterDetailViewModel) {
        self.viewModel = viewModel
        self.detailView = RMCharacterDetailView(frame: .zero, viewModel: viewModel)
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
//MARK: - Selectors
extension CharacterDetailViewController {
    @objc private func didTapShare() {
        //Share character info
    }
}
//MARK: - Helpers
extension CharacterDetailViewController {
    private func style() {
        view.backgroundColor = .systemBackground
        title = viewModel.title
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(didTapShare))
        detailView.collectionView?.delegate = self
        detailView.collectionView?.dataSource = self
                
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
//MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension CharacterDetailViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.sections.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let sectionType = viewModel.sections[section]
        switch sectionType {
            case .photo:
                return 1
            case .information(let viewModels):
                return viewModels.count
            case .episodes(let viewModels):
                return viewModels.count
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let sectionType = viewModel.sections[indexPath.section]
        switch sectionType {
            case .photo(let viewModel):
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RMCharacterPhotoCollectionViewCell.cellIdentifier, for: indexPath) as? RMCharacterPhotoCollectionViewCell else { fatalError() }
                cell.configure(with: viewModel)
                return cell
            case .information(let viewModels):
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RMCharacterInfoCollectionViewCell.cellIdentifier, for: indexPath) as? RMCharacterInfoCollectionViewCell else { fatalError() }
                cell.configure(with: viewModels[indexPath.row])
                return cell
            case .episodes(let viewModels):
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RMCharacterEpisodeCollectionViewCell.cellIdentifier, for: indexPath) as? RMCharacterEpisodeCollectionViewCell else { fatalError() }
                let viewModel = viewModels[indexPath.row]
                cell.configure(with: viewModel)
                return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sectionType = viewModel.sections[indexPath.section]
        switch sectionType {
            case .photo, .information:
                break
            case .episodes:
                let episodes = self.viewModel.episodes
                let selection = episodes[indexPath.row]
                let vc = EpisodeDetailViewController(url: URL(string: selection))
                navigationController?.pushViewController(vc, animated: true)
        }
    }
}
