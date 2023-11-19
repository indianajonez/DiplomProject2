//
//  CheckService.swift
//  DiplomProject2
//
//  Created by Ekaterina Saveleva on 19.11.2023.
//

import FirebaseAuth

// Абстракция, по которой проходит авторизация/регистрация юзера в систему
protocol CheckerServiceProtocol {
    func logIn(email: String, pass: String, completion: @escaping(User?, _ errorString: String?) -> Void )
    func singUp(email: String, pass: String, completion: @escaping (Bool, _ errorString: String?) -> Void )
    func hasUserSession() -> Bool
    func logout()
}

final class CheckerService: CheckerServiceProtocol {
    
    //MARK: - Public methods
    
    // Зайти в систему с уже зарегистрированными логином и паролем
    func logIn(email: String, pass: String, completion: @escaping (User?, String?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: pass) { authResult , error in
            if let error {
                print(error.localizedDescription)
                DispatchQueue.main.async {
                    completion(nil, error.localizedDescription)
                }
            }
            guard let user = authResult?.user else {
                DispatchQueue.main.async {
                    completion(nil, error?.localizedDescription)
                }
                return
            }
            let newUser = User(login: user.email ?? "", fullName: user.email!)
            completion(newUser, nil)
        }
    }
    
    // Зарегистрироваться в системе с помощью почты и пароля
    func singUp(email: String, pass: String, completion: @escaping (Bool, String?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: pass) { authResult, error in
            if let error = error {
                print(error.localizedDescription)
                let err = error as NSError
                switch err.code {
                case AuthErrorCode.emailAlreadyInUse.rawValue:
                    completion(false, "Такой email уже зарегистрирован")
                case AuthErrorCode.weakPassword.rawValue:
                    completion(false, "Необходимо ввсети пароль длинее")
                default:
                    completion(false, "Что-то пошло не так, попробуйте еще раз")
                }
            } else {
                DispatchQueue.main.async {
                    completion(true, nil)
                }
            }
        }
    }
    
    func hasUserSession() -> Bool {
        guard let _ = Auth.auth().currentUser else {
            return Auth.auth().currentUser != nil //return //false
        }
        return true
    }
    // выйти из системы (firebase)
    func logout() {
        try? Auth.auth().signOut()
        
    }
}

