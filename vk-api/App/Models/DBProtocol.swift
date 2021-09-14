//
//  File.swift
//  1|SergeyLyashenko
//
//  Created by Сергей Ляшенко on 29.08.2021.
//

import Foundation

protocol FriendsDBProtocol {
    func add(_ frend: FriendModel)
    func read() -> [FriendModel]
    func delete(_ frend: FriendModel)
}

protocol GroupsDBProtocol {
    func add(_ grup: GroupModel)
    func read() -> [GroupModel]
    func delete(_ grup: GroupModel)
}

protocol PhotosDBProtocol {
    func add(_ foto: PhotoModel)
    func read() -> [PhotoModel]
    func delete(_ foto: PhotoModel)
}
