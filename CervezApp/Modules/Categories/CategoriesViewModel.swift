//
//  CategoriesViewModel.swift
//  CervezApp
//
//  Created by Ricardo González Pacheco on 04/11/2020.
//  Copyright © 2020 Ricardo González Pacheco. All rights reserved.
//

import Foundation

protocol CategoriesCoordinatorDelegate: class {
    func categorySelected(categoryId: Int)
}

protocol CategoriesViewDelegate: class {
    func refreshTable()
}

class CategoriesViewModel {
    
    var categoryCellViewModels = [CategoryCellViewModel]()
    
    weak var viewDelegate: CategoriesViewDelegate?
    weak var coordinatorDelegate: CategoriesCoordinatorDelegate?
    
    let dataManager: CategoriesDataManager
    init(dataManager: CategoriesDataManager) {
        self.dataManager = dataManager
    }
    
    func viewDidLoad() {
        dataManager.getCategories {[weak self] response in
            switch response {
            case .success(let categoriesResponse):
                guard let categories = categoriesResponse else { return }
                self?.categoryCellViewModels = categories.map { CategoryCellViewModel(category: $0)}
                self?.viewDelegate?.refreshTable()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func didSelectRowAt(indexPath: IndexPath) {
        coordinatorDelegate?.categorySelected(categoryId: categoryCellViewModels[indexPath.item].category.id)
    }
    
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfRows() -> Int {
        return categoryCellViewModels.count
    }
    
    func cellForRowAt(indexPath: IndexPath) -> CategoryCellViewModel? {
        if indexPath.row < categoryCellViewModels.count {
            return categoryCellViewModels[indexPath.row]
        } else {
            return nil
        }
    }
}
