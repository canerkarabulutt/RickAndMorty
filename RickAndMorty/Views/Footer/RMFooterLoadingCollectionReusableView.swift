//
//  RMFooterLoadingCollectionReusableView.swift
//  RickAndMorty
//
//  Created by Caner Karabulut on 14.12.2023.
//

import UIKit

class RMFooterLoadingCollectionReusableView: UICollectionReusableView {
    //MARK: - Properties
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    //MARK: - Lifecycle
    static let identifier = "RMFooterLoadingCollectionReusableView"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        style()
        layout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
//MARK: - Helpers
extension RMFooterLoadingCollectionReusableView {
    private func style() {
        backgroundColor = .systemBackground
    }
    private func layout() {
        addSubview(spinner)
        
        NSLayoutConstraint.activate([
            spinner.widthAnchor.constraint(equalToConstant: 100),
            spinner.heightAnchor.constraint(equalToConstant: 100),
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
    public func startAnimating() {
        spinner.startAnimating()
    }
}
