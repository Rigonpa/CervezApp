//
//  DetailImageCellViewModel.swift
//  CervezApp
//
//  Created by Ricardo González Pacheco on 05/11/2020.
//  Copyright © 2020 Ricardo González Pacheco. All rights reserved.
//

import UIKit

protocol DetailImageCellViewDelegate: class {
    func showBeerImage()
}

class DetailImageCellViewModel: CellViewModel {
    
    weak var detailImageCellViewDelegate: DetailImageCellViewDelegate?
    
    let imageUrl: String
    var beerImage: UIImage?
    init(imageUrl: String) {
        self.imageUrl = imageUrl
        super.init()
        
        DispatchQueue.global(qos: .userInteractive).async {[weak self] in
            guard let imageUrlString = self?.imageUrl,
            let imageUrl = URL(string: imageUrlString),
                let imageData = try? Data(contentsOf: imageUrl) else {
                    self?.beerImage = UIImage(named: "noBeer")
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    DispatchQueue.main.async {
                        self?.detailImageCellViewDelegate?.showBeerImage()
                    }
                    return
            }
            self?.beerImage = UIImage(data: imageData)
            DispatchQueue.main.async {
                self?.detailImageCellViewDelegate?.showBeerImage()
            }
        }
    }
}
