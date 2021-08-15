//
//  Session.swift
//  1|SergeyLyashenko
//
//  Created by Сергей Ляшенко on 19.04.2021.
//

import Foundation
class Session {
    private init() {}
    static let instance = Session()
    
    var token: String = "" // хранение токена в VK
    var userId: Int = 0 // хранение идентификатора пользователя VK
    
}
