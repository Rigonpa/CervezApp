//
//  AppCoordinator.swift
//  CervezApp
//
//  Created by Ricardo González Pacheco on 04/11/2020.
//  Copyright © 2020 Ricardo González Pacheco. All rights reserved.
//

import UIKit

class AppCoordinator: Coordinator {
    
    lazy var remoteDataManager: RemoteDataManager = {
        let dm = RemoteDataManagerImpl()
        return dm
    }()
    
    lazy var localDataManager: LocalDataManager = {
        let dm = LocalDataManagerImpl()
        return dm
    }()
    
    lazy var dataManager: DataManager = {
        let dm = DataManager(remoteDataManager: remoteDataManager, localDataManager: localDataManager)
        return dm
    }()
    
    let window: UIWindow
    init(window: UIWindow) {
        self.window = window
    }
    
    override func start() {
        let tabbar = UITabBarController()
        
        let beersNavigationController = UINavigationController()
        let beersCoordinator = BeersCoordinator(presenter: beersNavigationController,
                                                categoriesDataManager: dataManager,
                                                beersDataManager: dataManager,
                                                beerDetailDataManager: dataManager)
        
        addChildCoordinator(coordinator: beersCoordinator)
        beersCoordinator.start()
        
        let favouritesNavigationController = UINavigationController()
        let favouritesCoordinator = FavouritesCoordinator(presenter: favouritesNavigationController,
                                                          favouritesDataManager: dataManager,
                                                          beerDetailDataManager: dataManager)
        
        addChildCoordinator(coordinator: favouritesCoordinator)
        favouritesCoordinator.start()
        
        tabbar.viewControllers = [beersNavigationController, favouritesNavigationController]
        
        // icons on tab bar:
        beersNavigationController.tabBarItem = UITabBarItem(title: "Beers", image: UIImage(systemName: "list.dash"), tag: 0)
        favouritesNavigationController.tabBarItem = UITabBarItem(title: "Favourites", image: UIImage(systemName: "star.fill"), tag: 1)
        
        
        window.rootViewController = tabbar
        window.makeKeyAndVisible()
    }
}
