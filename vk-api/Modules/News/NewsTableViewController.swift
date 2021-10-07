//
//  NewsTableViewController.swift
//  1|SergeyLyashenko
//
//  Created by Сергей Ляшенко on 06.09.2021.
//

import UIKit
import SDWebImage
import RealmSwift
import Firebase

class NewsTableViewController: UITableViewController {
    
    private let cellReuseIdentifier = "CellReuseIdentifier"
    
    //    var newsItem = NewModel()
    let newsAPI = NewsAPI()
    var news: [NewsFeedModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // регестрируем ячейку
        tableView.register(UINib(nibName: "NewsCustomTableViewCell", bundle: nil), forCellReuseIdentifier: cellReuseIdentifier)
        
        //        newsAPI.getNews { newsFeed in
        //            print(newsFeed as Any)
        //        }
        //
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
        
        let newFeed = self.news[indexPath.item]
        let photo = newFeed.photos.items
        let photoNews = photo.last
        let qqq = photoNews?.sizes.last
  //      let www = qqq?.last
        guard let aaa = qqq?.url else { return cell}
        
        

 
        cell.photoImage?.sd_setImage(with: URL(string: aaa), placeholderImage: UIImage())

  //      print(self.news)
        
 //       cell.newsTextLabel.text = www?.url
//        cell.newsCommentsLabel.text = newFeed.postSource
//        cell.photoImage.image = www?.url
        
        return cell
    }
}

