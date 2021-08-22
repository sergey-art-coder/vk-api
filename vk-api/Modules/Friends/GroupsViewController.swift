//
//  GroupsViewController.swift
//  1|SergeyLyashenko
//
//  Created by Сергей Ляшенко on 21.08.2021.
//

import UIKit

class GroupsViewController: UITableViewController {
    
    let groupsAPI = GroupsAPI()
    
    var groups: [GroupModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // регистрируем нашу кастомную ячейку
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "GroupCell")
        
        //Получаем список групп, добавляем их в таблицу
        groupsAPI.getGroups { [weak self] users in
            
            // сохраняем в groups
            guard let users = users else { return }
            self?.groups = users
            self?.tableView.reloadData()
            
        }
        
        groupsAPI.getGroups { users in
            
        }
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        return groups.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "GroupCell", for: indexPath)
        
        // берем группу из массива по indexPath
        let group: GroupModel = groups[indexPath.row]
        
        // отображаем группы
        cell.textLabel?.text = "\(group.name)"
        cell.imageView?.sd_setImage(with: URL(string: group.photo100), placeholderImage: UIImage())
        
        return cell
    }
}


