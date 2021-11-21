//
//  UserInfoViewController.swift
//  1|SergeyLyashenko
//
//  Created by Сергей Ляшенко on 14.11.2021.
//

import UIKit
import PromiseKit
import Alamofire
import AlamofireImage

class InfoUsersViewController: UIViewController {
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userFirstNameLabel: UILabel!
    @IBOutlet weak var userLastNameLabel: UILabel!
    @IBOutlet weak var userLocationLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        promiseFetchUserData().then { [self] infoUsers in
            
            promiseFetchUserPicture(infoUsers).map{ ($0, infoUsers) }
            
        }.done { [self] image, infoUsers in
            
            displayUserInfo(infoUsers: infoUsers, image: image)
            
        }.catch { error in
            
            print(error)
        }
    }
    
    // MARK: - Promise methods.
    
    func promiseFetchUserData() -> Promise<InfoUsersResponse> {
        
        return Promise<InfoUsersResponse> { seal in
            
            InfoUserAPI(Session.shared).getInfoUser{ [weak self] infoUsers in
                
                guard self == self else {
                    seal.reject(InfoUserAPI.Errors.unknownError)
                    return
                }
                guard let infoUsers = infoUsers else { return }
                seal.fulfill(infoUsers)
            }
        }
    }
    
    func promiseFetchUserPicture(_ user: InfoUsersResponse) -> Promise<UIImage> {
        
        return Promise<UIImage> { seal in
            
            guard let imageUrl = user.response[0].photo200 else {
                seal.reject(InfoUserAPI.Errors.noPhotoUrl)
                return
            }
            
            AF.request(imageUrl, method: .get).responseImage { response in
                
                guard let image = response.value else { return }
                seal.fulfill(image)
            }
        }
    }
    
    // MARK: - Private methods.
    
    private func displayUserInfo(infoUsers: InfoUsersResponse, image: UIImage) {
        
        userFirstNameLabel.text = "\(infoUsers.response[0].firstName)"
        userLastNameLabel.text = "\(infoUsers.response[0].lastName)"
        userLocationLabel.text = "\(infoUsers.response[0].city.title), \(infoUsers.response[0].country.title)"
        userImageView.image = image
        
        self.userImageView.isHidden = false
        self.userFirstNameLabel.isHidden = false
        self.userLastNameLabel.isHidden = false
        self.userLocationLabel.isHidden = false
    }
}
