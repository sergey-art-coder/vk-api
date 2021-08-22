//
//  FriendsViewController.swift
//  1|SergeyLyashenko
//
//  Created by Сергей Ляшенко on 17.08.2021.
//

import UIKit

class FriendsViewController: UITableViewController {
    
    let friendsAPI = FriendsAPI()
    let photosAPI = PhotosAPI()
    let groupsAPI = GroupsAPI()
    
    var friends: [FriendModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // регистрируем нашу кастомную ячейку
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        //Получаем список друзей, добавляем его в таблицу
        friendsAPI.getFriends { [weak self] users in
            
            // сохраняем во friends
            self?.friends = users!
            self?.tableView.reloadData()
            
        }
        photosAPI.getPhotos { users in
            
        }
        groupsAPI.getGroups { users in
            
        }
        groupsAPI.getSearchGroups { users in
            
        }
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return friends.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        // берем друга из массива по indexPath
        let friend: FriendModel = friends[indexPath.row]
        
        // отображаем имя и фамилию
        cell.textLabel?.text = "\(friend.firstName) \(friend.lastName)"
        
        return cell
    }
}
