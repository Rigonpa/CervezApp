//
//  BeerItem.swift
//  CervezApp
//
//  Created by Ricardo González Pacheco on 05/11/2020.
//  Copyright © 2020 Ricardo González Pacheco. All rights reserved.
//

import UIKit

class BeerItem: UICollectionViewCell {
    
    lazy var imageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.backgroundColor = .white
        iv.contentMode = .scaleAspectFit
        return iv
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
    
    static var cellIdentifier: String = String(describing: BeerItem.self)
    
    var viewModel: BeerItemViewModel? {
        didSet {
            guard let viewModel = self.viewModel else { return }
            viewModel.itemViewDelegate = self
            
            imageView.image = viewModel.beerImage
            nameLabel.text = viewModel.beer.name
            
            setupUI()
        }
    }
    
    fileprivate func setupUI() {
        backgroundColor = .white
        layer.borderWidth = 1
        layer.borderColor = UIColor.gray.withAlphaComponent(0.2).cgColor
        layer.cornerRadius = 8
        layer.masksToBounds = true
        
        addSubview(nameLabel)
        addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            imageView.heightAnchor.constraint(equalToConstant: 100),
            
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            nameLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ])
    }
}

extension BeerItem: BeerItemViewDelegate {
    func showBeerImage() {
        guard let viewModel = self.viewModel else { return }
        
        imageView.image = viewModel.beerImage
    }
}
