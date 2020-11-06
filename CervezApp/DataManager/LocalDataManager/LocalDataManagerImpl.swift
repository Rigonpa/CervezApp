//
//  LocalDataManagerImpl.swift
//  CervezApp
//
//  Created by Ricardo González Pacheco on 04/11/2020.
//  Copyright © 2020 Ricardo González Pacheco. All rights reserved.
//

import UIKit
import CoreData

class LocalDataManagerImpl: LocalDataManager {
    lazy var context: NSManagedObjectContext = {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { fatalError()}
        return appDelegate.persistentContainer.viewContext
    }()
    
    var favouriteBeerEntity = "FavouriteBeer"
    
    func fetchFavouriteBeers() -> [Beer]? {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: favouriteBeerEntity)
        guard let favouriteBeers = try? context.fetch(fetchRequest) as? [FavouriteBeer] else { return nil }
        let beers = favouriteBeers.map {
            Beer(id: $0.id ?? "",
                 name: $0.beer_name ?? "",
                 description: $0.beer_description ?? "",
                 category: $0.category_name ?? "",
                 categoryId: Int($0.category_id),
                 imageUrl: $0.image_url ?? "")
        }
        return beers
    }
    
    func saveFavouriteBeer(beer: Beer) {
        guard let entity = NSEntityDescription.entity(forEntityName: favouriteBeerEntity, in: context) else { return }
        let favouriteBeer = FavouriteBeer(entity: entity, insertInto: context)
        favouriteBeer.id = beer.id
        favouriteBeer.beer_name = beer.name
        favouriteBeer.beer_description = beer.description
        favouriteBeer.category_name = beer.category
        favouriteBeer.category_id = Int16(beer.categoryId)
        favouriteBeer.image_url = beer.imageUrl
        
        try? context.save()
    }
    
    func fetchFavouriteBeer(by beerId: String) -> Beer? {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: favouriteBeerEntity)
        fetchRequest.predicate = NSPredicate(format: "id = %@", beerId)
        do {
            guard let favBeer = try context.fetch(fetchRequest) as? [FavouriteBeer] else { return nil }
            let beer = favBeer.map {
                Beer(id: $0.id ?? "",
                     name: $0.beer_name ?? "",
                     description: $0.beer_description ?? "",
                     category: $0.category_name ?? "",
                     categoryId: Int($0.category_id),
                     imageUrl: $0.image_url ?? "")
            }
            return beer.first
        } catch {
            return nil
        }
    }
    
    func deleteFavouriteBeer(by beerId: String) {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: favouriteBeerEntity)
        fetchRequest.predicate = NSPredicate(format: "id = %@", beerId)
        let notFavouriteBeer = try? context.fetch(fetchRequest)
        notFavouriteBeer?.forEach { context.delete($0) }
        
        try? context.save()
    }
}
