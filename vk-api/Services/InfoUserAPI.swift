//
//  UserAPI.swift
//  1|SergeyLyashenko
//
//  Created by Сергей Ляшенко on 14.11.2021.
//

import Foundation
import Alamofire

class InfoUserAPI {
    
    let baseUrl = "https://api.vk.com/method"
    let method = "/users.get"
    
    enum Errors: Error {
        case unknownError
        case noPhotoUrl
    }
    
    var parameters: Parameters
    
    init(_ session: Session) {
        
        self.parameters = [
            
            "user_id": Session.shared.userId,
            "access_token": Session.shared.token,
            "v": Session.shared.version,
            "fields": "has_photo, photo_200, city, country",
        ]
    }
    
    func getInfoUser(_ completion: @escaping (InfoUsersResponse?) -> ()) {
        
        let url = baseUrl + method
        
        AF.request(url, method: .get, parameters: parameters).responseJSON { response in
            
            guard let data = response.data else { return }
            
            do {
                
                let infoUsers = try JSONDecoder().decode(InfoUsersResponse.self, from: data)
                
                completion (infoUsers)
                
            } catch {
                
                print(error)
            }
        }
    }
}
