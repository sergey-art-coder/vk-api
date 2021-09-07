//
//  SearchAPI.swift
//  1|SergeyLyashenko
//
//  Created by Сергей Ляшенко on 04.09.2021.
//

import Foundation
import Alamofire
import DynamicJSON

struct Search {
    
}
final class SearchAPI {
    
    // базовый URL сервиса
    let baseUrl = "https://api.vk.com/method"
    let token = Session.shared.token
    let clientId = Session.shared.userId
    let version = "5.21"
    
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
//                       // response.request позволяет посмотреть как выглядит полный запрос
//                        print (response.request as Any)
//
                        // распаковываем response.data в data и если все нормально то идем дальше (оператор раннего выхода)
            guard let data = response.data else { return }
//                        print ("=======test=============")
//                        print (data.prettyJSON as Any)
            
            guard let items = JSON(data).response.items.array else { return }
            let searchs: [SearchGroupModel] = items.map { SearchGroupModel(data: $0) }
            
            DispatchQueue.main.async {
                completion (searchs)
            }
        }
    }
}

