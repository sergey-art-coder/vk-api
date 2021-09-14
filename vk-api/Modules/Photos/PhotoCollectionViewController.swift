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
    let photosDB = PhotosDB()
    let photosAPI = PhotosAPI()
    var photos: [PhotoModel] = []
    var selectedPhotos: [PhotoModel] = []
    var selectedFriend: FriendModel?
    
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
     
        DispatchQueue.global().async {
            
            do {
                
//                let filterFoto = self.photos.compactMap { ($0) }
//
//                print(filterFoto)
                
                //берем фото из массива по indexPath
                let photo = self.photos [indexPath.item]

                guard let photoPath = photo.photo1280 != nil ? photo.photo1280 : photo.photo604 else { return }
                let urlPhoto = URL(string:photoPath)
                guard let urlPhoto = urlPhoto else { return }
                let data = try? Data(contentsOf: urlPhoto)
                
                DispatchQueue.main.async {
                    
                    //                    self.photosDB.add(photo)
                    //                    print(self.photosDB.read())
                    //                    self.photosDB.delete(photo)
                    //                    print(self.photosDB.read())
                    guard let data = data else { return }
                    cell.photoImage.image = UIImage(data: data)
                }
            }
            catch {
                
                print(error)
            }
        }
        
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
            
            guard let detailVC = segue.destination as? FotoCollectionViewController,
                  let indexPath = self.collectionView.indexPathsForSelectedItems?.first else { return }
            
            let photo: PhotoModel? = photos [indexPath.item]
            
            guard (photo?.photo1280 != nil ? photo?.photo1280 : photo?.photo604) != nil else { return }
            
            guard let photo = photo else { return }
            detailVC.photo = photo
        }
    }
}

