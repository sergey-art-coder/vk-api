//
//  PhotosAPI.swift
//  1|SergeyLyashenko
//
//  Created by Сергей Ляшенко on 18.08.2021.
//

import Foundation
import Alamofire

final class PhotosAPI {
    
    // базовый URL сервис
    let baseUrl = "https://api.vk.com/method"
    let token = Session.shared.token
    let clientId = Session.shared.userId
    let version = "5.131"
    
    func getPhotos (completion: @escaping([PhotoModel]?)->()) {
        
        let method = "/photos.getAll"

        let parameters: Parameters = [
            "owner_id": clientId,
            "access_token": Session.shared.token,
            "v": version,
            "no_service_albums": 0,
            "count": 100,
            "extended": 0
        ]
 
        let url = baseUrl + method

        AF.request(url, method: .get, parameters: parameters).responseJSON { response in

            guard let data = response.data else { return }

            let dispatchGroup = DispatchGroup()
            
            DispatchQueue.global().async(group: dispatchGroup) {

                do {
                    
                    let photosResponse = try? JSONDecoder().decode(PhotosResponse.self, from: data)
                    
                    let photos = photosResponse?.response.items

                    dispatchGroup.notify(queue: DispatchQueue.main) {
                        
                        completion(photos)
                    }
                    
                } catch let error as NSError {
                    
                    NSLog("Error in read(from:ofType:) domain= \(error.domain), description= \(error.localizedDescription)")
                }
            }
        }
    }
}
