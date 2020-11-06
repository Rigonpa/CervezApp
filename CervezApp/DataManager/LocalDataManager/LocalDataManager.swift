//
//  LocalDataManager.swift
//  CervezApp
//
//  Created by Ricardo González Pacheco on 04/11/2020.
//  Copyright © 2020 Ricardo González Pacheco. All rights reserved.
//

import Foundation

protocol LocalDataManager {
    func fetchFavouriteBeers() -> [Beer]?
    func saveFavouriteBeer(beer: Beer)
    func deleteFavouriteBeer(by beerId: String)
    func fetchFavouriteBeer(by beerId: String) -> Beer?
}
