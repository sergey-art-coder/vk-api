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
    var photos: [PhotoModel] = []
    var selectedIndex: Int = 0
    
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
        
        do {
            
            let photoPath = self.photos[self.selectedIndex]
            let urlPath = photoPath.sizes.last
            guard let url = urlPath?.url else { return cell }
            
            if let urlPhoto = URL(string: url), let data = try? Data(contentsOf: urlPhoto), let imagePhoto = UIImage(data: data) {
                
                cell.photoImageView.image = imagePhoto
            }
        }
        catch {
            
            print(error)
        }
        
        return cell
    }
}
