//
//  PhotosDB.swift
//  1|SergeyLyashenko
//
//  Created by Сергей Ляшенко on 28.08.2021.
//

import Foundation
import RealmSwift

class PhotosDB: PhotosDBProtocol {
    
    //подключаем миграцию (расширяем старые объекты новыми полями)
    let configPhotos = Realm.Configuration(schemaVersion: 6)
    //подтягиваем Realm на главном потоке
    lazy var mainRealm = try! Realm(configuration: configPhotos)
    
    func add(_ foto: PhotoModel) {
        //сохранение объекта в Realm
        do {
            mainRealm.beginWrite()
            mainRealm.add(foto)
            try mainRealm.commitWrite()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func read() -> [PhotoModel] {
        
        //прочитать объекты которые сохранили
        let foto = mainRealm.objects(PhotoModel.self)
        print(mainRealm.configuration.fileURL)
        //переделываем в массив Swift и возврвщаем назад
        return Array(foto)
    }
    
    func delete(_ foto: PhotoModel) {
        //удаление объекта
        mainRealm.beginWrite()
        mainRealm.delete(foto)
        try? mainRealm.commitWrite()
    }
}
