//
//  NewsTableViewController.swift
//  1|SergeyLyashenko
//
//  Created by Сергей Ляшенко on 06.09.2021.
//

import UIKit

class NewsTableViewController: UITableViewController {
    
    let newsAPI = NewsAPI()
    var news: [NewsFeedModel] = []
    var newsGroup: [Group] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // регестрируем ячейку
        tableView.register(UINib(nibName: "NewsCustomTableViewCell", bundle: nil), forCellReuseIdentifier: "CellReuseIdentifier")
        
        //Получаем News, добавляем их в таблицу
        newsAPI.getNews { [weak self] newsFeed,newsFeedGroup  in
            
            guard let self = self else { return }
            
            // сохраняем в news
            guard let newFeed = newsFeed else { return }
            self.news = newFeed
            print(self.news)
            
            // сохраняем в newsGroup
            guard let newsFeedGroup = newsFeedGroup else { return }
            self.newsGroup = newsFeedGroup
            
            // перезагружаем таблицу
            self.tableView.reloadData()
        }
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //   return news.count;
        return newsGroup.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CellReuseIdentifier", for: indexPath) as? NewsCustomTableViewCell else { return UITableViewCell() }
        
   // MARK: - NewsFeedModel
        let newsFeed = news[indexPath.item]
        let photo = newsFeed.photos.items
        
        let photoNews = photo.last
        let photoNewsLast = photoNews?.sizes.last
        guard let newsLast = photoNewsLast?.url else { return cell }
        
        if let urlNews = URL(string: newsLast), let dataNews = try? Data(contentsOf: urlNews), let imageNews = UIImage(data: dataNews) {
            cell.photoImage.image = imageNews
        }
        
        let newsText = photoNews?.text
        cell.newsTextLabel.text = newsText
        
        guard let newsDate = photoNews?.date else { return cell }
        let newsDateString = String(newsDate)
        cell.newsDateLabel.text = newsDateString
        
        // MARK: - Group
        let newsFeedGroup = newsGroup[indexPath.item]
        let photoGroup = newsFeedGroup.photo100
        cell.photoGroupImage?.sd_setImage(with: URL(string: photoGroup), placeholderImage: UIImage())
        
        let newsTextName = newsFeedGroup.name
        cell.newsNameLabel.text = newsTextName
        
        return cell
    }
}

