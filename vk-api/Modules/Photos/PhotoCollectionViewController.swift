//
//  PhotosFriendCollectionViewController.swift
//  1|SergeyLyashenko
//
//  Created by Сергей Ляшенко on 21.08.2021.
//

import UIKit
import RealmSwift
import SDWebImage

class PhotoCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let photoCell = "PhotoCell"
    let toPhoto = "toPhoto"
    //  let photosDB = PhotosDB()
    let photosAPI = PhotosAPI()
    var photos: [PhotoModel] = []
    var selectedIndex: Int = 0
    
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
        do {
            let photo = self.photos [indexPath.item]
            
            let sizeMomel = photo.sizes.last
            
            guard let url = sizeMomel?.url else { return cell}
            
            cell.photoImage.layer.borderWidth = 3
            cell.photoImage.layer.borderColor = UIColor.lightGray.cgColor
            
            cell.photoImage?.sd_setImage(with: URL(string: url), placeholderImage: UIImage())
        }
        catch {
            
            print(error)
        }
        
        return cell
    }
    
    // MARK: - прописывам нужный размер ячейки
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var width = collectionView.bounds.width
        let insets = collectionView.contentInset.left + collectionView.contentInset.right
        width -= insets
        width -= 40
        width /= 3
        return CGSize(width: width, height: width)
    }
    
    // сохраняем выбранный индекс в переменной selectedIndex и убираем выделения
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndex = indexPath.item
        performSegue(withIdentifier: toPhoto, sender: selectedIndex)
    }
    
    // метод через который мы переходим на PhotosCollectionViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //вызываем подготовку к переходу
        super.prepare(for: segue, sender: sender)
        
        // проверяем что индитификатор называется "toPhoto"
        if segue.identifier == toPhoto {
            
            guard let detailVC = segue.destination as? PhotosCollectionViewController,
                  let indexPath = self.collectionView.indexPathsForSelectedItems?.first else { return }
            
            detailVC.selectedIndex = indexPath.item
            detailVC.photos = photos
        }
    }
}

//                   guard (photo?.sizes.first != nil ? photo?.sizes.first : photo?.sizes.first) != nil else { return }


