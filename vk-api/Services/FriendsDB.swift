//
//  File.swift
//  1|SergeyLyashenko
//
//  Created by Сергей Ляшенко on 28.08.2021.
//

import Foundation
import RealmSwift

class FriendsDB: FriendsDBProtocol {
    
    //подключаем миграцию (расширяем старые объекты новыми полями)
    let configFriends = Realm.Configuration(schemaVersion: 13)
    //подтягиваем Realm на главном потоке
    lazy var mainRealm = try! Realm(configuration: configFriends)
    
    func add(_ frend: FriendModel) {
        //сохранение объекта в Realm
        do {
            mainRealm.beginWrite()
            mainRealm.add(frend)
            try mainRealm.commitWrite()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func read() -> [FriendModel] {
        
        //прочитать объекты которые сохранили
        let frend = mainRealm.objects(FriendModel.self)
        print(mainRealm.configuration.fileURL as Any)
        //переделываем в массив Swift и возврвщаем назад
        return Array(frend)
    }
    
    func delete(_ frend: FriendModel) {
        //удаление объекта
        mainRealm.beginWrite()
        mainRealm.delete(frend)
        try? mainRealm.commitWrite()
    }
}
