//
//  DetailNameCellViewModel.swift
//  CervezApp
//
//  Created by Ricardo González Pacheco on 05/11/2020.
//  Copyright © 2020 Ricardo González Pacheco. All rights reserved.
//

import Foundation

protocol DetailBeerCellDelegate: class {
    func isFavouriteBeer() -> Bool
    func changeToNotFavBeer()
    func changeToFavBeer()
}

class DetailNameCellViewModel: CellViewModel {
    
    weak var cellDelegate: DetailBeerCellDelegate?
    
    let name: String
    init(name: String) {
        self.name = name
    }
    
    func isFavouriteBeer() -> Bool? {
        return cellDelegate?.isFavouriteBeer()
    }
    
    func changeToNotFavBeer() {
        cellDelegate?.changeToNotFavBeer()
    }
    
    func changeToFavBeer() {
        cellDelegate?.changeToFavBeer()
    }
}
