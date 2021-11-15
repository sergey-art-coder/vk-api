//
//  GroupsAPIOperation.swift
//  1|SergeyLyashenko
//
//  Created by Сергей Ляшенко on 07.11.2021.
//

import Foundation

class GroupsAPIOperation: Operation {
    
    // храним data
    var data: Data?
    
    override func main() {
        
        var requestConstructor = URLComponents()
        requestConstructor.scheme = "https"
        requestConstructor.host = "api.vk.com"
        requestConstructor.path = "/method/groups.get"
        requestConstructor.queryItems = [
            URLQueryItem(name: "user_id", value: String(Session.shared.userId)),
            URLQueryItem(name: "access_token", value: String(Session.shared.token)),
            URLQueryItem(name: "v", value: Session.shared.version),
            URLQueryItem(name: "extended", value: "1"),
        ]
        
        guard let url = requestConstructor.url else { return }
        guard let data = try? Data(contentsOf: url) else { return }
        self.data = data
    }
}

