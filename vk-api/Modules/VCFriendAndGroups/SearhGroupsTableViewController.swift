//
//  SearhTableViewController.swift
//  1|SergeyLyashenko
//
//  Created by Сергей Ляшенко on 03.09.2021.

import UIKit
import RealmSwift

class SearhGroupsTableViewController: UITableViewController {
    
    let searchAPI = SearchAPI()
    var searchForGroups: [SearchGroupModel] = []
    private let customTableViewCellIdentifier = "CustomTableViewCellIdentifier"
    
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
        
        // регестрируем ячейку
        tableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: customTableViewCellIdentifier)
        
        //настройка параметров Search Controller
        searchGroupsController.searchResultsUpdater = self
        searchGroupsController.obscuresBackgroundDuringPresentation = false
        searchGroupsController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchGroupsController
        definesPresentationContext = true
        
        //Получаем фото, добавляем их в таблицу
        searchAPI.getSearchGroups { [weak self] users in
            
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
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: customTableViewCellIdentifier, for: indexPath) as? CustomTableViewCell else { return UITableViewCell() }
        
        var search: SearchGroupModel
        
        if isFiltering {
            search = filteredSearchGroups[indexPath.row]
        } else {
            search = searchForGroups[indexPath.row]
        }
        
        //отображаем группы
        cell.nameLabel.text = search.name
        cell.avatarImage?.sd_setImage(with: URL(string: search.photo100), placeholderImage: UIImage())
        
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
            return (search.name.lowercased().contains(_searchText.lowercased()))
        })
        tableView.reloadData()
    }
}


