//
//  CategoryCell.swift
//  CervezApp
//
//  Created by Ricardo González Pacheco on 05/11/2020.
//  Copyright © 2020 Ricardo González Pacheco. All rights reserved.
//

import UIKit

class CategoryCell: UITableViewCell {
    
    static var cellIdentifier: String = String(describing: CategoryCell.self)
    
    lazy var categoryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .natural
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    
    var viewModel: CategoryCellViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            categoryLabel.text = viewModel.category.name
            
            updateUI()
        }
    }
    
    fileprivate func updateUI() {
        addSubview(categoryLabel)
        
        NSLayoutConstraint.activate([
            categoryLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            categoryLabel.topAnchor.constraint(equalTo: topAnchor),
            categoryLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 16),
            categoryLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
