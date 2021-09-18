//
//  GroupsTableViewController.swift
//  1|SergeyLyashenko
//
//  Created by Сергей Ляшенко on 06.09.2021.

import UIKit
import RealmSwift

class GroupsTableViewController: UITableViewController {
    
    let groupsDB = GroupsDB()
    let groupsAPI = GroupsAPI()
    var groups: [GroupModel] = []
    private let customTableViewCellIdentifier = "CustomTableViewCellIdentifier"
    
    //пустой массив куда будем помещать отфильтрованные записи
    private var filteredGroups = [GroupModel]()
    private let searchController = UISearchController(searchResultsController: nil)
    
    //определяем не является ли строка поиска пустой
    private var searchBarIsEmpty: Bool {
        
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    
    //отслеживаем информацию поискового запроса
    private var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
    
    //для подписки на уведомления генерируем токен
    var token: NotificationToken?
    //подключаем миграцию (расширяем старые объекты новыми полями)
    let configFriends = Realm.Configuration(schemaVersion: 13)
    //подтягиваем Realm на главном потоке
    lazy var mainRealm = try! Realm(configuration: configFriends)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // регестрируем ячейку
        tableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: customTableViewCellIdentifier)
        
        //        //получаем коллекцию из базы
        //        let groupsFromRealm = mainRealm.objects(GroupModel.self)
        //
        //        //подписываемся на получение уведомлений с описанием изменения
        //        self.token = groupsFromRealm.observe { (changes: RealmCollectionChange) in
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
        
        // настройка параметров Search Controller
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        //Получаем список групп, добавляем их в таблицу
        groupsAPI.getGroups { [weak self] users in
            guard let self = self else { return }
            
            // сохраняем в groups
            guard let users = users else { return }
            self.groups = users
            self.tableView.reloadData()
        }
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isFiltering {
            return filteredGroups.count
        }
        return groups.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: customTableViewCellIdentifier, for: indexPath) as? CustomTableViewCell else { return UITableViewCell() }
        
        var group: GroupModel
        
        if isFiltering {
            group = filteredGroups[indexPath.row]
        } else {
            group = groups[indexPath.row]
        }
        
        //        groupsDB.add(group)
        //        print(groupsDB.read())
        
        // отображаем группы
        cell.nameLabel.text = group.name
        cell.avatarImage?.sd_setImage(with: URL(string: group.photo100), placeholderImage: UIImage())
        
        //                groupsDB.delete(group)
        //                print(groupsDB.read())
        return cell
    }
}

extension GroupsTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(_searchText: searchController.searchBar.text!)
        
    }
    //заполняем массив filteredGroups отфильтрованными данными из основного массива groups
    private func filterContentForSearchText (_searchText: String) {
        filteredGroups = groups.filter ({ (group: GroupModel) -> Bool in
            
            //возвращаем отфильтрованные элементы
            return group.name.lowercased().contains(_searchText.lowercased())
        })
        tableView.reloadData()
    }
}
