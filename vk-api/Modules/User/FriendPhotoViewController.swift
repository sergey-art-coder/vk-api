//
//  FriendPhotoViewControllerCollection.swift
//  1|SergeyLyashenko
//
//  Created by Сергей Ляшенко on 19.05.2021.
//

import UIKit

class FriendPhotoViewController: UIViewController {
    
    var photos: [UIImage]!
    
    @IBOutlet weak var photoImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        photoImageView.image = photos.first
    }
}

