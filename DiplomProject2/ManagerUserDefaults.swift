//
//  ManagerUserDefaults.swift
//  DiplomProject2
//
//  Created by Ekaterina Saveleva on 18.12.2023.
//

import Foundation

final class ManagerUserDefaults {
    
    static let shared = ManagerUserDefaults()

    private let userDefaults = UserDefaults.standard

    private init() {}
    
    func getSessionStatus() -> Bool {
        userDefaults.bool(forKey: Keys.session.rawValue)
    }
    
    func setSessionStatus(_ status: Bool) {
        userDefaults.set(status, forKey: Keys.session.rawValue)
    }
    
    func saveUser(_ user: User) {
        let encoder = JSONEncoder()
        try? userDefaults.set(encoder.encode(user), forKey: Keys.user.rawValue)
    }
    
    func getUser() -> User? {
        let decoder = JSONDecoder()
        guard let data = userDefaults.data(forKey: Keys.user.rawValue) else {return nil}
        let user = try? decoder.decode(User.self, from: data)
        return user
    }
}

private enum Keys: String {
    case session = "SessionKey"
    case user = "user"
}
