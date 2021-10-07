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
    var photoImageView: UIImageView!
    var imagePhotoSwipe: UIImage!
    
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
                
                // MARK: - swipe
                // добавим жест в лево
                let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(swipeRightAction))
                swipeRight.direction = .right
                view.addGestureRecognizer(swipeRight)
                
                // добавим жест в право
                let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(swipeLeftAction))
                swipeLeft.direction = .left
                view.addGestureRecognizer(swipeLeft)
                
            }
        }
        
        catch {
            
            print(error)
        }
        
        return cell
    }
}


// MARK: - swipe
extension PhotosCollectionViewController {
    @objc
    func swipeRightAction() {
        
        // убедимся что мы не на последней картинке
        guard photos.count > selectedIndex + 1 else { return }
        // если есть куда свайпать то мы получаем картинку
        let nextImage = photos[selectedIndex + 1]
        
        let urlPathSwipe = nextImage.sizes.last
        guard let urlSwipe = urlPathSwipe?.url else { return }
        if let urlPhotoSwipe = URL(string: urlSwipe), let dataSwipe = try? Data(contentsOf: urlPhotoSwipe), let imagePhotoSwipe = UIImage(data: dataSwipe) {
            
            photoImageView = UIImageView(image: imagePhotoSwipe)
            self.imageScrollView.set(image: imagePhotoSwipe)
        }
        
        // создали UIImageView
        let newTemporaryImageView = UIImageView()
        newTemporaryImageView.backgroundColor = view.backgroundColor
        newTemporaryImageView.contentMode = .scaleAspectFit
        
        newTemporaryImageView.image = imagePhotoSwipe
        // frame указываем как в текущей картинке
        newTemporaryImageView.frame = photoImageView.frame
        // двигаем в право на ширину этой картинки photoImageView
        newTemporaryImageView.frame.origin.x += photoImageView.frame.width
        // добавляем в addSubview
        view.addSubview(newTemporaryImageView)
        // начинаем анимацию
        UIView.animateKeyframes(withDuration: 1, delay: 0, options: []) {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.3) {
                // существующею картинку уменьшаем на 20% (делаем scaleX 0.8)
                self.photoImageView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            }
            UIView.addKeyframe(withRelativeStartTime: 0.3, relativeDuration: 0.7) {
                // с права картинку двигаем в лево, двигаем туда где сейчас находится текущая картинка
                newTemporaryImageView.frame.origin.x = 0
            }
        } completion: { _ in
            // повышаем selectedIndex
            self.selectedIndex += 1
            // ставим следующую картинку по списку
            self.photoImageView.image = self.imagePhotoSwipe
            // отменяем трансформацию
            self.photoImageView.transform = .identity
            // удаляем временную картинку
            newTemporaryImageView.removeFromSuperview()
        }
    }
    
    @objc
    func swipeLeftAction() {
        
        // если selectedIndex > 0 то можем свайпать назад
        guard selectedIndex > 0 else { return }
        
        // если есть куда свайпать то мы получаем картинку
        let nextImage = photos[selectedIndex - 1]
        
        let urlPathSwipe = nextImage.sizes.last
        guard let urlSwipe = urlPathSwipe?.url else { return }
        if let urlPhotoSwipe = URL(string: urlSwipe), let dataSwipe = try? Data(contentsOf: urlPhotoSwipe), let imagePhotoSwipe = UIImage(data: dataSwipe) {
            
            photoImageView = UIImageView(image: imagePhotoSwipe)
            self.imageScrollView.set(image: imagePhotoSwipe)
        }
        
        // создали UIImageView
        let newTemporaryImageView = UIImageView()
        newTemporaryImageView.backgroundColor = view.backgroundColor
        newTemporaryImageView.contentMode = .scaleAspectFit
        
        newTemporaryImageView.image = imagePhotoSwipe
        // frame указываем как в текущей картинке
        newTemporaryImageView.frame = photoImageView.frame
        // уменьшаем картинку которая с зади до scaleX: 0.8
        newTemporaryImageView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        // добавляем в addSubview
        view.addSubview(newTemporaryImageView)
        // ставим картинку на задний план
        view.sendSubviewToBack(newTemporaryImageView)
        // начинаем анимацию
        UIView.animateKeyframes(withDuration: 1, delay: 0, options: []) {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.7) {
                self.photoImageView.transform = CGAffineTransform(translationX: self.view.bounds.width, y: 0)
            }
            UIView.addKeyframe(withRelativeStartTime: 0.3, relativeDuration: 0.3) {
                newTemporaryImageView.transform = .identity
            }
        } completion: { _ in
            // повышаем selectedIndex
            self.selectedIndex -= 1
            // ставим следующую картинку по списку
            self.photoImageView.image = self.imagePhotoSwipe
            // отменяем трансформацию
            self.photoImageView.transform = .identity
            // удаляем временную картинку
            newTemporaryImageView.removeFromSuperview()
        }
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


