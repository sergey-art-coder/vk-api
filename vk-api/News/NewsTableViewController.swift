//
//  NewsTableViewController.swift
//  1|SergeyLyashenko
//
//  Created by Сергей Ляшенко on 06.09.2021.
//

import UIKit

class NewsTableViewController: UITableViewController {
    
    private let cellReuseIdentifier = "CellReuseIdentifier"
    var new = NewsModel()
    let newsAPI = NewsAPI()
    var news: [NewsModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // регестрируем ячейку
        tableView.register(UINib(nibName: "NewsCustomTableViewCell", bundle: nil), forCellReuseIdentifier: cellReuseIdentifier)
        
        //Получаем News, добавляем их в таблицу
        newsAPI.getNews { [weak self] users in
            // print(users)
            guard let self = self else { return }
            
            // сохраняем в news
            guard let users = users else { return }
            self.news = users
            
            // перезагружаем таблицу
            self.tableView.reloadData()
        }
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        news.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as? NewsCustomTableViewCell else { return UITableViewCell() }
        
        let new = self.news[indexPath.item]
        
        cell.newsTextLabel.text = "\(String(describing: new.newsText))"
        
        return cell
    }
}

