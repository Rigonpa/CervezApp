//
//  TestDataManager.swift
//  CervezApp
//
//  Created by Ricardo González Pacheco on 06/11/2020.
//  Copyright © 2020 Ricardo González Pacheco. All rights reserved.
//

import Foundation

extension BeersViewModel {
    func getTestBeers() {
        guard let beers = dataManager.fetchFavouriteBeers() else { return }
        print(beers)
    }
}
