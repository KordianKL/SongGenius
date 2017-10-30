//
//  UIColorExtension.swift
//  Song Genius
//
//  Created by Kordian Ledzion on 31.07.2017.
//  Copyright © 2017 KordianLedzion. All rights reserved.
//

import UIKit

extension UIColor {
    
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat = 1.0) {
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: a)
    }
}
