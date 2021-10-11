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
    
    func getNews (completion: @escaping([NewsFeedModel]?, [Group]?)->()) {
        
        let method = "/newsfeed.get"
        
        // параметры
        let parameters: Parameters = [
            "filters": "photo, wall_photo, friend, note",
            "max_photos": 50,
            "count": 5,
            "access_token": Session.shared.token,
            "v": version
        ]
        
        // составляем URL из базового адреса сервиса и конкретного пути к ресурсу
        let url = baseUrl + method
        
        // делаем запрос
        AF.request(url, method: .get, parameters: parameters).responseJSON { response in
            
            // распаковываем response.data в data и если все нормально то идем дальше (оператор раннего выхода)
            guard let data = response.data else { return }
            //                            print(data.prettyJSON as Any)
            
            // группа тасков
            let dispatchGroup = DispatchGroup()
            
            DispatchQueue.global().async(group: dispatchGroup) {
                
                do {
                    
                    let newsResponse = try? JSONDecoder().decode(NewsResponse.self, from: data)
                    
                    let news = newsResponse?.response.items
                    print(Thread.current)
                    
                    let newsGroup = newsResponse?.response.groups
                    print(Thread.current)
                    
                    dispatchGroup.notify(queue: DispatchQueue.main) {
                        
                        completion(news, newsGroup)
                        print(Thread.current)
                    }
                    
                } catch (let error as NSError) {
                    
                    NSLog("Error in read(from:ofType:) domain= \(error.domain), description= \(error.localizedDescription)")
                }
            }
        }
    }
}

