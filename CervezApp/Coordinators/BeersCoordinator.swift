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
        categoriesViewModel.viewDelegate = categoriesViewController
        categoriesViewModel.coordinatorDelegate = self
        
        presenter.pushViewController(categoriesViewController, animated: true)
    }
    
    override func finish() {}
}

extension BeersCoordinator: CategoriesCoordinatorDelegate {
    func categorySelected(categoryId: Int) {
        let beersViewModel = BeersViewModel(dataManager: beersDataManager)
        let beersViewController = BeersViewController(viewModel: beersViewModel, categoryId: categoryId)
        
        // Delegates
        beersViewModel.viewDelegate = beersViewController
        
        presenter.pushViewController(beersViewController, animated: true)
    }
}
