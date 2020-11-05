//
//  CategoriesViewModel.swift
//  CervezApp
//
//  Created by Ricardo González Pacheco on 04/11/2020.
//  Copyright © 2020 Ricardo González Pacheco. All rights reserved.
//

import Foundation

class CategoriesViewModel {
    
    var categoryCellViewModels = [CategoryCellViewModel]()
    
    let dataManager: CategoriesDataManager
    init(dataManager: CategoriesDataManager) {
        self.dataManager = dataManager
    }
    
    func viewDidLoad() {
        dataManager
    }
    
    func didSelectRowAt() {
        
    }
    
    func numberOfSections() -> Int {
        
    }
    
    func numberOfRows() -> Int {
        
    }
    
    func cellForRowAt() -> CategoryCellViewModel? {
        
    }
}
