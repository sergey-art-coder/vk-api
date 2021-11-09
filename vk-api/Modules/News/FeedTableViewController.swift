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
    
    var newsItems: [Items] = []
    var newsProfiles: [Profile] = []
    var newsGroup: [Group] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(FeedFooter.self, forHeaderFooterViewReuseIdentifier: "sectionFooter")
        tableView.sectionFooterHeight = 50
        tableView.separatorStyle = .singleLine
        
        NewsFeedAPI(Session.shared).getNews { [weak self] result  in
            
            guard let self = self else { return }
            
            switch result {
            case .success (let feedNews):
                self.newsItems = feedNews.response.items
                self.newsProfiles = feedNews.response.profiles
                self.newsGroup = feedNews.response.groups
                
                // перезагружаем таблицу
                self.tableView.reloadData()
                
            case .failure (let error):
                print(error.localizedDescription)
            }
        }
    }
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return  newsGroup.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return PostCellType.allCases.count
        
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: "sectionFooter") as! FeedFooter
        let currentFeed = newsItems[section]
        let likeCount = currentFeed.likes.count
        let repostsCount = currentFeed.reposts.count
        
        view.likes.text = "♥ \(likeCount)                           ⚑ \(repostsCount)"
        
        return view
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let newsFeedItems = newsItems[indexPath.section]
        let newsFeedProfiles = newsProfiles[indexPath.section]
        let newsFeedGroup = newsGroup[indexPath.section]
        
        let postCellType = PostCellType(rawValue: indexPath.item)
        
        switch postCellType {
            
        case .info:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "feedInfoCell", for: indexPath) as? FeedInfoTableViewCell else { return UITableViewCell() }
            
            let newsDate = newsFeedItems.date
            
            let photoGroup = newsFeedGroup.photo100
            
            let newsTextName = newsFeedGroup.name
            
            if let urlGroup = URL(string: photoGroup), let dataGroup = try? Data(contentsOf: urlGroup), let photoGroup = UIImage(data: dataGroup)
                
            {
                cell.configureFeedInfo(feedUserGroupImage: photoGroup, feedIUserGroupName: newsTextName, feedPostDate: Double(newsDate))
                
            }
            
            return cell
            
        case .text:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "feedTextCell", for: indexPath) as? FeedTextTableViewCell else { return UITableViewCell() }
            

            let newsText = newsFeedItems.text
            
//            guard let newsText = newsText else { return cell }
            
            cell.configureFeedText(feedText: newsText)
            
            return cell
            
        case .photo:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "feedPhotoCell", for: indexPath) as? FeedPhotoTableViewCell else { return UITableViewCell() }
            
            
            let newsLast = newsFeedItems.attachments?.last?.photo?.sizes.last?.url

            guard let newsLast = newsLast else { return UITableViewCell() }
            
            if let urlNews = URL(string: newsLast), let dataNews = try? Data(contentsOf: urlNews), let imageNews = UIImage(data: dataNews)
                
            {
                cell.configureFeedPhoto(feedPhotoImage: imageNews)
                print(imageNews)
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
