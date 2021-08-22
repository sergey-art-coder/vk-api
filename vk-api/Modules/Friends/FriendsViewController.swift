//
//  FriendsViewController.swift
//  1|SergeyLyashenko
//
//  Created by Сергей Ляшенко on 17.08.2021.
//

import UIKit
import SDWebImage

class FriendsViewController: UITableViewController {
    
    let friendsAPI = FriendsAPI()
    let photosAPI = PhotosAPI()
    let groupsAPI = GroupsAPI()
    
    var friends: [FriendModel] = []
    let toPhotosFriend = "toPhotosFriend"
    var selectedFriend: FriendModel?
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // регистрируем нашу кастомную ячейку
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "FriendsCell")
        
        //Получаем список друзей, добавляем его в таблицу (выполняем запрос)
        friendsAPI.getFriends { [weak self] users in
            guard let self = self else { return }
            // сохраняем в массив friends
            guard let users = users else { return }
            self.friends = users
            // перезагружаем таблицу
            self.tableView.reloadData()
        }
        
        //        groupsAPI.getGroups { users in
        //
        //        }
        
        groupsAPI.getSearchGroups { users in
            
        }
        
        photosAPI.getPhotos { users in
            
        }
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return friends.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // создается ячейка
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendsCell", for: indexPath)
        
        // берем друга из массива по indexPath
        let friend: FriendModel = friends[indexPath.row]
   
        // отображаем имя,фамилию и аватарку
        cell.textLabel?.text = "\(friend.firstName) \(friend.lastName)"
        cell.imageView?.sd_setImage(with: URL(string: friend.photo100), placeholderImage: UIImage())
        
        return cell
    }
    
    // сохраняем выбранный индекс в переменной selectedFriend и убираем выделения
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectedFriend = friends[indexPath.row]
        performSegue(withIdentifier: toPhotosFriend, sender: self)
    }
    
    // метод через который мы переходим на PhotosFriendCollectionViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //вызываем подготовку к переходу
        super.prepare(for: segue, sender: sender)
        
        // проверяем что индитификатор называется "toPhotosFriend"
        if segue.identifier == toPhotosFriend {
            
            // проверяем что контроллер на который мы переходим является контроллером типа PhotosFriendCollectionViewController и передаем тот или иной friend по соответствующему индексу строки
            guard let detailVC = segue.destination as? PhotosFriendCollectionViewController  else { return }
            detailVC.photosUsers = selectedFriend
        }
    }
}
