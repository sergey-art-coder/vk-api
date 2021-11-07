//
//  GroupsAPIOperation.swift
//  1|SergeyLyashenko
//
//  Created by Сергей Ляшенко on 07.11.2021.
//

import Foundation

class GroupsAPIDataOperation: Operation {
    
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

class GroupsParsingDataOperation: Operation {
    
    var groups: [GroupModel] = []
    
    override func main() {
        
        // через dependencies получаем доступ к первому объекту и забираем у него data
        guard let groupsAPIDataOperation = dependencies.first as? GroupsAPIDataOperation,
              let data = groupsAPIDataOperation.data else { return }
        do {
            var responseGroupsData: GroupsResponse
            responseGroupsData = try JSONDecoder().decode(GroupsResponse.self, from: data)
            self.groups = responseGroupsData.response.items
        } catch {
            print(error)
        }
    }
}

class GroupsDisplayDataOperation: Operation {
    
    var groupsViewController: GroupsTableViewController
    
    override func main() {
        guard let groupsParsingDataOperation = dependencies.first as? GroupsParsingDataOperation else { return }
        let groupsItems = groupsParsingDataOperation.groups
        groupsViewController.groups = groupsItems
        
        groupsViewController.tableView.reloadData()
        
    }
    
    init(_ controller: GroupsTableViewController) {
        
        self.groupsViewController = controller
    }
}
