//
//  BeersDataManager.swift
//  CervezApp
//
//  Created by Ricardo González Pacheco on 04/11/2020.
//  Copyright © 2020 Ricardo González Pacheco. All rights reserved.
//

import Foundation

protocol BeersDataManager {
    func getBeers(by categoryId: Int, completion: @escaping (Result<[Beer]?, CustomError>) -> Void)
}
