//
//  SearchGroupsAPI.swift
//  1|SergeyLyashenko
//
//  Created by Сергей Ляшенко on 19.08.2021.
//

import Foundation
import Alamofire

struct SearchGroups {
    
}

final class SearchGroupsAPI {
    
    // базовый URL сервиса
    let baseUrl = "https://api.vk.com/method"
    let token = Session.shared.token
    let clientId = Session.shared.userId
    let version = "5.21"
    
    func getSearchGroups (completion: @escaping([SearchGroups]?)->()) {
        
        let method = "/groups.search"
        
        // параметры
        let parameters: Parameters = [
            "access_token": Session.shared.token,
            "v": version,
            "q": "searchText"]
        
        // составляем URL из базового адреса сервиса и конкретного пути к ресурсу
        let url = baseUrl + method
        
        // делаем запрос
        AF.request(url, method: .get, parameters: parameters).responseJSON { response in
            
            print (response.result)
        }
    }
}
