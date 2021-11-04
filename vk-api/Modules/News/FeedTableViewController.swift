//
//  NewsTableViewController.swift
//  1|SergeyLyashenko
//
//  Created by Сергей Ляшенко on 06.09.2021.
//

import UIKit

enum PostCellType: Int, CaseIterable {
    case info
    case text
    case photo
}

class FeedTableViewController: UITableViewController {
    
    let newsAPI = NewsAPI()
    
    var news: [NewsFeedModel] = []
    var newsGroup: [Group] = []
    var feedProfiles: [Profile] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(FeedFooter.self, forHeaderFooterViewReuseIdentifier: "sectionFooter")
        tableView.sectionFooterHeight = 50
        tableView.separatorStyle = .singleLine
        
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
        return newsGroup.count
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        guard let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: "sectionFooter") as? FeedFooter else { return UITableViewCell() }
        let currentFeedItem = news[section]
        
        view.likes.text = "♥ \(currentFeedItem.date)                  |   ⚑ \(currentFeedItem.date)"
        
        return view
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return PostCellType.allCases.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let newsFeed = news[indexPath.section]
        let newsFeedGroup = newsGroup[indexPath.section]
        
        let postCellType = PostCellType(rawValue: indexPath.item)
        
        switch postCellType {
            
        case .info:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "feedInfoCell", for: indexPath) as? FeedInfoTableViewCell else { return UITableViewCell() }
            
            let photoGroup = newsFeedGroup.photo100
            
            let newsTextName = newsFeedGroup.name
            let photo = newsFeed.photos.items
            let photoNews = photo.last
            let newsDate = photoNews?.date
            guard let newsDate = newsDate else { return cell }
            
            if let urlGroup = URL(string: photoGroup), let dataGroup = try? Data(contentsOf: urlGroup), let photoGroup = UIImage(data: dataGroup)
                
            {
                cell.configureFeedInfo(feedUserGroupImage: photoGroup, feedIUserGroupName: newsTextName, feedPostDate: newsDate)
                
            }
            
            return cell
            
        case .text:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "feedTextCell", for: indexPath) as? FeedTextTableViewCell else { return UITableViewCell() }
            let photo = newsFeed.photos.items
            let photoNews = photo.last
            let newsText = photoNews?.text
            
            cell.configureFeedText(feedText: newsText!)
            
            return cell
            
        case .photo:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "feedPhotoCell", for: indexPath) as? FeedPhotoTableViewCell else { return UITableViewCell() }
            
            let photo = newsFeed.photos.items
            let photoNews = photo.last
            let photoNewsLast = photoNews?.sizes.last
            guard let newsLast = photoNewsLast?.url else { return UITableViewCell() }
            if let urlNews = URL(string: newsLast), let dataNews = try? Data(contentsOf: urlNews), let imageNews = UIImage(data: dataNews)
                
            {
                cell.configureFeedPhoto(feedPhotoImage: imageNews)
            }
            
            return cell
            
        default:
            return UITableViewCell()
        }
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
