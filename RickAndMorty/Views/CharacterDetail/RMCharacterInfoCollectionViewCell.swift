//
//  RMCharacterInfoCollectionViewCell.swift
//  RickAndMorty
//
//  Created by Caner Karabulut on 18.12.2023.
//

import UIKit

class RMCharacterInfoCollectionViewCell: UICollectionViewCell {
    //MARK: - Properties
    static let cellIdentifier = "RMCharacterInfoCollectionViewCell"
    
    private let valueLabel: UILabel = {
       let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 22, weight: .light)
        return label
    }()
    private let titleLabel: UILabel = {
       let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20, weight: .medium)
        return label
    }()
    private let iconImageView: UIImageView = {
       let icon = UIImageView()
        icon.contentMode = .scaleAspectFit
        return icon
    }()
    private let titleContainerView: UIView = {
       let view = UIImageView()
        view.backgroundColor = .secondarySystemBackground
        return view
    }()
    //MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
       super.prepareForReuse()
       valueLabel.text = nil
       titleLabel.text = nil
       iconImageView.image = nil
       iconImageView.tintColor = .label
       titleLabel.textColor = .label
    }
}
//MARK: - Helpers
extension RMCharacterInfoCollectionViewCell {
    private func style() {
        contentView.backgroundColor = .tertiarySystemBackground
        contentView.layer.cornerRadius = 8
        contentView.layer.masksToBounds = true
        
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        titleContainerView.translatesAutoresizingMaskIntoConstraints = false
        titleContainerView.addSubview(titleLabel)
        
    }
    private func layout() {
        contentView.addSubview(titleContainerView)
        contentView.addSubview(valueLabel)
        contentView.addSubview(iconImageView)
        
        NSLayoutConstraint.activate([
            titleContainerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleContainerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            titleContainerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            titleContainerView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.33),
            
            titleLabel.leadingAnchor.constraint(equalTo: titleContainerView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: titleContainerView.trailingAnchor),
            titleLabel.topAnchor.constraint(equalTo: titleContainerView.topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: titleContainerView.bottomAnchor),
            
            iconImageView.heightAnchor.constraint(equalToConstant: 30),
            iconImageView.widthAnchor.constraint(equalToConstant: 30),
            iconImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            iconImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 35),
            
            valueLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 10),
            valueLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            valueLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            valueLabel.bottomAnchor.constraint(equalTo: titleContainerView.topAnchor),
        ])
    }
    public func configure(with viewModel: RMCharacterInfoCollectionViewCellViewModel) {
        titleLabel.text = viewModel.title
        valueLabel.text = viewModel.displayValue
        iconImageView.image = viewModel.iconImage
        iconImageView.tintColor = viewModel.tintColor
        titleLabel.textColor = viewModel.tintColor
    }
}
