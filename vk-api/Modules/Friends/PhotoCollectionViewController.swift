//
//  PhotosFriendCollectionViewController.swift
//  1|SergeyLyashenko
//
//  Created by Сергей Ляшенко on 21.08.2021.
//

import UIKit

class PhotoCollectionViewController: UICollectionViewController {
    
    let photoCell = "PhotoCell"
    
    let photosAPI = PhotosAPI()
    
    var photos: [PhotoModel] = []
    
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
                
                let urlPhoto = URL(string:photo.photo1280)
                
                let data = try? Data(contentsOf: urlPhoto!)
                
                DispatchQueue.main.async {
                    
                    cell.photoImage.image = UIImage(data: data!)
                }
            }
            catch {
                
                print(error)
            }
        }
        
        return cell
    }
}
