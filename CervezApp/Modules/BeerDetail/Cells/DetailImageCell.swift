//
//  DetailImageCell.swift
//  CervezApp
//
//  Created by Ricardo González Pacheco on 05/11/2020.
//  Copyright © 2020 Ricardo González Pacheco. All rights reserved.
//

import UIKit

class DetailImageCell: UITableViewCell {
    
    lazy var beerImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.backgroundColor = .white
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    static var cellIdentifier: String = String(describing: DetailImageCell.self)
    
    var viewModel: DetailImageCellViewModel? {
        didSet {
            guard let viewModel = self.viewModel else { return }
            viewModel.detailImageCellViewDelegate = self
            
            beerImageView.image = viewModel.beerImage
            
            setupUI()
        }
    }
    
    fileprivate func setupUI() {
        backgroundColor = .white
        layer.borderWidth = 1
        layer.borderColor = UIColor.gray.withAlphaComponent(0.2).cgColor
        layer.cornerRadius = 8
        layer.masksToBounds = true
        
        addSubview(beerImageView)
        
        NSLayoutConstraint.activate([
            beerImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            beerImageView.topAnchor.constraint(equalTo: topAnchor),
            beerImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            beerImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}

extension DetailImageCell: DetailImageCellViewDelegate {
    func showBeerImage() {
        guard let viewModel = self.viewModel else { return }

        beerImageView.image = viewModel.beerImage
    }
}
