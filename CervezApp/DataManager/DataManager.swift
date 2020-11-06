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

extension DataManager: CategoriesDataManager {
    func getCategories(completion: @escaping (Result<[BeerCategory]?, CustomError>) -> Void) {
        remoteDataManager?.getBeerCategories(completion: completion)
    }
}

extension DataManager: BeersDataManager {
    func fetchFavouriteBeers() -> [Beer]? {
        return localDataManager?.fetchFavouriteBeers()
    }
    
    func getBeers(by categoryId: Int, completion: @escaping (Result<[Beer]?, CustomError>) -> Void) {
        remoteDataManager?.getBeers(completion: { (response) in
            switch response {
            case .success(let successResponse):
                guard let allBeers = successResponse else { return }
                let filteredBeersByCategory = allBeers.filter {
                    $0.categoryId == categoryId
                }
                completion(.success(filteredBeersByCategory))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
}

extension DataManager: BeerDetailDataManager {
    func saveFavouriteBeer(beer: Beer) {
        localDataManager?.saveFavouriteBeer(beer: beer)
    }
    
    func deleteFavouriteBeer(by beerId: String) {
        localDataManager?.deleteFavouriteBeer(by: beerId)
    }
    
    func fetchFavouriteBeer(by beerId: String) -> Beer? {
        localDataManager?.fetchFavouriteBeer(by: beerId)
    }
    
    func getBeer(id: String, completion: @escaping (Result<Beer?, CustomError>) -> Void) {
        remoteDataManager?.getBeer(id: id, completion: completion)
    }
}


