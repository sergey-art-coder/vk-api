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
    
    let newsFeedAPI = NewsFeedAPI()
    
    var newsItems: [Items] = []
    var newsProfiles: [Profile] = []
    var newsGroup: [Group] = []
    
    // Добавляем параметр nextFrom
    var nextFrom = ""
    var isLoading = false
    
    var expandedIndexSet: IndexSet = []
    
    // Функция настройки контроллера
    fileprivate func setupRefreshControl() {
        
        // Цвет спиннера
        refreshControl?.tintColor = .orange
        // refreshControl подвязали на refreshNews
        refreshControl?.addTarget(self, action: #selector(refreshNews), for: .valueChanged)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupRefreshControl()
        
        // tableView подписываем на prefetchDataSource
        tableView.prefetchDataSource = self
        
        tableView.register(FeedFooter.self, forHeaderFooterViewReuseIdentifier: "sectionFooter")
        tableView.sectionFooterHeight = 50
        tableView.separatorStyle = .singleLine
        
        newsFeedAPI.getNews { [weak self] result  in
            
            switch result {
            case .success (let feedNews):
                
                guard let self = self else { return }
                
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
    
    
    // MARK: - Row height
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        func currentPhotoHeight(_ item: Items) -> CGFloat {
            
            guard let height = item.attachments?[0].photo?.sizes.last?.height else { return UITableView.automaticDimension }
            guard let width = item.attachments?[0].photo?.sizes.last?.width else { return UITableView.automaticDimension }
            
            let tableWidth = tableView.bounds.width
            
            let aspectRatio = CGFloat(height) / CGFloat(width)
            let cellHeight = tableWidth * aspectRatio
            return cellHeight
        }
        
        let currentFeedItem = newsItems[indexPath.section]
        
        switch indexPath.row {
            
        case 1:
            return currentFeedItem.hasText ? UITableView.automaticDimension : currentPhotoHeight(currentFeedItem)
            
        case 2:
            return currentFeedItem.hasLink ? UITableView.automaticDimension : currentPhotoHeight(currentFeedItem)
            
        default:
            return UITableView.automaticDimension
        }
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return newsItems.count
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
                
                cell.configureFeedText(text: currentFeedItemText.text,
                                       expanded: expandedIndexSet.contains(indexPath.section),
                                       readMoreHandler: {
                    self.tableView.beginUpdates()
                    self.tableView.endUpdates()
                    self.expandedIndexSet.insert(indexPath.section)
                })
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

// MARK: - Pull-to-refresh (подгрузка новых новостей)
extension FeedTableViewController {
    
    @objc func refreshNews() {
        
        // Начинаем обновление новостей
        self.refreshControl?.beginRefreshing()
        // Определяем время самой свежей новости или берем текущее время
        let mostFreshNewsDate = self.newsItems.first?.date ?? Date().timeIntervalSince1970
        
        // отправляем сетевой запрос загрузки новостей
        newsFeedAPI.getNews(startTime: mostFreshNewsDate + 1) { [weak self] result in
            
            switch result {
            case .success (let feedNews):
                
                guard let self = self else { return }
                // выключаем вращающийся индикатор
                self.refreshControl?.endRefreshing()
                
                // подгружаем items, profiles, groups
                let items = feedNews.response.items
                let profiles = feedNews.response.profiles
                let groups = feedNews.response.groups
                
                // проверяем, что более свежие новости действительно есть
                guard items.count > 0 else { return }
                
                // прикрепляем их в начало отображаемого массива
                self.newsItems = items + self.newsItems
                self.newsProfiles = profiles + self.newsProfiles
                self.newsGroup = groups + self.newsGroup
                
                // формируем IndexSet свежедобавленных секций и обновляем таблицу
                let indexSet = IndexSet(integersIn: 0..<items.count)
                self.tableView.insertSections(indexSet, with: .automatic)
                
            case .failure (let error):
                print(error.localizedDescription)
            }
        }
    }
}

// MARK: - Infinite Scrolling (подгрузка старых новостей)
extension FeedTableViewController: UITableViewDataSourcePrefetching {
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        
        // Выбираем максимальный номер секции, которую нужно будет отобразить в ближайшее время
        guard let maxSection = indexPaths.map({ $0.section }).max() else { return }
        
        // Проверяем,является ли эта секция одной из трех ближайших к концу
        if maxSection > newsItems.count - 3,
           // Убеждаемся, что мы уже не в процессе загрузки данных
           !isLoading {
            // Начинаем загрузку данных и меняем флаг isLoading
            isLoading = true
            
            newsFeedAPI.getNews(startFrom: nextFrom) { [weak self] result in
                
                switch result {
                case .success (let feedNews):
                    
                    guard let self = self else { return }
                    
                    let newItems = feedNews.response.items
                    let newProfiles = feedNews.response.profiles
                    let newGroups = feedNews.response.groups
                    
                    // Прикрепляем новости к cуществующим новостям
                    let indexSet = IndexSet(integersIn: self.newsItems.count ..< self.newsItems.count + newItems.count)
                    
                    self.newsItems.append(contentsOf: newItems)
                    self.newsProfiles.append(contentsOf: newProfiles)
                    self.newsGroup.append(contentsOf: newGroups)
                    
                    self.nextFrom = feedNews.response.nextFrom
                    // Обновляем таблицу
                    self.tableView.insertSections(indexSet, with: .automatic)
                    // Выключаем статус isLoading
                    self.isLoading = false
                    
                case .failure (let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
}

