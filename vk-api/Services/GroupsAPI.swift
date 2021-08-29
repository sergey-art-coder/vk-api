//
//  GroupsAPI.swift
//  1|SergeyLyashenko
//
//  Created by Сергей Ляшенко on 18.08.2021.
//

import Foundation
import Alamofire

struct Groups {
    
}

final class GroupsAPI {
    
    // базовый URL сервиса
    let baseUrl = "https://api.vk.com/method"
    let token = Session.shared.token
    let clientId = Session.shared.userId
    let version = "5.21"
    
    func getGroups (completion: @escaping([GroupModel]?)->()) {
        
        let method = "/groups.get"
        
        // параметры
        let parameters: Parameters = [
            "user_id": clientId,
            "access_token": Session.shared.token,
            "v": version,
            "extended": 1
        ]
        
        // составляем URL из базового адреса сервиса и конкретного пути к ресурсу
        let url = baseUrl + method
        
        // делаем запрос
        AF.request(url, method: .get, parameters: parameters).responseJSON { response in
            
//            print (response.result)
//            print ("====================")
//            print (response.data?.prettyJSON)
            
            // распаковываем response.data в data и если все нормально то идем дальше (оператор раннего выхода)
            guard let data = response.data else { return }
            
            // проверка на ошибки, если будет ошибка она выведется в консоль (всегда когда  используем try нужно оформлять в do catch)
            do {
                // получили объект вложенный состоящий еще с двух подобъектов
                let groupsResponse = try? JSONDecoder().decode(GroupsResponse.self, from: data)
                
                // вытащили friends
                let groups = groupsResponse?.response.items
                
                completion (groups)
            }
            catch {
                
                print(error)
            }
        }
    }
    
    // =========================================getSearchGroups================================================================================
    
    func getSearchGroups (completion: @escaping([SearchGroupModel]?)->()) {
        
        let method = "/groups.search"
        
        // параметры
        let parameters: Parameters = [
            "access_token": Session.shared.token,
            "v": version,
            "q": "searchText"
        ]
        
        // составляем URL из базового адреса сервиса и конкретного пути к ресурсу
        let url = baseUrl + method
        
        // делаем запрос
        AF.request(url, method: .get, parameters: parameters).responseJSON { response in
            
            //                        print ("=========SearchGroups===========")
            //                        print (response.result)
            //                        print ("====================")
            //                        print (response.data?.prettyJSON)
            
            // распаковываем response.data в data и если все нормально то идем дальше (оператор раннего выхода)
            guard let data = response.data else { return }
            
            // проверка на ошибки, если будет ошибка она выведется в консоль (всегда когда  используем try нужно оформлять в do catch)
            do {
                // получили объект вложенный состоящий еще с двух подобъектов
                let searchGroupsResponse = try? JSONDecoder().decode(SearchGroupsResponse.self, from: data)
                
                // вытащили friends
                let searchGroups = searchGroupsResponse?.response.items
                
                completion (searchGroups)
            }
            catch {
                
                print(error)
            }
        }
    }
}

