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
    
    // Need to write here beersVM to refresh beers list
    // when back button of beer details view controller is pressed:
    var favouritesViewModel: BeersViewModel?
    
    init(presenter: UINavigationController,
         favouritesDataManager: BeersDataManager,
         beerDetailDataManager: BeerDetailDataManager) {
        self.presenter = presenter
        self.favouritesDataManager = favouritesDataManager
        self.beerDetailDataManager = beerDetailDataManager
    }
    
    override func start() {
        favouritesViewModel = BeersViewModel(dataManager: favouritesDataManager)
        guard let favouritesViewModel = self.favouritesViewModel else { return }
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

//extension FavouritesCoordinator: BeerDetailCoordinatorDelegate {
//    func backToBeersList() {
//        favouritesViewModel?.getBeersOfSpecificCategory()
//        favouritesViewModel?.getFavouriteBeers()
//        presenter.popViewController(animated: true)
//    }
//}
