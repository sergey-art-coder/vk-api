//
//  FriendsViewController.swift
//  1|SergeyLyashenko
//
//  Created by Сергей Ляшенко on 17.08.2021.
//

import UIKit
import SDWebImage
import RealmSwift

class FriendsViewController: UITableViewController {
    
    let friend = FriendModel()
    let friendsDB = FriendsDB()
    let friendsAPI = FriendsAPI()
    var friends: [FriendModel] = []
    let toPhotosFriends = "toPhotosFriends"
    var selectedFriend: FriendModel?
    
    //для подписки на уведомления генерируем токен
    var token: NotificationToken?
    //подключаем миграцию (расширяем старые объекты новыми полями)
    let configFriends = Realm.Configuration(schemaVersion: 13)
    //подтягиваем Realm на главном потоке
    lazy var mainRealm = try! Realm(configuration: configFriends)
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        //получаем коллекцию из базы
        let friendsFromRealm = mainRealm.objects(FriendModel.self)
        
        //подписываемся на получение уведомлений с описанием изменения
        self.token = friendsFromRealm.observe { (changes: RealmCollectionChange) in
            
            switch changes {
            case .initial(let results):
                print("initial", results)
                
            case let .update(results, deletions, insertions, modifications):
                print(results,"deletions", deletions,"insertions", insertions,"modifications", modifications)
                
            case .error(let error):
                print("error", error.localizedDescription)
            }
            print("данные изменились")
        }
        
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
        
        friendsDB.add(friend)
        print(friendsDB.read())
        
        // отображаем имя,фамилию и аватарку
        cell.textLabel?.text = "\(friend.firstName) \(friend.lastName)"
        cell.imageView?.sd_setImage(with: URL(string: friend.photo100), placeholderImage: UIImage())
        
//                        friendsDB.delete(friend)
//                        print(friendsDB.read())
        return cell
    }
    
    // сохраняем выбранный индекс в переменной selectedFriend и убираем выделения
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectedFriend = friends[indexPath.row]
        performSegue(withIdentifier: toPhotosFriends, sender: self)
    }
    
    // метод через который мы переходим на PhotosFriendCollectionViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //вызываем подготовку к переходу
        super.prepare(for: segue, sender: sender)
        
        // проверяем что индитификатор называется "toPhotosFriend"
        if segue.identifier == toPhotosFriends {
            
            // проверяем что контроллер на который мы переходим является контроллером типа PhotosFriendCollectionViewController и передаем тот или иной friend по соответствующему индексу строки
            guard let detailVC = segue.destination as? PhotosFriendsCollectionViewController  else { return }
            detailVC.photosUsers = selectedFriend
        }
    }
}
