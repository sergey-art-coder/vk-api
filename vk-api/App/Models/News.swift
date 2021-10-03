//
//  News.swift
//  1|SergeyLyashenko
//
//  Created by Сергей Ляшенко on 05.09.2021.
//

import Foundation
import RealmSwift

// MARK: - NewsResponse
struct NewsResponse: Codable {
    let response: NewsModel
}

// MARK: - Response
struct NewsModel: Codable {
    let items: [NewModel]
    let groups: [Group]
    let profiles: [Profile]
    let nextFrom: String

    enum CodingKeys: String, CodingKey {
        case items, groups, profiles
        case nextFrom = "next_from"
    }
}

// MARK: - Group
struct Group: Codable {
    let isMember, id: Int
    let photo100: String
    let isAdvertiser, isAdmin: Int
    let photo50, photo200: String
    let type, screenName, name: String
    let isClosed: Int

    enum CodingKeys: String, CodingKey {
        case isMember = "is_member"
        case id
        case photo100 = "photo_100"
        case isAdvertiser = "is_advertiser"
        case isAdmin = "is_admin"
        case photo50 = "photo_50"
        case photo200 = "photo_200"
        case type
        case screenName = "screen_name"
        case name
        case isClosed = "is_closed"
    }
}

// MARK: - Item
struct NewModel: Codable {
    let donut: Donut
    let comments: Comments
    let canSetCategory, isFavorite: Bool
    let shortTextRate: Double
    let likes: Likes
    let reposts: Reposts
    let type, postType: PostTypeEnum
    let date, sourceID: Int
    let text: String
    let canDoubtCategory: Bool
    let copyHistory: [CopyHistory]?
    let postID: Int
    let postSource: PostSource
    let views: Views
    let attachments: [ItemAttachment]?
    let carouselOffset, topicID: Int?

    enum CodingKeys: String, CodingKey {
        case donut, comments
        case canSetCategory = "can_set_category"
        case isFavorite = "is_favorite"
        case shortTextRate = "short_text_rate"
        case likes, reposts, type
        case postType = "post_type"
        case date
        case sourceID = "source_id"
        case text
        case canDoubtCategory = "can_doubt_category"
        case copyHistory = "copy_history"
        case postID = "post_id"
        case postSource = "post_source"
        case views, attachments
        case carouselOffset = "carousel_offset"
        case topicID = "topic_id"
    }
}

// MARK: - ItemAttachment
struct ItemAttachment: Codable {
    let type: String
    let video: Video?
    let link: PurpleLink?
    let photo: Photo?
    let market: Market?
}

// MARK: - PurpleLink
struct PurpleLink: Codable {
    let isFavorite: Bool
    let title: String
    let url: String
    let linkDescription: String
    let target, caption: String?
    let photo: Photo?

    enum CodingKeys: String, CodingKey {
        case isFavorite = "is_favorite"
        case title, url
        case linkDescription = "description"
        case target, caption, photo
    }
}

// MARK: - Photo
struct Photo: Codable {
    let albumID, id, date: Int
    let text: String
    let userID: Int?
    let sizes: [Size]
    let hasTags: Bool
    let ownerID: Int
    let accessKey: String?
    let postID: Int?

    enum CodingKeys: String, CodingKey {
        case albumID = "album_id"
        case id, date, text
        case userID = "user_id"
        case sizes
        case hasTags = "has_tags"
        case ownerID = "owner_id"
        case accessKey = "access_key"
        case postID = "post_id"
    }
}

// MARK: - Size
struct Size: Codable {
    let width, height: Int
    let url: String
    let type: String?
    let withPadding: Int?

    enum CodingKeys: String, CodingKey {
        case width, height, url, type
        case withPadding = "with_padding"
    }
}

// MARK: - Market
struct Market: Codable {
    let category: Category
    let thumbPhoto: String
    let availability, id: Int
    let price: Price
    let title, marketDescription: String
    let ownerID: Int

    enum CodingKeys: String, CodingKey {
        case category
        case thumbPhoto = "thumb_photo"
        case availability, id, price, title
        case marketDescription = "description"
        case ownerID = "owner_id"
    }
}

// MARK: - Category
struct Category: Codable {
    let id: Int
    let name: String
    let section: Section
}

// MARK: - Section
struct Section: Codable {
    let id: Int
    let name: String
}

// MARK: - Price
struct Price: Codable {
    let amount: String
    let currency: Currency
    let discountRate: Int
    let oldAmountText, oldAmount, text: String

    enum CodingKeys: String, CodingKey {
        case amount, currency
        case discountRate = "discount_rate"
        case oldAmountText = "old_amount_text"
        case oldAmount = "old_amount"
        case text
    }
}

// MARK: - Currency
struct Currency: Codable {
    let id: Int
    let name, title: String
}

// MARK: - Video
struct Video: Codable {
    let ownerID: Int
    let title: String
    let canAdd, duration: Int
    let image: [Size]
    let isFavorite: Bool
    let views: Int
    let type: String
    let canLike, canComment, id, date: Int
    let platform: String?
    let trackCode: String
    let canAddToFaves: Int
    let accessKey: String
    let comments: Int
    let localViews: Int?
    let canSubscribe, canRepost: Int
    let videoDescription: String
    let firstFrame: [Size]?
    let height, width: Int?

    enum CodingKeys: String, CodingKey {
        case ownerID = "owner_id"
        case title
        case canAdd = "can_add"
        case duration, image
        case isFavorite = "is_favorite"
        case views, type
        case canLike = "can_like"
        case canComment = "can_comment"
        case id, date, platform
        case trackCode = "track_code"
        case canAddToFaves = "can_add_to_faves"
        case accessKey = "access_key"
        case comments
        case localViews = "local_views"
        case canSubscribe = "can_subscribe"
        case canRepost = "can_repost"
        case videoDescription = "description"
        case firstFrame = "first_frame"
        case height, width
    }
}

// MARK: - Comments
struct Comments: Codable {
    let count, canPost: Int
    let groupsCanPost: Bool

    enum CodingKeys: String, CodingKey {
        case count
        case canPost = "can_post"
        case groupsCanPost = "groups_can_post"
    }
}

// MARK: - CopyHistory
struct CopyHistory: Codable {
    let postSource: PostSource
    let postType: PostTypeEnum
    let id, fromID, date: Int
    let text: String
    let attachments: [CopyHistoryAttachment]?
    let ownerID: Int
    let signerID: Int?

    enum CodingKeys: String, CodingKey {
        case postSource = "post_source"
        case postType = "post_type"
        case id
        case fromID = "from_id"
        case date, text, attachments
        case ownerID = "owner_id"
        case signerID = "signer_id"
    }
}

// MARK: - CopyHistoryAttachment
struct CopyHistoryAttachment: Codable {
    let type: String
    let video: Video?
    let audio: Audio?
    let photo: Photo?
    let link: FluffyLink?
    let doc: Doc?
}

// MARK: - Audio
struct Audio: Codable {
    let id: Int
    let storiesAllowed, storiesCoverAllowed: Bool
    let trackCode: String
    let url: String
    let title: String
    let ownerID, date: Int
    let shortVideosAllowed: Bool
    let genreID, lyricsID, duration: Int
    let artist: String
    let isExplicit, isFocusTrack: Bool

    enum CodingKeys: String, CodingKey {
        case id
        case storiesAllowed = "stories_allowed"
        case storiesCoverAllowed = "stories_cover_allowed"
        case trackCode = "track_code"
        case url, title
        case ownerID = "owner_id"
        case date
        case shortVideosAllowed = "short_videos_allowed"
        case genreID = "genre_id"
        case lyricsID = "lyrics_id"
        case duration, artist
        case isExplicit = "is_explicit"
        case isFocusTrack = "is_focus_track"
    }
}

// MARK: - Doc
struct Doc: Codable {
    let accessKey: String
    let id: Int
    let ext, title: String
    let size, date, type, ownerID: Int
    let url: String

    enum CodingKeys: String, CodingKey {
        case accessKey = "access_key"
        case id, ext, title, size, date, type
        case ownerID = "owner_id"
        case url
    }
}

// MARK: - FluffyLink
struct FluffyLink: Codable {
    let isFavorite: Bool
    let title: String
    let url: String
    let linkDescription, target: String

    enum CodingKeys: String, CodingKey {
        case isFavorite = "is_favorite"
        case title, url
        case linkDescription = "description"
        case target
    }
}

// MARK: - PostSource
struct PostSource: Codable {
    let type: PostSourceType
    let platform: Platform?
}

enum Platform: String, Codable {
    case android = "android"
    case iphone = "iphone"
}

enum PostSourceType: String, Codable {
    case api = "api"
    case vk = "vk"
}

enum PostTypeEnum: String, Codable {
    case post = "post"
}

// MARK: - Donut
struct Donut: Codable {
    let isDonut: Bool

    enum CodingKeys: String, CodingKey {
        case isDonut = "is_donut"
    }
}

// MARK: - Likes
struct Likes: Codable {
    let canLike, canPublish, count, userLikes: Int

    enum CodingKeys: String, CodingKey {
        case canLike = "can_like"
        case canPublish = "can_publish"
        case count
        case userLikes = "user_likes"
    }
}

// MARK: - Reposts
struct Reposts: Codable {
    let count, userReposted: Int

    enum CodingKeys: String, CodingKey {
        case count
        case userReposted = "user_reposted"
    }
}

// MARK: - Views
struct Views: Codable {
    let count: Int
}

// MARK: - Profile
struct Profile: Codable {
    let canAccessClosed: Bool?
    let screenName: String?
    let online, id: Int
    let photo100: String
    let lastName: String
    let photo50: String
    let onlineInfo: OnlineInfo
    let sex: Int
    let isClosed: Bool?
    let firstName: String
    let deactivated: String?
    let onlineMobile, onlineApp: Int?

    enum CodingKeys: String, CodingKey {
        case canAccessClosed = "can_access_closed"
        case screenName = "screen_name"
        case online, id
        case photo100 = "photo_100"
        case lastName = "last_name"
        case photo50 = "photo_50"
        case onlineInfo = "online_info"
        case sex
        case isClosed = "is_closed"
        case firstName = "first_name"
        case deactivated
        case onlineMobile = "online_mobile"
        case onlineApp = "online_app"
    }
}

// MARK: - OnlineInfo
struct OnlineInfo: Codable {
    let visible, isMobile, isOnline: Bool
    let appID, lastSeen: Int?

    enum CodingKeys: String, CodingKey {
        case visible
        case isMobile = "is_mobile"
        case isOnline = "is_online"
        case appID = "app_id"
        case lastSeen = "last_seen"
    }
}
