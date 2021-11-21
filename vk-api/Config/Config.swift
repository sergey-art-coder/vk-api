//
//  Config.swift
//  1|SergeyLyashenko
//
//  Created by Сергей Ляшенко on 16.11.2021.
//

import Foundation
import UIKit

let maxWordsCount = 50
let readMore = "Ещё..."

let activeURLColor = UIColor(red: 41.0/255, green: 151.0/255, blue: 255.0/255, alpha: 1)
let activeURLColorSelected = UIColor(red: 41.0/255, green: 151.0/255, blue: 255.0/255, alpha: 0.5)

let activeHashTagColor = UIColor(red: 255.0/255, green: 123.0/255, blue: 114.0/255, alpha: 1)
let activeHashTagColorSelected = UIColor(red: 255.0/255, green: 123.0/255, blue: 114.0/255, alpha: 0.5)

let imageCache = NSCache<NSString, UIImage>()
let dateTimeCache = NSCache<NSNumber, NSString>()
