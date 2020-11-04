//
//  FavouritesCoordinator.swift
//  CervezApp
//
//  Created by Ricardo González Pacheco on 04/11/2020.
//  Copyright © 2020 Ricardo González Pacheco. All rights reserved.
//

import UIKit

class FavouritesCoordinator: Coordinator {
    
    var presenter: UINavigationController
    var favouritesDataManager: FavouritesDataManager
    
    init(presenter: UINavigationController,
         favouritesDataManager: FavouritesDataManager) {
        self.presenter = presenter
        self.favouritesDataManager = favouritesDataManager
    }
    
    override func start() {
        let favouritesViewModel = FavouritesViewModel(dataManager: favouritesDataManager)
        let favouritesViewController = FavouritesViewController(viewModel: favouritesViewModel)
        
        // Delegates
        
        presenter.pushViewController(favouritesViewController, animated: true)
    }
    
    override func finish() {}
    
}
