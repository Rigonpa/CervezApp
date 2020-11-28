//
//  BeerDetailViewModel.swift
//  CervezApp
//
//  Created by Ricardo González Pacheco on 04/11/2020.
//  Copyright © 2020 Ricardo González Pacheco. All rights reserved.
//

import Foundation

//protocol BeerDetailCoordinatorDelegate: class {
//    func backToBeersList()
//}

protocol BeerDetailViewDelegate: class {
    func refreshTable()
}

class BeerDetailViewModel {
    
    var cellViewModels = [CellViewModel]()
    var beer: Beer?
    
    weak var viewDelegate: BeerDetailViewDelegate?
//    weak var coordinatorDelegate: BeerDetailCoordinatorDelegate?
    
    let dataManager: BeerDetailDataManager
    init(dataManager: BeerDetailDataManager) {
        self.dataManager = dataManager
    }
    
    func viewDidLoad(beerId: String) {
        cellViewModels.removeAll(keepingCapacity: false)
        dataManager.getBeer(id: beerId) {[weak self] (response) in
            switch response {
            case .success(let beerDetailResponse):
                guard let beerDetails = beerDetailResponse else { return }
                self?.beer = beerDetails
                self?.cellViewModels.insert(DetailImageCellViewModel(imageUrl: beerDetails.imageUrl), at: 0)
                let detailNameCellViewModel = DetailNameCellViewModel(name: beerDetails.name)
                detailNameCellViewModel.cellDelegate = self
                self?.cellViewModels.insert(detailNameCellViewModel, at: 1)
                self?.cellViewModels.insert(DetailDescCellViewModel(description: beerDetails.description), at: 2)
                self?.viewDelegate?.refreshTable()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
//    func backToBeersList() {
//        coordinatorDelegate?.backToBeersList()
//    }
    
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfRows() -> Int {
        return cellViewModels.count
    }
    
    func cellForRowAt(indexPath: IndexPath) -> CellViewModel? {
        if indexPath.row < cellViewModels.count {
            return cellViewModels[indexPath.row]
        } else {
            return nil
        }
    }
}

extension BeerDetailViewModel: DetailBeerCellDelegate {
    func isFavouriteBeer() -> Bool {
        guard let beer = self.beer else { fatalError() }
        let favBeer = dataManager.fetchFavouriteBeer(by: beer.id)
        return favBeer != nil
    }
    
    func changeToNotFavBeer() {
        guard let beer = self.beer else { fatalError() }
        dataManager.deleteFavouriteBeer(by: beer.id)
        self.viewDidLoad(beerId: beer.id)
        
//        coordinatorDelegate?.backToBeersList()
        
    }
    
    func changeToFavBeer() {
        guard let beer = self.beer else { fatalError() }
        dataManager.saveFavouriteBeer(beer: beer)
        self.viewDidLoad(beerId: beer.id)
        
//        coordinatorDelegate?.backToBeersList()
        
    }
}
