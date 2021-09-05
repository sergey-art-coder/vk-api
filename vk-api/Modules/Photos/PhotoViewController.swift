//
//  PhotoViewController.swift
//  1|SergeyLyashenko
//
//  Created by Сергей Ляшенко on 24.08.2021.
//

import UIKit

class PhotoViewController: UIViewController {
    
    let myPhotos = "MyPhotos"
    var photos: [PhotoModel]!
    var photo: PhotoModel!
    
    @IBOutlet weak var photoImageView: PhotoModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //photoImageView = photos.first
}
