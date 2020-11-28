//
//  BeersViewModel.swift
//  CervezApp
//
//  Created by Ricardo González Pacheco on 04/11/2020.
//  Copyright © 2020 Ricardo González Pacheco. All rights reserved.
//

import Foundation

protocol BeersCoordinatorDelegate: class {
    func beerSelected(beerId: String)
}

protocol BeersViewDelegate: class {
    func refreshTable()
}

class BeersViewModel {
    
    var beerItemViewModels = [BeerItemViewModel]()
    var favouriteBeerItemViewModels = [BeerItemViewModel]()
    var categoryId: Int = 0
    
    weak var viewDelegate: BeersViewDelegate?
    weak var coordinatorDelegate: BeersCoordinatorDelegate?
    
    var favSection = false
    
    let dataManager: BeersDataManager
    init(dataManager: BeersDataManager) {
        self.dataManager = dataManager
    }
    
    func viewDidLoad(categoryId: Int?) {
        
        if categoryId != nil, let categId = categoryId {
            self.categoryId = categId
            favSection = false
            getBeersOfSpecificCategory()
        } else {
            favSection = true
            getFavouriteBeers()
        }
    }
    
    func getBeersOfSpecificCategory() {
        dataManager.getBeers(by: self.categoryId) {[weak self] response in
            switch response {
            case .success(let beersResponse):
                guard let beers = beersResponse else { return }
                self?.beerItemViewModels = beers.map { BeerItemViewModel(beer: $0)}
                self?.viewDelegate?.refreshTable()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func getFavouriteBeers() {
//        favouriteBeerItemViewModels.removeAll(keepingCapacity: false) -> Crash when selecting other item before fetch is finished.
        guard let favouriteBeers = dataManager.fetchFavouriteBeers() else { return }
        favouriteBeerItemViewModels = favouriteBeers.map { BeerItemViewModel(beer: $0)}
        viewDelegate?.refreshTable()
    }
    
    func didSelectItemAt(indexPath: IndexPath) {
        
        coordinatorDelegate?.beerSelected(beerId: favSection ?
            favouriteBeerItemViewModels[indexPath.item].beer.id :
            beerItemViewModels[indexPath.item].beer.id)
    }
    
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfItems() -> Int {
        return favSection ? favouriteBeerItemViewModels.count : beerItemViewModels.count
    }
    
    func cellForItemAt(indexPath: IndexPath) -> BeerItemViewModel? {
        
        return favSection ?
        indexPath.item < favouriteBeerItemViewModels.count ? favouriteBeerItemViewModels[indexPath.item] : nil :
        indexPath.item < beerItemViewModels.count ? beerItemViewModels[indexPath.item] : nil
        
    }
}
