//
//  CategoriesDataManager.swift
//  CervezApp
//
//  Created by Ricardo González Pacheco on 04/11/2020.
//  Copyright © 2020 Ricardo González Pacheco. All rights reserved.
//

import Foundation

protocol CategoriesDataManager {
    func getCategories(completion: @escaping (Result<[BeerCategory]?, CustomError>) -> Void)
}
