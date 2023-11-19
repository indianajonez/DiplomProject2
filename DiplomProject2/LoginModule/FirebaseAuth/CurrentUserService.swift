//
//  CurrentUserService.swift
//  DiplomProject2
//
//  Created by Ekaterina Saveleva on 19.11.2023.
//

import Foundation
import UIKit

class CurrentUserService: UserServiceProtocol {

    //MARK: - Public properties

    var  user: User?

    //MARK: - Init

    init(login: String) {
        self.user = checkLogin(login: login)
    }

    //MARK: - Public methods

    func checkLogin(login: String) -> User? {
        // login == "K" ? User(login: "K", fullName: "Ekaterina", avatar: UIImage(named: "Kate"), age: "")) : nil
        //}
        return user
    }
}
