//
//  NewsAPI.swift
//  1|SergeyLyashenko
//
//  Created by Сергей Ляшенко on 05.09.2021.
//

import Foundation
import Alamofire
import DynamicJSON

//class NewsModel {
//
//}

final class NewsAPI {
    
    // базовый URL сервиса
    let baseUrl = "https://api.vk.com/method"
    let token = Session.shared.token
    let clientId = Session.shared.userId
    let version = "5.131"
    
    func getNews (completion: @escaping([NewsModel]?)->()) {
        
        let method = "/newsfeed.get"
        
        // параметры
        let parameters: Parameters = [
            "filters": "post, photo, note",
            "return_banned": 1,
            "start_time": 10,
            "max_photos": 10,
            "source_ids": "friends",
            "start_from": 1,
            "count": 100,
            "section": 1,
            "access_token": Session.shared.token,
            "v": version
        ]
        
        // составляем URL из базового адреса сервиса и конкретного пути к ресурсу
        let url = baseUrl + method
        
        // делаем запрос
        AF.request(url, method: .get, parameters: parameters).responseJSON { response in
            
            do {
                
                print(response.request as Any)
                
                // распаковываем response.data в data и если все нормально то идем дальше (оператор раннего выхода)
                guard let data = response.data else { return }
                
               // print(data.prettyJSON as Any)
                
                guard let items = JSON(data).response.items.array else { return }
                
                // возьмем items и пройдемся по map
                let news: [NewsModel] = items.map { NewsModel(data: $0) }
                
                completion(news)
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
