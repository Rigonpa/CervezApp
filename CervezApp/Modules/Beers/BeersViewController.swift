//
//  BeersViewController.swift
//  CervezApp
//
//  Created by Ricardo González Pacheco on 04/11/2020.
//  Copyright © 2020 Ricardo González Pacheco. All rights reserved.
//

import UIKit

class BeersViewController: UIViewController {
    
    // MARK: - Variables
    
    let numberOfColumns: Int = 3
    let sectionInset: CGFloat = 24.0
    let minimumInteritemSpacing: CGFloat = 24.0
    let minimumLineSpacing: CGFloat = 24.0
    
    lazy var customFlowLayout: UICollectionViewFlowLayout = {
        let width: CGFloat = (UIScreen.main.bounds.width - sectionInset*2 - minimumInteritemSpacing*(CGFloat(numberOfColumns) - 1)) / CGFloat(numberOfColumns)
        let fl = UICollectionViewFlowLayout()
        fl.sectionInset = UIEdgeInsets(top: sectionInset, left: sectionInset, bottom: sectionInset, right: sectionInset)
        fl.minimumLineSpacing = minimumLineSpacing
        fl.itemSize = CGSize(width: width, height: width + 100)
        return fl
    }()
    
    lazy var collectionView: UICollectionView = {
        let collectionViewFlowLayout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: customFlowLayout)
        cv.delegate = self
        cv.dataSource = self
        cv.register(BeerItem.self, forCellWithReuseIdentifier: BeerItem.cellIdentifier)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.showsVerticalScrollIndicator = false
        cv.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        return cv
    }()
    
    let viewModel: BeersViewModel
    let categoryId: Int
    init(viewModel: BeersViewModel, categoryId: Int) {
        self.viewModel = viewModel
        self.categoryId = categoryId
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        viewModel.viewDidLoad(categoryId: categoryId)
        
        setupUI()
    }
    
    fileprivate func setupUI() {
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
}

extension BeersViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        viewModel.didSelectItemAt(indexPath: indexPath)
    }
}

extension BeersViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.numberOfSections()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItems()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let item = collectionView.dequeueReusableCell(withReuseIdentifier: BeerItem.cellIdentifier, for: indexPath) as? BeerItem,
            let itemViewModel = viewModel.cellForItemAt(indexPath: indexPath) else { fatalError() }
        
        item.viewModel = itemViewModel
        return item
    }
}

extension BeersViewController: BeersViewDelegate {
    func refreshTable() {
        collectionView.reloadData()
    }
}
