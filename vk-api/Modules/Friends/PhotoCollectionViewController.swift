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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        photosAPI.getPhotos { [weak self] users in
            
            //Получаем фото, добавляем их в таблицу
            guard let self = self else { return }
            //   print(users)
            
            self.photos = users!
            self.collectionView.reloadData()
        }
    }
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return photos.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: photoCell, for: indexPath) as? PhotoCollectionViewCell else { return UICollectionViewCell() }
        
        DispatchQueue.global().async {
            
            do {
                //берем фото из массива по indexPath
                let photo = self.photos [indexPath.item]
                
                DispatchQueue.main.async {
                    
                    self.photosDB.add(photo)
                    print(self.photosDB.read())
                    //                    self.photosDB.delete(photo)
                    //                    print(self.photosDB.read())
                    
                    guard let urlString = photo.photo1280 else { return }
                    cell.photoImage?.sd_setImage(with: URL(string: urlString), placeholderImage: UIImage())
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
            
            // проверяем что контроллер на который мы переходим является контроллером типа PhotoViewController и передаем photos
            guard let detailVC = segue.destination as? PhotoViewController else { return }
            detailVC.photos = selectedPhotos
        }
    }
}
