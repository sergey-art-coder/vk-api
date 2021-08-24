//
//  FriendsAPI.swift
//  1|SergeyLyashenko
//
//  Created by Сергей Ляшенко on 18.08.2021.
//

import Foundation
import Alamofire

struct User {
    
}

final class FriendsAPI {
    
    // базовый URL сервиса
    let baseUrl = "https://api.vk.com/method"
    let token = Session.shared.token
    let clientId = Session.shared.userId
    let version = "5.21"
    
    func getFriends (completion: @escaping([FriendModel]?)->()) {
        
        let method = "/friends.get"
        
        // параметры
        let parameters: Parameters = [
            "user_id": clientId,
            "order": "name",
            "count": 100,
            "fields": "photo_100",
            "access_token": Session.shared.token,
            "v": version
        ]
        
        // составляем URL из базового адреса сервиса и конкретного пути к ресурсу
        let url = baseUrl + method
        
        // делаем запрос
        AF.request(url, method: .get, parameters: parameters).responseJSON { response in
            
            //            print (response.request) //запрос
            //            print (response.response) //ответ - статус код и хедеры
            //            print (response.data) //бинарник
            //            print (response.result) //JSON
            //            print ("====================")
            //            print (response.data?.prettyJSON)
            
            // распаковываем response.data в data и если все нормально то идем дальше (оператор раннего выхода)
            guard let data = response.data else { return }
            
            // проверка на ошибки, если будет ошибка она выведется в консоль (всегда когда  используем try нужно оформлять в do catch)
            do {
                // получили объект вложенный состоящий еще с двух подобъектов
                let friendsResponse = try? JSONDecoder().decode(FriendsResponse.self, from: data)
                
                // вытащили friends
                let friends = friendsResponse?.response.items
                
                completion (friends)
            }
            catch {
                
                print(error)
            }
        }
    }
}
