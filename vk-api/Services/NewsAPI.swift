//
//  NewsAPI.swift
//  1|SergeyLyashenko
//
//  Created by Сергей Ляшенко on 05.09.2021.
//

import Foundation
import Alamofire
import DynamicJSON

//class NewsFeedModel {
//
//}

final class NewsAPI {
    
    // базовый URL сервиса
    let baseUrl = "https://api.vk.com/method"
    let token = Session.shared.token
    let clientId = Session.shared.userId
    let version = "5.131"
    
    func getNews (completion: @escaping([NewsFeedModel]?)->()) {
        
        let method = "/newsfeed.get"
        
        // параметры
        let parameters: Parameters = [
            "filters": "photo, wall_photo, friend, note",
//            "return_banned": 1,
//            "start_time": 10,
            "max_photos": 10,
//            "source_ids": "friends",
//            "start_from": 1,
            "count": 10,
       //     "section": 1,
            "access_token": Session.shared.token,
            "v": version
        ]
        
        // составляем URL из базового адреса сервиса и конкретного пути к ресурсу
        let url = baseUrl + method
        
        // делаем запрос
        AF.request(url, method: .get, parameters: parameters).responseJSON { response in
            
            do {

                // распаковываем response.data в data и если все нормально то идем дальше (оператор раннего выхода)
                guard let data = response.data else { return }
                
//                print(data.prettyJSON as Any)

                let newsResponse = try? JSONDecoder().decode(NewsResponse.self, from: data)
                let new = newsResponse?.response.items
                
                completion (new)
            }
            catch DecodingError.keyNotFound(let key, let context) {
                Swift.print("could not find key \(key) in JSON: \(context.debugDescription)")
            }
            catch DecodingError.valueNotFound(let type, let context) {
                Swift.print("could not find type \(type) in JSON: \(context.debugDescription)")
            }
            catch DecodingError.typeMismatch(let type, let context) {
                Swift.print("type mismatch for type \(type) in JSON: \(context.debugDescription)")
            }
            catch DecodingError.dataCorrupted(let context) {
                Swift.print("data found to be corrupted in JSON: \(context.debugDescription)")
            }
            catch let error as NSError {
                NSLog("Error in read(from:ofType:) domain= \(error.domain), description= \(error.localizedDescription)")
            }
        }
    }
}
