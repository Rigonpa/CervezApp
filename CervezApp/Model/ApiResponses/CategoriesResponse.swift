//
//  CategoriesResponse.swift
//  CervezApp
//
//  Created by Ricardo González Pacheco on 04/11/2020.
//  Copyright © 2020 Ricardo González Pacheco. All rights reserved.
//

import Foundation

struct CategoriesResponse: Codable {
    let message: String
    let data: [BeerCategory]
    let status: String
}

struct BeerCategory: Codable {
    let id: Int
    let name: String
    let createDate: String
}
