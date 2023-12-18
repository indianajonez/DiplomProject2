//
//  LoginViewControllerDelegateProtocol.swift
//  DiplomProject2
//
//  Created by Ekaterina Saveleva on 19.11.2023.
//

import Foundation

//TODO: А кто делегат-то? Этот протокол LoginViewControllerDelegate никто не реализует, значит, его можно удалить. Не используется нигде. Плюс я бы его унифицировал, чтобы он был универсальным. Что-то типа такого: https://stackoverflow.com/questions/43363816/create-alert-function-in-all-view-controllers-swift . Только я бы еще добавил возможность отрисовываться без текст филдов, с n количество текст филдов, в комплишен, если он нужен, передавать дженерик. Ну а если это сложно, тогда проще показывать алерт нативно, без объектов-оберток.

protocol LoginViewControllerDelegate {
    func check(login: String?, password: String?) throws -> User
    func register(login: String, password: String) throws -> User
}

