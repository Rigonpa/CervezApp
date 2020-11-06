//
//  DetailNameCell.swift
//  CervezApp
//
//  Created by Ricardo González Pacheco on 05/11/2020.
//  Copyright © 2020 Ricardo González Pacheco. All rights reserved.
//

import UIKit

class DetailNameCell: UITableViewCell {
    
    lazy var favButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = .clear
        btn.addTarget(self, action: #selector(handleFavPressed), for: .touchUpInside)
        return btn
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12)
        label.backgroundColor = #colorLiteral(red: 0.922343063, green: 0.922343063, blue: 0.922343063, alpha: 1)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.layer.cornerRadius = 4
        label.layer.masksToBounds = true
        return label
    }()
    
    static var cellIdentifier: String = String(describing: DetailNameCell.self)
    
    var viewModel: DetailNameCellViewModel? {
        didSet {
            guard let viewModel = self.viewModel else { return }
            
            if let isFavourite = viewModel.isFavouriteBeer(), isFavourite {
                // Initially no action required, only when button is pressed. Only button image changes.
                let largeConfig = UIImage.SymbolConfiguration(pointSize: 32, weight: .medium, scale: .large)
                let starImage = UIImage(systemName: "star.fill", withConfiguration: largeConfig)
                favButton.setImage(starImage, for: .normal)
            } else {
                // Initially no action required, only when button is pressed. Only button image changes.
                let largeConfig = UIImage.SymbolConfiguration(pointSize: 32, weight: .medium, scale: .large)
                let starImage = UIImage(systemName: "star", withConfiguration: largeConfig)
                favButton.setImage(starImage, for: .normal)
            }
            
            nameLabel.text = viewModel.name
            
            setupUI()
        }
    }
    
     @objc fileprivate func handleFavPressed() {
        guard let viewModel = self.viewModel else { return }
        
        if let isFavourite = viewModel.isFavouriteBeer(), isFavourite {
            // Delete action
            viewModel.changeToNotFavBeer()
            
            let largeConfig = UIImage.SymbolConfiguration(pointSize: 32, weight: .medium, scale: .large)
            let starImage = UIImage(systemName: "star.fill", withConfiguration: largeConfig)
            favButton.setImage(starImage, for: .normal)
        } else {
            // Save as favourite action
            viewModel.changeToFavBeer()
            
            let largeConfig = UIImage.SymbolConfiguration(pointSize: 32, weight: .medium, scale: .large)
            let starImage = UIImage(systemName: "star", withConfiguration: largeConfig)
            favButton.setImage(starImage, for: .normal)
        }
    }
    
    fileprivate func setupUI() {
        backgroundColor = .white
        layer.borderWidth = 1
        layer.borderColor = UIColor.gray.withAlphaComponent(0.2).cgColor
        layer.cornerRadius = 8
        layer.masksToBounds = true
        
        addSubview(nameLabel)
        addSubview(favButton)
        
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            nameLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
//            nameLabel.heightAnchor.constraint(equalToConstant: 100),
            
            favButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),
            favButton.topAnchor.constraint(equalTo: topAnchor),
            favButton.bottomAnchor.constraint(equalTo: bottomAnchor),
//            favButton.widthAnchor.constraint(equalToConstant: 64),
//            favButton.heightAnchor.constraint(equalToConstant: 64)
        ])
    }
}
