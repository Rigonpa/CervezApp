//
//  BeersCoordinator.swift
//  CervezApp
//
//  Created by Ricardo González Pacheco on 04/11/2020.
//  Copyright © 2020 Ricardo González Pacheco. All rights reserved.
//

import UIKit

class BeersCoordinator: Coordinator {
    
    var presenter: UINavigationController
    var categoriesDataManager: CategoriesDataManager
    var beersDataManager: BeersDataManager
    var beerDetailDataManager: BeerDetailDataManager
    
    init(presenter: UINavigationController,
         categoriesDataManager: CategoriesDataManager,
         beersDataManager: BeersDataManager,
         beerDetailDataManager: BeerDetailDataManager) {
        self.presenter = presenter
        self.categoriesDataManager = categoriesDataManager
        self.beersDataManager = beersDataManager
        self.beerDetailDataManager = beerDetailDataManager
    }
    
    override func start() {
        let categoriesViewModel = CategoriesViewModel(dataManager: categoriesDataManager)
        let categoriesViewController = CategoriesViewController(viewModel: categoriesViewModel)
        
        // Delegates
        
        presenter.pushViewController(categoriesViewController, animated: true)
    }
    
    override func finish() {}
}
