//
//  Session.swift
//  1|SergeyLyashenko
//
//  Created by Сергей Ляшенко on 15.08.2021.
//

import Foundation

final class Session {
    
    static let shared = Session()
    
    private init() {}
    
    var token = "" // хранение токена в VK
    var userId = "" // хранение идентификатора пользователя VK
    
    let cliendId = "7902471"
    let version = "5.131"

}

