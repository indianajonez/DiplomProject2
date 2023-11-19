//
//  UserServiceProtocol.swift
//  DiplomProject2
//
//  Created by Ekaterina Saveleva on 19.11.2023.
//

import Foundation

protocol UserServiceProtocol {
    func checkLogin(login: String) -> User?
}
