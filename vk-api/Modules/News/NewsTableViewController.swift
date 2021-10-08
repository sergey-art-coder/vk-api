//
//  NewsTableViewController.swift
//  1|SergeyLyashenko
//
//  Created by Сергей Ляшенко on 06.09.2021.
//

import UIKit

class NewsTableViewController: UITableViewController {
    
    private let cellReuseIdentifier = "CellReuseIdentifier"
    
    //    var newsItem = NewModel()
    let newsAPI = NewsAPI()
    var news: [NewsFeedModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // регестрируем ячейку
        tableView.register(UINib(nibName: "NewsCustomTableViewCell", bundle: nil), forCellReuseIdentifier: cellReuseIdentifier)

        //Получаем News, добавляем их в таблицу
        newsAPI.getNews { [weak self] newsFeed in
            //  print(items)
            guard let self = self else { return }
            
            // сохраняем в news
            guard let newsFeed = newsFeed else { return }
            self.news = newsFeed
            
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
        
        let newsFeed = self.news[indexPath.item]
        let photo = newsFeed.photos.items
        let photoNews = photo.last
        let photoNewsLast = photoNews?.sizes.last
        guard let newsLast = photoNewsLast?.url else { return cell }
        let newsText = photoNews?.text

        guard let newsDate = photoNews?.date else { return cell }
        let newsDateString = String(newsDate)
        
        cell.photoImage?.sd_setImage(with: URL(string: newsLast), placeholderImage: UIImage())
        cell.newsTextLabel.text = newsText
        cell.newsDateLabel.text = newsDateString
        //        cell.photoImage.image = www?.url
        
        return cell
    }
}

