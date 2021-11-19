//
//  LikeButton.swift
//  1|SergeyLyashenko
//
//  Created by Сергей Ляшенко on 16.11.2021.
//

import Foundation
import UIKit

class LikeButton: UIButton {
    
    var likesCount = 0
    var isLikedByMe = false
    var itemID = 0
    var ownerID = 0
    var handlerLiked: () -> Void = {}
    var handlerUnLiked: () -> Void = {}
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addActions()
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 15, height: 30)
    }
    
    func configureLikeButton(likesCount: Int,
                   isLikedByMe: Bool,
                   itemID: Int,
                   ownerID: Int,
                   completionHandlerLiked: @escaping () -> Void,
                   completionHandlerUnLiked: @escaping () -> Void) {
        
        self.likesCount = likesCount
        self.isLikedByMe = isLikedByMe
        self.itemID = itemID
        self.ownerID = ownerID
        self.handlerLiked = completionHandlerLiked
        self.handlerUnLiked = completionHandlerUnLiked
        
        self.contentHorizontalAlignment = .leading
        self.titleLabel?.font = UIFont.preferredFont(forTextStyle: .footnote)
        
        setTitleDependingOnState()
        
    }
    
    private func addActions() {
        
        addTarget(self, action: #selector(onTap(_:)), for: .touchUpInside)
    }
    
    private func setTitleDependingOnState() {
        
        self.setTitleColor(isLikedByMe ?  UIColor.systemPink : UIColor.secondaryLabel, for: .normal)
        self.setTitle("\(isLikedByMe ? "♥" : "♡") \(likesCount.formatted)", for: .normal)
    }
    
    @objc func onTap(_ sender: UIButton) {
        
        isLikedByMe.toggle()
        likesCount += isLikedByMe ? 1 : -1
        self.setTitleDependingOnState()
    }
}

