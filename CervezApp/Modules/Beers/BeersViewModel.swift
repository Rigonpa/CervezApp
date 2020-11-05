//
//  BeersViewModel.swift
//  CervezApp
//
//  Created by Ricardo González Pacheco on 04/11/2020.
//  Copyright © 2020 Ricardo González Pacheco. All rights reserved.
//

import Foundation

protocol BeersViewDelegate: class {
    func refreshTable()
}

class BeersViewModel {
    
    var beerItemViewModels = [BeerItemViewModel]()
    
    weak var viewDelegate: BeersViewDelegate?
    
    let dataManager: BeersDataManager
    init(dataManager: BeersDataManager) {
        self.dataManager = dataManager
    }
    
    func viewDidLoad(categoryId: Int) {
        dataManager.getBeers(by: categoryId) {[weak self] response in
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
    
    func didSelectItemAt(indexPath: IndexPath) {
        print("Next stepppp")
    }
    
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfItems() -> Int {
        return beerItemViewModels.count
    }
    
    func cellForItemAt(indexPath: IndexPath) -> BeerItemViewModel? {
        if (indexPath.item < beerItemViewModels.count) {
            return beerItemViewModels[indexPath.item]
        } else {
            return nil
        }
    }
}
