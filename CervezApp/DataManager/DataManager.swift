//
//  DataManager.swift
//  CervezApp
//
//  Created by Ricardo González Pacheco on 04/11/2020.
//  Copyright © 2020 Ricardo González Pacheco. All rights reserved.
//

import Foundation

class DataManager {
    
    var remoteDataManager: RemoteDataManager?
    var localDataManager: LocalDataManager?
    init(remoteDataManager: RemoteDataManager?, localDataManager: LocalDataManager?) {
        self.remoteDataManager = remoteDataManager
        self.localDataManager = localDataManager
    }
}

extension DataManager: CategoriesDataManager {}

extension DataManager: BeersDataManager {}

extension DataManager: BeerDetailDataManager {}

extension DataManager: FavouritesDataManager {}


