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
    var feedProfiles: [Profile] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // регестрируем ячейку
        tableView.register(UINib(nibName: "NewsCustomTableViewCell", bundle: nil), forCellReuseIdentifier: "CellReuseIdentifier")
        
        //Получаем News, добавляем их в таблицу
        newsAPI.getNews { [weak self] feed  in
            
            guard let self = self else { return }
            guard let feed = feed else { return }
            
            self.news = feed.response.items
            self.newsGroup = feed.response.groups
            self.feedProfiles = feed.response.profiles
            
            // перезагружаем таблицу
            self.tableView.reloadData()
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return news.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CellReuseIdentifier", for: indexPath) as? NewsCustomTableViewCell else { return UITableViewCell() }
        
        // MARK: - NewsFeedModel
        let newsFeed = news[indexPath.item]
        
        let photo = newsFeed.photos.items
        
        let photoNews = photo.last
        let photoNewsLast = photoNews?.sizes.last
        guard let newsLast = photoNewsLast?.url else { return UITableViewCell() }
        
        let newsDate = photoNews?.date
        
        if let urlNews = URL(string: newsLast), let dataNews = try? Data(contentsOf: urlNews), let imageNews = UIImage(data: dataNews),
           let newsText = photoNews?.text,
           let postDate = newsDate
        {
            cell.configureNewsFeedModel(imageNews: imageNews, newsText: newsText, postDate: postDate)
        }
        
        // MARK: - newsGroup
        let newsFeedGroup = newsGroup[indexPath.item]
        let newsProfiles = feedProfiles[indexPath.section]
        print(newsProfiles)
        
        let newsTextName = newsFeedGroup.name
        let photoGroup = newsFeedGroup.photo100
        
        let newsNameProfiles = newsProfiles.firstName
        let photoProfiles = newsProfiles.photo100
        
        if let urlGroup = URL(string: photoGroup), let dataGroup = try? Data(contentsOf: urlGroup), let photoGroup = UIImage(data: dataGroup),
           let urlProfiles = URL(string: photoProfiles), let dataProfiles = try? Data(contentsOf: urlProfiles), let photoProfiles = UIImage(data: dataProfiles)
            
        {
            cell.configureGroup(newsName: newsTextName, photoGroup: photoGroup, newsNameProfiles: newsNameProfiles, photoProfiles: photoProfiles)
        }
        return cell
    }
}

extension Double {
    func getDateStringFromUTC() -> String {
        let date = Date(timeIntervalSince1970: self)
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        
        return dateFormatter.string(from: date)
    }
}
