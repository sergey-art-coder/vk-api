//
//  GroupsDB.swift
//  1|SergeyLyashenko
//
//  Created by Сергей Ляшенко on 28.08.2021.
//

import Foundation
import RealmSwift

class GroupsDB: GroupsDBProtocol {
    
    //подключаем миграцию (расширяем старые объекты новыми полями)
    let configGroups = Realm.Configuration(schemaVersion: 7)
    //подтягиваем Realm на главном потоке
    lazy var mainRealm = try! Realm(configuration: configGroups)
    
    func add(_ grup: GroupModel) {
        //сохранение объекта в Realm
        do {
            mainRealm.beginWrite()
            mainRealm.add(grup)
            try mainRealm.commitWrite()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func read() -> [GroupModel] {
        
        //прочитать объекты которые сохранили
        let grup = mainRealm.objects(GroupModel.self)
        print(mainRealm.configuration.fileURL)
        //переделываем в массив Swift и возврвщаем назад
        return Array(grup)
    }
    
    func delete(_ grup: GroupModel) {
        //удаление объекта
        mainRealm.beginWrite()
        mainRealm.delete(grup)
        try? mainRealm.commitWrite()
    }
}
