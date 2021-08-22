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
    
    func getGroups (completion: @escaping([Groups]?)->()) {
        
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
        }
    }
    
    func getSearchGroups (completion: @escaping([Groups]?)->()) {
        
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
            
            //            print ("=========SearchGroups===========")
            //            print (response.result)
            //            print ("====================")
            //            print (response.data?.prettyJSON)
        }
    }
}
