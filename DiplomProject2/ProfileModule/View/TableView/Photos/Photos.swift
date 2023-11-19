//
//  Photos.swift
//  DiplomProject2
//
//  Created by Ekaterina Saveleva on 19.11.2023.
//

import UIKit

struct Photo {
    
    enum TypePhoto {
        case photo
        case friends
    }
    
    //MARK: - Public Properties
    
    let image: UIImage?
    
    //MARK: - Public methods
    
    static func makeCollectionPhotos(type: TypePhoto) -> [Photo] {
        var collection: [Photo] = []
        switch type {
            
        case .photo:
            for image in 0...13 {
                collection.append(Photo(image: UIImage(named: "\(image)")))
            }
        case .friends:
            for image in 14...19 {
                collection.append(Photo(image: UIImage(named: "\(image)")))
            }
        }

        return collection
    }

    static func makeCollectioinPhotos() -> [UIImage] {
        var collection: [UIImage] = []
        for image in 0...13 {
            collection.append( UIImage(named: "\(image)")!)
        }
        return collection
    }
}

