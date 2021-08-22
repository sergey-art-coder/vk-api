//
//  PhotosFriendCollectionViewController.swift
//  1|SergeyLyashenko
//
//  Created by Сергей Ляшенко on 21.08.2021.
//

import UIKit

class PhotosFriendCollectionViewController: UICollectionViewController {
    
    private let reuseIdentifier = "PhotosFriendsCell"
    let photosFriendsCell = "PhotosFriendsCell"
    
    var photosUsers: FriendModel!
    
    let photosAPI = PhotosAPI()
    
    var photos: [PhotosModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Получаем фото, добавляем их в таблицу
        photosAPI.getPhotos { [weak self] user in
            
            // сохраняем в photos
            //  self?.photos = users!
            self?.collectionView.reloadData()
            
            
        }
        
        photosAPI.getPhotos { users in
            
        }
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        // Do any additional setup after loading the view.
    }
    
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return photos.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PhotosFriendCollectionViewCell
        
        // берем фото из массива по indexPath
        let photo: PhotosModel = photos[indexPath.item]
        
        cell.photosFriendImage = photo
        
        return cell
    }
    
    
}
