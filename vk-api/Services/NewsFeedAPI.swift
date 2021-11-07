//
//  NewsAPI.swift
//  1|SergeyLyashenko
//
//  Created by Сергей Ляшенко on 05.09.2021.
//

import Foundation
import Alamofire
import SwiftyJSON

enum NewsFeedServiceError: Error {
    case decodeError
    case notData
    case serverError
}

class NewsFeedAPI {
    
    // базовый URL сервиса
    let baseUrl = "https://api.vk.com/method"
    let method = "/newsfeed.get"
    
    var parameters: Parameters
    
    init(_ session: Session) {
        
        self.parameters = [
            "user_id": Session.shared.userId,
            "access_token": Session.shared.token,
            "v": Session.shared.version,
            "filters": "post",
//          "count": "1",
        ]
    }
    
    func getNews (_ completion: @escaping(Result<NewsResponse, NewsFeedServiceError>) -> Void) {
        
        // составляем URL из базового адреса сервиса и конкретного пути к ресурсу
        let url = baseUrl + method
        
        // делаем запрос
        AF.request(url, method: .get, parameters: parameters).responseData { response in
            
            if let error = response.error {
                completion(.failure(.serverError))
                print(error)
            }
            
            // распаковываем response.data в data и если все нормально то идем дальше (оператор раннего выхода)
            guard let data = response.data else {
                completion(.failure(.notData))
                return
            }
//            print(data.prettyJSON as Any)
            
            let decoder = JSONDecoder()
            let json = JSON(data)
            
            // группа тасков
            let dispatchGroup = DispatchGroup()
            
            let vkItemsJSONArr = json["response"]["items"].arrayValue
            let vkGroupsJSONArr = json["response"]["groups"].arrayValue
            let vkProfilesJSONArr = json["response"]["profiles"].arrayValue
            
            var vkItemsArray: [Items] = []
            var vkGroupsArray: [Group] = []
            var vkProfilesArray: [Profile] = []
            
            // decoding items
            DispatchQueue.global().async(group: dispatchGroup) {
                for (index, items) in vkItemsJSONArr.enumerated() {
                    do {
                        let decodedItem = try decoder.decode(Items.self, from: items.rawData())
                        vkItemsArray.append(decodedItem)
                        
                        print("==========global itemsAPI==========")
                        print(Thread.current)
                        
                    } catch(let errorDecode) {
                        print("Item decoding error at index \(index), err: \(errorDecode)")
                    }
                }
            }
            
            // decoding groups
            DispatchQueue.global().async(group: dispatchGroup) {
                for (index, groups) in vkGroupsJSONArr.enumerated() {
                    do {
                        let decodedItem = try decoder.decode(Group.self, from: groups.rawData())
                        vkGroupsArray.append(decodedItem)
                        
                        print("==========global groupsAPI==========")
                        print(Thread.current)
                        
                    } catch(let errorDecode) {
                        print("Group decoding error at index \(index), err: \(errorDecode)")
                    }
                }
            }
            
            // decoding profiles
            DispatchQueue.global().async(group: dispatchGroup) {
                for (index, profiles) in vkProfilesJSONArr.enumerated() {
                    do {
                        let decodedItem = try decoder.decode(Profile.self, from: profiles.rawData())
                        vkProfilesArray.append(decodedItem)
                        
                        print("==========global profilesAPI==========")
                        print(Thread.current)
                        
                    } catch(let errorDecode) {
                        print("Profile decoding error at index \(index), err: \(errorDecode)")
                    }
                }
            }
            
            do {
                
                dispatchGroup.notify(queue: DispatchQueue.main) {
                    let response = NewsModel(items: vkItemsArray,
                                             profiles: vkProfilesArray,
                                             groups: vkGroupsArray)
                    
                    let feedNews = NewsResponse(response: response)
                    
                    completion (.success(feedNews))
                    
                    print("==========main NewsFeedAPI==========")
                    print(Thread.current)
                }
            }
            
            catch {
                
                completion(.failure(.decodeError))
            }
        }
    }
}


