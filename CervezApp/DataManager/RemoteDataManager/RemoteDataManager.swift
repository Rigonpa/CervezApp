//
//  RemoteDataManager.swift
//  CervezApp
//
//  Created by Ricardo González Pacheco on 04/11/2020.
//  Copyright © 2020 Ricardo González Pacheco. All rights reserved.
//

import Foundation

protocol RemoteDataManager {
    func getBeerCategories(completion: @escaping (Result<[BeerCategory]?, CustomError>) -> Void)
    func getBeers(completion: @escaping (Result<[Beer]?, CustomError>) -> Void)
    func getBeer(id: String, completion: @escaping (Result<Beer?, CustomError>) -> Void)
}
