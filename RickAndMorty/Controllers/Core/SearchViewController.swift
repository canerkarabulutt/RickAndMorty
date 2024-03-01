//
//  SearchViewController.swift
//  RickAndMorty
//
//  Created by Caner Karabulut on 28.02.2024.
//

import UIKit
//Configurable controller to search
class SearchViewController: UIViewController {
    ///Configuration for search session
    struct Config {
        enum ˋTypeˋ {
            case character // name | status | gender
            case episode //allow names
            case location // name | type
            
            var title: String {
                switch self {
                    case .character:
                        return "Search Character"
                    case .episode:
                        return "Search Episode"
                    case .location:
                        return "Search Location"
                }
            }
        }
        let type: ˋTypeˋ
    }
    //MARK: - Properties
    private let viewModel: RMSearchViewModel
    private let searchView: RMSearchView
    
    //MARK: - Lifecycle
    init(config: Config) {
        let viewModel = RMSearchViewModel(config: config)
        self.viewModel = viewModel
        self.searchView = RMSearchView(frame: .zero, viewModel: viewModel)
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
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        searchView.presentKeyboard()
    }
}
extension SearchViewController {
    @objc private func didTapExecuteSearch() {
   //     viewModel.executeSearch()
    }
}
//MARK: - Helpers
extension SearchViewController {
    private func style() {
        title = viewModel.config.type.title
        view.backgroundColor = .systemBackground
        view.addSubview(searchView)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Search", style: .done, target: self, action: #selector(didTapExecuteSearch))
        searchView.delegate = self
    }
    private func layout() {
        NSLayoutConstraint.activate([
            searchView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            searchView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            searchView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}
//MARK: - Protocol
extension SearchViewController: RMSearchViewDelegate {
    func rmSearchView(_ searchView: RMSearchView, didSelectOption option: RMSearchInputViewModel.DynamicOption) {
        print("Should present option picker")
    }
}
