//
//  BeersResponse.swift
//  CervezApp
//
//  Created by Ricardo González Pacheco on 04/11/2020.
//  Copyright © 2020 Ricardo González Pacheco. All rights reserved.
//

import Foundation

struct BeersResponse: Codable {
    let data: [ApiBeer]
    let status: String
}

struct ApiBeer: Codable {
    let id: String
    let labels: MediumLabel?
    let style: Style?
}

struct MediumLabel: Codable {
    let medium: String
}

struct Style: Codable {
    let category: BeerCategory
    let name: String
    let description: String
}
