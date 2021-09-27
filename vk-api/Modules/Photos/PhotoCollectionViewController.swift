//
//  PhotosFriendCollectionViewController.swift
//  1|SergeyLyashenko
//
//  Created by Сергей Ляшенко on 21.08.2021.
//

import UIKit
import RealmSwift

class PhotoCollectionViewController: UICollectionViewController {
    
    let photoCell = "PhotoCell"
    let toPhoto = "toPhoto"
    //  let photosDB = PhotosDB()
    let photosAPI = PhotosAPI()
    //var photo = PhotoModel()
    var photo: [PhotoModel] = []
    var photos: [PhotoModel] = []
    var selectedPhotos: [PhotoModel] = []
    //var selectedFriend: FriendModel?
    
    //пустой массив куда будем помещать отфильтрованные записи
    var filterFoto: [PhotoModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Получаем фото, добавляем их в таблицу
        photosAPI.getPhotos { [weak self] users in
            guard let self = self else { return }
            
            // сохраняем в photos
            guard let users = users else { return }
            self.photos = users
            self.collectionView.reloadData()
        }
    }
    
    // MARK: UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return photos.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: photoCell, for: indexPath) as? PhotoCollectionViewCell else { return UICollectionViewCell() }
        
        let photo = self.photos [indexPath.item]
        
        cell.photoImage.image = UIImage[photo.sizes.last]
        
        
        return cell
    }
    
    // сохраняем выбранный индекс в переменной selectedPhotos и убираем выделения
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedPhotos = [photos [indexPath.item]]
        performSegue(withIdentifier: toPhoto, sender: self)
    }
    
    // метод через который мы переходим на PhotoViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //вызываем подготовку к переходу
        super.prepare(for: segue, sender: sender)
        
        // проверяем что индитификатор называется "toPhoto"
        if segue.identifier == toPhoto {
            
            guard let detailVC = segue.destination as? PhotosCollectionViewController,
                  let indexPath = self.collectionView.indexPathsForSelectedItems?.first else { return }
            
            let photo: PhotoModel? = photos [indexPath.item]
            
            guard (photo?.sizes.first != nil ? photo?.sizes.first : photo?.sizes.first) != nil else { return }
            
            guard let photo = photo else { return }
            detailVC.photo = [photo]
        }
    }
}


