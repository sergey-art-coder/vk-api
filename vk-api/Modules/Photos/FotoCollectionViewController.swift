//
//  FotoCollectionViewController.swift
//  1|SergeyLyashenko
//
//  Created by Сергей Ляшенко on 07.09.2021.
//

import UIKit
import SDWebImage

class FotoCollectionViewController: UICollectionViewController {
    
    private let customCollectionViewCellIdentifier = "CustomCollectionViewCellIdentifier"
    var photos: [PhotoModel]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // регестрируем ячейку
        collectionView.register(UINib(nibName: "CustomCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: customCollectionViewCellIdentifier)
    }
    
    // MARK: UICollectionViewDataSource
    
//    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//
//        return 1
//    }
//
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: customCollectionViewCellIdentifier, for: indexPath) as? CustomCollectionViewCell else { return UICollectionViewCell() }
        
        //        let urlPhoto = URL(string:(photos?.first), placeholderImage: UIImage())
        //
        //        let data = try? Data(contentsOf: urlPhoto!)
        //
        //        cell.photoImageView.image = UIImage(data: data!)
        
        
        //          guard let urlString = photos?.first else { return cell}
        //          cell.photoImageView.sd_setImage(with: URL(string: urlString), placeholderImage: UIImage())
        
        return cell
    }
}
