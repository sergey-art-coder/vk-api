//
//  News.swift
//  1|SergeyLyashenko
//
//  Created by Сергей Ляшенко on 05.09.2021.
//

import Foundation
import RealmSwift
import DynamicJSON

class NewsModel: Object {
    @objc dynamic var newsType: String?
    @objc dynamic var newsPost_type: String?
    @objc dynamic var newsDate: String?
    @objc dynamic var sourceId: String?
    @objc dynamic var newsText: String?
    @objc dynamic var canDoubtCategory: String?
    @objc dynamic var postId: String?
    @objc dynamic var postSource: String?
    @objc dynamic var newsViews: String?
    @objc dynamic var newsDonut: String?
    @objc dynamic var newsComments: String?
    @objc dynamic var newsLikes: String?
    @objc dynamic var newsReposts: String?
    @objc dynamic var newsImage: String?
    
    convenience required init(data: JSON) {
        self.init()
        
        self.newsType = data.type.string
        self.newsPost_type = data.post_type.string
        self.newsDate = data.date.string
        self.sourceId = data.source_id.string
        self.newsText = data.text.string
        self.canDoubtCategory = data.can_doubt_category.string
        self.postId = data.post_id.string
        self.postSource = data.post_source.string
        self.newsViews = data.views.string
        self.newsDonut = data.donut.string
        self.newsComments = data.comments.string
        self.newsLikes = data.likes.string
        self.newsReposts = data.reposts.string
        self.newsImage = data.image.string
    }
}

