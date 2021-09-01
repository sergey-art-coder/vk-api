//
//  PhotoViewController.swift
//  1|SergeyLyashenko
//
//  Created by Сергей Ляшенко on 24.08.2021.
//

import UIKit

class PhotoViewController: UIViewController {
    
    var photos: [PhotoModel]!
    
    @IBOutlet weak var photoImageView: PhotoModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        photoImageView.self = photos.first
    }
}
