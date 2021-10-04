//
//  FotoCollectionViewController.swift
//  1|SergeyLyashenko
//
//  Created by Сергей Ляшенко on 07.09.2021.
//

import UIKit

class PhotosCollectionViewController: UICollectionViewController {
    
    private let customCollectionViewCellIdentifier = "CustomCollectionViewCellIdentifier"
    var photos: [PhotoModel] = []
    var selectedIndex: Int = 0
    var imageScrollView: ImageScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // регестрируем ячейку
        collectionView.register(UINib(nibName: "CustomCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: customCollectionViewCellIdentifier)
        
        self.collectionView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    // MARK: - UICollectionViewDataSource
    
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
                
                //   cell.photoImageView.image = imagePhoto
                
                // инициализируем imageScrollView (открываем через frame куда передаем view.bounds)
                imageScrollView = ImageScrollView(frame: view.bounds)
                // добавим imageScrollView на экран
                view.addSubview(imageScrollView)
                  
                setupImageScrollView()
                
                // из imageScrollView передаем в функцию set фотографии
                self.imageScrollView.set(image: imagePhoto)
            }
        }
        catch {
            
            print(error)
        }
        
        return cell
    }
}

// MARK: - зафиксируем imageScrollView с помощю Constraints (Constraints - ограничения)
extension PhotosCollectionViewController {
    
    func setupImageScrollView() {
        
        // в imageScrollView вызовим свойство translatesAutoresizingMaskIntoConstraints которое позволяет работать с констрейтами
        imageScrollView.translatesAutoresizingMaskIntoConstraints = false
        
        // верхняя граница
        imageScrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        // нижняя граница
        imageScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        // правая граница
        imageScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        // левая граница
        imageScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    }
}
