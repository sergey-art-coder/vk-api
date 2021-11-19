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
                
                self.tableView.reloadData()
                
            case .failure (let error):
                print(error.localizedDescription)
            }
        }
    }
    
    // MARK: - Configure footer.
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        guard let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: "sectionFooter") as? FeedFooter else { return UIView() }
        let currentFeedLike = newsItems[section]
        
        view.likeButton.configureLikeButton(likesCount: currentFeedLike.likes.count,
                                  isLikedByMe: currentFeedLike.likes.userLikes == 1 ? true : false,
                                  itemID: currentFeedLike.postID,
                                  ownerID: currentFeedLike.sourceID,
                                  completionHandlerLiked: {
            self.newsItems[section].likes.count += 1
            self.newsItems[section].likes.userLikes = 1
        },
                                  completionHandlerUnLiked: {
            self.newsItems[section].likes.count -= 1
            self.newsItems[section].likes.userLikes = 0
        })
        
        //         --[ ⚑ ]--
        
        var footerText = ""
        
        footerText += (currentFeedLike.views.count != 0) ? "        ⊹ \(Int(currentFeedLike.views.count).formatted)" : ""
        footerText += (currentFeedLike.reposts.count != 0) ? "       ⌁ \(Int(currentFeedLike.reposts.count).formatted)" : ""
        footerText += (currentFeedLike.comments.count != 0) ? "      ℘ \(Int(currentFeedLike.comments.count).formatted)" : ""
        
        view.postInfo.text = footerText
        
        return view
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        guard newsItems.count >= newsGroup.count else { return newsGroup.count }
        return newsGroup.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return PostCellType.allCases.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let postCellType = PostCellType(rawValue: indexPath.item)
        
        switch postCellType {
            
        case .info:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "feedInfoCell", for: indexPath) as? FeedInfoTableViewCell else { return UITableViewCell() }
            
            let currentFeedItemInfo = newsItems[indexPath.section]
            
            switch newsItems[indexPath.section].sourceID.signum() {
                
            case 1: // Пост пользователя
                let currentFeedItemProfile = newsProfiles.filter{ $0.id == currentFeedItemInfo.sourceID }[0]
                cell.configureFeedInfo(profiles: currentFeedItemProfile, feedPostDate: currentFeedItemInfo.date)
                
            case -1: // Пост группы
                let currentFeedItemGroup = newsGroup.filter{ $0.id == abs(currentFeedItemInfo.sourceID) }[0]
                cell.configureFeedInfo(groups: currentFeedItemGroup, feedPostDate: currentFeedItemInfo.date)
                
            default: break
                
            }
            
            return cell
            
        case .text:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "feedTextCell", for: indexPath) as? FeedTextTableViewCell else { return UITableViewCell() }
            
            let currentFeedItemText = newsItems[indexPath.section]
            
            if currentFeedItemText.hasText {
                
                cell.configureFeedText(text: currentFeedItemText.text)
                return cell
                
            } else { return UITableViewCell() }
            
        case .photo:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "feedPhotoCell", for: indexPath) as? FeedPhotoTableViewCell else { return UITableViewCell() }
            
            let currentFeedItemPhoto = newsItems[indexPath.section]
            if ((currentFeedItemPhoto.attachments?.last?.photo?.sizes.last?.url) != nil) {
                cell.configureFeedPhoto(url: currentFeedItemPhoto.attachments?.last?.photo!.sizes.last?.url)
                return cell
                
            } else {
                
                return UITableViewCell()
            }
            
        default:
            return UITableViewCell()
        }
    }
}



