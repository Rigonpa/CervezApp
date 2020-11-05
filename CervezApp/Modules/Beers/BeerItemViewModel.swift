//
//  BeerItemViewModel.swift
//  CervezApp
//
//  Created by Ricardo González Pacheco on 05/11/2020.
//  Copyright © 2020 Ricardo González Pacheco. All rights reserved.
//

import UIKit

protocol BeerItemViewDelegate: class {
    func showBeerImage()
}

class BeerItemViewModel {
    
    weak var itemViewDelegate: BeerItemViewDelegate?
    
    let beer: Beer
    var beerImage: UIImage?
    init(beer: Beer) {
        self.beer = beer
        
        loadBeerImage()
    }
    
    fileprivate func loadBeerImage() {
        DispatchQueue.global(qos: .userInteractive).async {[weak self] in
            guard let imageUrlString = self?.beer.imageUrl,
            let imageUrl = URL(string: imageUrlString),
                let imageData = try? Data(contentsOf: imageUrl) else {
                    self?.beerImage = UIImage(named: "noBeer")
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        self?.itemViewDelegate?.showBeerImage()
                    }
                    return
            }
            self?.beerImage = UIImage(data: imageData)
            DispatchQueue.main.async {
                self?.itemViewDelegate?.showBeerImage()
            }
        }
    }
}
