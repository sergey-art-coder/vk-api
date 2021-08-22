//
//  FriendsViewController.swift
//  1|SergeyLyashenko
//
//  Created by Сергей Ляшенко on 17.08.2021.
//

import UIKit

class FriendsViewController: UITableViewController {
    
    let friendsAPI = FriendsAPI()
    let photosAPI = PhotosAPI()
    let groupsAPI = GroupsAPI()
    let searchGroupsAPI = SearchGroupsAPI()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        friendsAPI.getFriends { users in
            
        }
        photosAPI.getPhotos { users in
            
        }
        groupsAPI.getGroups { users in
            
        }
        searchGroupsAPI.getSearchGroups { users in
            
        }
    }
}
