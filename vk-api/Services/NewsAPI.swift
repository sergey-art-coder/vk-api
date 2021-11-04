//
//  NewsAPI.swift
//  1|SergeyLyashenko
//
//  Created by Сергей Ляшенко on 05.09.2021.
//

import Foundation
import Alamofire

final class NewsAPI {
    
    // базовый URL сервиса
    let baseUrl = "https://api.vk.com/method"
    let token = Session.shared.token
    let clientId = Session.shared.userId
    let version = "5.131"
    
    func getNews (completion: @escaping(NewsResponse?)->()) {
        
        let method = "/newsfeed.get"
        
        // параметры
        let parameters: Parameters = [
            "filters": "photo, wall_photo, friend, note",
            "max_photos": 50,
            "count": 2,
            "access_token": Session.shared.token,
            "v": version
        ]
        
        // составляем URL из базового адреса сервиса и конкретного пути к ресурсу
        let url = baseUrl + method
        
        // делаем запрос
        AF.request(url, method: .get, parameters: parameters).responseJSON { response in
            
            // распаковываем response.data в data и если все нормально то идем дальше (оператор раннего выхода)
            guard let data = response.data else { return }
                     //   print(data.prettyJSON as Any)
            
            let newsResponse = try? JSONDecoder().decode(NewsResponse.self, from: data)
            let news = newsResponse?.response.items
            let newsGroup = newsResponse?.response.groups
            let newsProfile = newsResponse?.response.profiles
            
            var vkItemsArray: [NewsFeedModel] = []
            var vkGroupsArray: [Group] = []
            var vkProfilesArray: [Profile] = []
            
            guard let news = news else { return }
            
            for (index, items) in news.enumerated() {
                
                do {
                    
                    vkItemsArray.append(items)
                    
                } catch(let errorDecode) {
                    
                    print("Item decoding error at index \(index), err: \(errorDecode)")
                }
            }
            
            guard let newsGroup = newsGroup else { return }
            
            for (index, groups) in newsGroup.enumerated() {
                
                do {
                    
                    vkGroupsArray.append(groups)
                    
                } catch(let errorDecode) {
                    
                    print("Item decoding error at index \(index), err: \(errorDecode)")
                }
            }
            
            guard let newsProfile = newsProfile else { return }
            
            for (index, profiles) in newsProfile.enumerated() {
                
                do {
                    
                    vkProfilesArray.append(profiles)
                    
                } catch(let errorDecode) {
                    
                    print("Item decoding error at index \(index), err: \(errorDecode)")
                }
            }
            
            let response = NewsModel(items: vkItemsArray,
                                     groups: vkGroupsArray,
                                     profiles: vkProfilesArray)
            
            let feed = NewsResponse(response: response)
            
            completion(feed)
        }
    }
}

