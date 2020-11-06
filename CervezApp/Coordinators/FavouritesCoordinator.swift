//
//  FavouritesCoordinator.swift
//  CervezApp
//
//  Created by Ricardo González Pacheco on 04/11/2020.
//  Copyright © 2020 Ricardo González Pacheco. All rights reserved.
//

import UIKit

class FavouritesCoordinator: Coordinator {
    
    var presenter: UINavigationController
    var favouritesDataManager: BeersDataManager
    var beerDetailDataManager: BeerDetailDataManager
    
    init(presenter: UINavigationController,
         favouritesDataManager: BeersDataManager,
         beerDetailDataManager: BeerDetailDataManager) {
        self.presenter = presenter
        self.favouritesDataManager = favouritesDataManager
        self.beerDetailDataManager = beerDetailDataManager
    }
    
    override func start() {
        let favouritesViewModel = BeersViewModel(dataManager: favouritesDataManager)
        let favouritesViewController = BeersViewController(viewModel: favouritesViewModel, categoryId: nil)
        
        // Delegates
        favouritesViewModel.viewDelegate = favouritesViewController
        favouritesViewModel.coordinatorDelegate = self
        
        presenter.pushViewController(favouritesViewController, animated: true)
    }
    
    override func finish() {}
    
}

extension FavouritesCoordinator: BeersCoordinatorDelegate {
    func beerSelected(beerId: String) {
        let beerDetailViewModel = BeerDetailViewModel(dataManager: beerDetailDataManager)
        let beersDetailViewController = BeerDetailViewController(viewModel: beerDetailViewModel, beerId: beerId)
        
        // Delegates
        beerDetailViewModel.viewDelegate = beersDetailViewController
//        beerDetailViewModel.coordinatorDelegate = self
        
        presenter.pushViewController(beersDetailViewController, animated: true)
    }
}
