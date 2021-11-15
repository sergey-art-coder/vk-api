//
//  GroupsIOperation.swift
//  1|SergeyLyashenko
//
//  Created by Сергей Ляшенко on 15.11.2021.
//

import Foundation

class GroupsParsingDataOperation: Operation {
    
    var groups: [GroupModel] = []
    
    override func main() {
        
        // через dependencies получаем доступ к первому объекту и забираем у него data
        guard let groupsAPIOperation = dependencies.first as? GroupsAPIOperation,
              let data = groupsAPIOperation.data else { return }
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
