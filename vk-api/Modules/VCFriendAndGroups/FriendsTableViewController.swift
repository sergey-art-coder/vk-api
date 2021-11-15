//
//  FriendsTableViewController.swift
//  1|SergeyLyashenko
//
//  Created by Сергей Ляшенко on 06.09.2021.
//

import UIKit
import RealmSwift
import Firebase

class FriendsTableViewController: UITableViewController {
    
    var friend = FriendModel()
    let friendsDB = FriendsDB()
    let friendsAPI = FriendsAPI()
    var friends: [FriendModel] = []
    var selectedFriend: FriendModel?
    private let customTableViewCellIdentifier = "CustomTableViewCellIdentifier"
    private let toPhotosFriends = "toPhotosFriends"
    
    // для подписки на уведомления генерируем токен
    var token: NotificationToken?
    // подключаем миграцию (расширяем старые объекты новыми полями)
    let configFriends = Realm.Configuration(schemaVersion: 13)
    // подтягиваем Realm на главном потоке
    lazy var mainRealm = try! Realm(configuration: configFriends)
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // регестрируем ячейку
        tableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: customTableViewCellIdentifier)
        
        //        writingIdToFirebase()
        
        //получаем коллекцию из базы
        //        let friendsFromRealm = mainRealm.objects(FriendModel.self)
        //
        //        //подписываемся на получение уведомлений с описанием изменения
        //        self.token = friendsFromRealm.observe { (changes: RealmCollectionChange) in
        //
        //            switch changes {
        //            case .initial(let results):
        //                print("initial", results)
        //
        //            case let .update(results, deletions, insertions, modifications):
        //                print(results,"deletions", deletions,"insertions", insertions,"modifications", modifications)
        //
        //            case .error(let error):
        //                print("error", error.localizedDescription)
        //            }
        //            print("данные изменились")
        //        }
        
        // получаем список друзей, добавляем его в таблицу (выполняем запрос)
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
        
        return friends.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: customTableViewCellIdentifier, for: indexPath) as? CustomTableViewCell else { return UITableViewCell() }
        
        // берем друга из массива по indexPath
        let friend = self.friends[indexPath.row]
        
        //        friendsDB.add(friend)
        //        print(friendsDB.read())
        
        // отображаем имя,фамилию и аватарку
        cell.nameLabel.text = "\(friend.firstName) \(friend.lastName)"
        
        cell.avatarImage?.sd_setImage(with: URL(string: friend.photo100), placeholderImage: UIImage())
        
        return cell
    }

    // MARK:  - Firebase
    
    //    private func writingIdToFirebase() {
    //
    //        // работаем с Firebase
    //        let database = Database.database()
    //
    //        // путь к Firebase
    //        let ref: DatabaseReference = database.reference(withPath: "users Id").child(String(Session.shared.userId))
    //
    //        // чтение из Firebase
    //        ref.observe(.value) { snapshot in
    //
    //            let friendsID = snapshot.children.compactMap { $0 as? DataSnapshot }
    //                .compactMap { $0.key }
    //
    //            // проверка есть ли Id в Firebase
    //            guard friendsID.contains(String(Session.shared.userId)) == false else { return }
    //
    //            // записываем Id в Firebase
    //            ref.child(String(Session.shared.userId)).setValue(self.friend.id)
    //
    //            //  print("Пользователь с Id: \(String(Session.shared.userId)) в Firebase записан:\n\(FriendModel._getProperties())")
    //
    //            let users = snapshot.children.compactMap { $0 as? DataSnapshot }
    //                .compactMap { $0.value }
    //
    //            // print("\nРанее добавленные в Firebase пользователи с Id \(String(Session.shared.userId)):\n\(users)")
    //
    //            // отписываемся от уведомлений, чтобы не происходило изменений при записи в базу (наблюдатель)
    //            ref.removeAllObservers()
    //        }
    //    }
}
