//
//  CustomError.swift
//  CervezApp
//
//  Created by Ricardo González Pacheco on 05/11/2020.
//  Copyright © 2020 Ricardo González Pacheco. All rights reserved.
//

import Foundation

enum CustomError: Error {
    case emptyResponse
    case networkError(Error)
    case decodingError(Error)
}
