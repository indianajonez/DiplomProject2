//
//  Post2.swift
//  DiplomProject2
//
//  Created by Ekaterina Saveleva on 19.11.2023.
//

import UIKit

public struct Post {
    public var author: String
    public var description: String
    public var image: String
    public var likes: Int
    public var views: Int
    
    
    public init(author: String, description: String, image: String, likes: Int, views: Int) {
        self.author = author
        self.description = description
        self.image = image
        self.likes = likes
        self.views = views
        
    }
}
    
    public struct Post2 {
        
        public let image: UIImage?
        
        public init(image: UIImage?) {
            self.image = image
        }
    }

    //MARK: - Post2
    
    extension Post2 {
        
        public static func make() -> [Post] {
            
            return [
                Post(author: "Марк", description: "I haven't eaten anything yet today.", image: "Марк", likes: 10, views: 110),
                Post(author: "Илон", description: "I've been silent all day. It's hard.", image: "Илон", likes: 132, views: 1119),
                Post(author: "Тим", description: "Fleas and ticks are the worst enemies.", image: "Тим", likes: 15, views: 3210),
                Post(author: "Роберт", description: "Running after the tail. I haven't caught it yet.", image: "Роберт", likes: 150, views: 3290)
            ]
        }
    }

