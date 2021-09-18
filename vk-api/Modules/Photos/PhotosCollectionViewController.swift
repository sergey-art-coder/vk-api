//
//  FotoCollectionViewController.swift
//  1|SergeyLyashenko
//
//  Created by Сергей Ляшенко on 07.09.2021.
//

import UIKit
import SDWebImage

class PhotosCollectionViewController: UICollectionViewController {
    
    private let customCollectionViewCellIdentifier = "CustomCollectionViewCellIdentifier"
    //  var photo: PhotoModel?
    var photo = PhotoModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // регестрируем ячейку
        collectionView.register(UINib(nibName: "CustomCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: customCollectionViewCellIdentifier)
        
        self.collectionView.reloadData()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // print(self.photo)
    }
    
    // MARK: UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: customCollectionViewCellIdentifier, for: indexPath) as? CustomCollectionViewCell else { return UICollectionViewCell() }
        DispatchQueue.global().async {
            
            do {
                
                guard let photoPath = self.photo.fotosSizes != nil ? self.photo.fotosSizes : self.photo.fotosSizes else { return }
                let urlPhoto = URL(string:photoPath)
                guard let urlPhoto = urlPhoto else { return }
                let data = try? Data(contentsOf: urlPhoto)
                
                DispatchQueue.main.async {
                    
                    guard let data = data else { return }
                    cell.photoImageView.image = UIImage(data: data)
                }
            }
            catch {
                
                print(error)
            }
        }
        
        return cell
    }
}

