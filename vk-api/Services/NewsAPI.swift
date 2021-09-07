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
    let version = "5.21"
    
    func getNews (completion: @escaping([NewsModel]?)->()) {
        
        let method = "/newsfeed.get"
        
        // параметры
        let parameters: Parameters = [
            // "filters": "post",
            "filters": "post, photo",
            "return_banned": 1,
            "max_photos": 10,
            "source_ids": "friends",
            "count": 10,
            "access_token": Session.shared.token,
            "v": version
        ]
        
        // составляем URL из базового адреса сервиса и конкретного пути к ресурсу
        let url = baseUrl + method
        
        // делаем запрос
        AF.request(url, method: .get, parameters: parameters).responseJSON { response in
            
            
            // print ("=========NewsAPI===========")
            //            print(response.data)
            //            print(response.result)
            // response.request позволяет посмотреть как выглядит полный запрос
            //                        print (response.request as Any)
            
            // распаковываем response.data в data и если все нормально то идем дальше (оператор раннего выхода)
            //   guard let data = response.data else { return }
            //  print ("=======test=============")
            //            print(response.data?.prettyJSON)
            //     print (data.prettyJSON as Any)
            do {
                
                // распаковываем response.data в data и если все нормально то идем дальше (оператор раннего выхода)
                guard let data = response.data else { return }
                
                guard let items = JSON(data).response.items.array else { return }
                
                // вытащили news
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
