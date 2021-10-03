//
//  NewsTableViewController.swift
//  1|SergeyLyashenko
//
//  Created by Сергей Ляшенко on 06.09.2021.
//

import UIKit

class NewsTableViewController: UITableViewController {
    
    private let cellReuseIdentifier = "CellReuseIdentifier"

    let newsAPI = NewsAPI()
    var news: [NewModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // регестрируем ячейку
        tableView.register(UINib(nibName: "NewsCustomTableViewCell", bundle: nil), forCellReuseIdentifier: cellReuseIdentifier)
        
        //Получаем News, добавляем их в таблицу
        newsAPI.getNews { [weak self] new in
           //  print(items)
            guard let self = self else { return }
            
            // сохраняем в news
            guard let new = new else { return }
            self.news = new
            print(self.news)
            // перезагружаем таблицу
            self.tableView.reloadData()
        }
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return news.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as? NewsCustomTableViewCell else { return UITableViewCell() }
        
        let newsItem = self.news[indexPath.item]
        
        cell.newsTextLabel.text = newsItem.text
        
       // cell.newsTextLabel.text = "\(String(describing: newsItem.text))"
        
        return cell
    }
}

