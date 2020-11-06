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
    
    // Need to write here beersVM to refresh beers list
    // when back button of beer details view controller is pressed:
    var beersViewModel: BeersViewModel?
    
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
        beersViewModel = BeersViewModel(dataManager: beersDataManager)
        guard let beersViewModel = self.beersViewModel else { return }
        
        let beersViewController = BeersViewController(viewModel: beersViewModel, categoryId: categoryId)
        
        // Delegates
        beersViewModel.viewDelegate = beersViewController
        beersViewModel.coordinatorDelegate = self
        
        presenter.pushViewController(beersViewController, animated: true)
    }
}

extension BeersCoordinator: BeersCoordinatorDelegate {
    func beerSelected(beerId: String) {
        let beerDetailViewModel = BeerDetailViewModel(dataManager: beerDetailDataManager)
        let beersDetailViewController = BeerDetailViewController(viewModel: beerDetailViewModel, beerId: beerId)
        
        // Delegates
        beerDetailViewModel.viewDelegate = beersDetailViewController
//        beerDetailViewModel.coordinatorDelegate = self
        
        presenter.pushViewController(beersDetailViewController, animated: true)
    }
}

extension BeersCoordinator: BeerDetailCoordinatorDelegate {
    func backToBeersList() {
        beersViewModel
        presenter.popViewController(animated: true)
    }
}
