//
//  DetailDescCell.swift
//  CervezApp
//
//  Created by Ricardo González Pacheco on 05/11/2020.
//  Copyright © 2020 Ricardo González Pacheco. All rights reserved.
//

import UIKit

class DetailDescCell: UITableViewCell {
    
    lazy var descLabel: UILabel = {
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
    
    static var cellIdentifier: String = String(describing: DetailDescCell.self)
    
    var viewModel: DetailDescCellViewModel? {
        didSet {
            guard let viewModel = self.viewModel else { return }
            
            descLabel.text = viewModel.description
            
            setupUI()
        }
    }
    
    fileprivate func setupUI() {
        backgroundColor = .white
        layer.borderWidth = 1
        layer.borderColor = UIColor.gray.withAlphaComponent(0.2).cgColor
        layer.cornerRadius = 8
        layer.masksToBounds = true
        
        addSubview(descLabel)
        
        NSLayoutConstraint.activate([
            descLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            descLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            descLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            descLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ])
    }
}

