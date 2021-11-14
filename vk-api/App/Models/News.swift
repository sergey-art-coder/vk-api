//
//  News.swift
//  1|SergeyLyashenko
//
//  Created by Сергей Ляшенко on 04.09.2021.
//

import Foundation

// MARK: - NewsResponse
struct NewsResponse: Codable {
    let response: NewsModel
}

// MARK: - Response
struct NewsModel: Codable {
    let items: [Items]
    let profiles: [Profile]
    let groups: [Group]

//    let nextFrom: String

    enum CodingKeys: String, CodingKey {
        case items, groups, profiles
//        case nextFrom = "next_from"
    }
}

// MARK: - Group
struct Group: Codable {
    let isMember, id: Int
    let photo100: String
    let isAdvertiser, isAdmin: Int
    let photo50, photo200: String
    let type: GroupType
    let screenName, name: String
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

enum GroupType: String, Codable {
    case group = "group"
    case page = "page"
}

// MARK: - Items
struct Items: Codable {
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
    let postID: Int
    let markedAsAds: Int?
    let postSource: ItemPostSource
    let views: Views
    let copyHistory: [CopyHistory]?
    let carouselOffset: Int?
    let attachments: [ItemAttachment]?
    let signerID: Int?

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
        case postID = "post_id"
        case markedAsAds = "marked_as_ads"
        case postSource = "post_source"
        case views
        case copyHistory = "copy_history"
        case carouselOffset = "carousel_offset"
        case attachments
        case signerID = "signer_id"
    }
}

// MARK: - ItemAttachment
struct ItemAttachment: Codable {
    let type: AttachmentType
    let album: Album?
    let photo: Photos?
    let link: Links?
}

// MARK: - Album
struct Album: Codable {
    let updated, id: Int
    let title: String
    let size, created: Int
    let thumb: Photos
    let albumDescription: String
    let ownerID: Int

    enum CodingKeys: String, CodingKey {
        case updated, id, title, size, created, thumb
        case albumDescription = "description"
        case ownerID = "owner_id"
    }
}

// MARK: - Photo
struct Photos: Codable {
    let albumID, id, date: Int
    let text: String
    let userID: Int?
    let sizes: [Sizes]
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

// MARK: - Sizes
struct Sizes: Codable {
    let width, height: Int
    let url: String
    let type: SizeType
}

enum SizeType: String, Codable {
    case k = "k"
    case l = "l"
    case m = "m"
    case o = "o"
    case p = "p"
    case q = "q"
    case r = "r"
    case s = "s"
    case w = "w"
    case x = "x"
    case y = "y"
    case z = "z"
}

// MARK: - Link
struct Links: Codable {
    let button: Button?
    let product: Product?
    let isFavorite: Bool
    let title, linkDescription: String
    let photo: Photos
    let caption: String?
    let url: String
    let target: String?

    enum CodingKeys: String, CodingKey {
        case button, product
        case isFavorite = "is_favorite"
        case title
        case linkDescription = "description"
        case photo, caption, url, target
    }
}

// MARK: - Button
struct Button: Codable {
    let title: String
    let action: Action
}

// MARK: - Action
struct Action: Codable {
    let type: String
    let url: String
}

// MARK: - Product
struct Product: Codable {
    let price: Price
}

// MARK: - Price
struct Price: Codable {
    let amount: String
    let currency: Currency
    let text: String
}

// MARK: - Currency
struct Currency: Codable {
    let id: Int
    let name, title: String
}

enum AttachmentType: String, Codable {
    case album = "album"
    case link = "link"
    case photo = "photo"
}

// MARK: - Comments
struct Comments: Codable {
    let count, canPost: Int
    let groupsCanPost: Bool?

    enum CodingKeys: String, CodingKey {
        case count
        case canPost = "can_post"
        case groupsCanPost = "groups_can_post"
    }
}

// MARK: - CopyHistory
struct CopyHistory: Codable {
    let postSource: CopyHistoryPostSource
    let postType: PostTypeEnum
    let id, fromID, date: Int
    let text: String
    let attachments: [CopyHistoryAttachment]
    let ownerID: Int

    enum CodingKeys: String, CodingKey {
        case postSource = "post_source"
        case postType = "post_type"
        case id
        case fromID = "from_id"
        case date, text, attachments
        case ownerID = "owner_id"
    }
}

// MARK: - CopyHistoryAttachment
struct CopyHistoryAttachment: Codable {
    let type: AttachmentType
    let photo: Photos
}

// MARK: - CopyHistoryPostSource
struct CopyHistoryPostSource: Codable {
    let type: PostSourceType
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

// MARK: - ItemPostSource
struct ItemPostSource: Codable {
    let type: PostSourceType
    let platform: String?
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
