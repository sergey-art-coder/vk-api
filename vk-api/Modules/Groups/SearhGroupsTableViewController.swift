//
//  SearhTableViewController.swift
//  1|SergeyLyashenko
//
//  Created by Сергей Ляшенко on 03.09.2021.
//

import UIKit
import RealmSwift

class SearhGroupsTableViewController: UITableViewController {
    
    let searchAPI = SearchAPI()
    var searchForGroups: [SearchGroupModel] = []
    
    
    //пустой массив куда будем помещать отфильтрованные записи
    private var filteredSearchGroups = [SearchGroupModel]()
    private let searchGroupsController = UISearchController(searchResultsController: nil)
    
    //определяем не является ли строка поиска пустой
    private var searchGroupsBarIsEmpty: Bool {
        
        guard let text = searchGroupsController.searchBar.text else { return false }
        return text.isEmpty
    }
    
    //отслеживаем информацию поискового запроса
    private var isFiltering: Bool {
        
        return searchGroupsController.isActive && !searchGroupsBarIsEmpty
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // настройка параметров Search Controller
        searchGroupsController.searchResultsUpdater = self
        searchGroupsController.obscuresBackgroundDuringPresentation = false
        searchGroupsController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchGroupsController
        definesPresentationContext = true
        
        // регистрируем нашу кастомную ячейку
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "SearchCell")
        
        //Получаем фото, добавляем их в таблицу
        searchAPI.getSearchGroups { [weak self] users in
            // print(users)
            guard let self = self else { return }
            
            // сохраняем в searchForGroups
            guard let users = users else { return }
            self.searchForGroups = users
            self.tableView.reloadData()
        }
    }
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isFiltering {
            return filteredSearchGroups.count
        }
        return searchForGroups.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell", for: indexPath)
        
        var search: SearchGroupModel
        
        if isFiltering {
            search = filteredSearchGroups[indexPath.row]
        } else {
            search = searchForGroups[indexPath.row]
        }
        
        //отображаем группы
        cell.textLabel?.text = search.searchName
        cell.imageView?.sd_setImage(with: URL(string: search.photo50!), placeholderImage: UIImage())
        
        return cell
    }
}

extension SearhGroupsTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(_searchText: searchController.searchBar.text!)
        
    }
    //заполняем массив filteredSearchGroups отфильтрованными данными из основного массива searchForGroups
    private func filterContentForSearchText (_searchText: String) {
        filteredSearchGroups = searchForGroups.filter ({ (search: SearchGroupModel) -> Bool in
            
            //возвращаем отфильтрованные элементы
            return (search.searchName?.lowercased().contains(_searchText.lowercased()))!
        })
        
        tableView.reloadData()
    }
}


