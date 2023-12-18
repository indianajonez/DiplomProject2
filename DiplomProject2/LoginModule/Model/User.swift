//
//  User.swift
//  DiplomProject2
//
//  Created by Ekaterina Saveleva on 19.11.2023.
//

import UIKit

struct User: Codable {
    
    //MARK: - Public properties
    
    var login: String
    var name: String?
    var fullName: String?
    //var avatar: UIImage?
    var age: String?
    var aboutUser: String?
    
    
    //MARK: - Life cycls
    
//    init(login: String, fullName: String, avatar: UIImage = UIImage(), age: String = " ", aboutUser: String = " ", name: String = " ") {
//        self.name = name
//        self.login = login
//        self.fullName = fullName
//        self.avatar = avatar
//        self.aboutUser = aboutUser
//        self.age = age
 
//    }
}
