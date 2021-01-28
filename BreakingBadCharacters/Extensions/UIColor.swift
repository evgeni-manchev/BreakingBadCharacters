//
//  UIColor.swift
//  BreakingBadCharacters
//
//  Created by Evgeni Manchev on 28.01.21.
//

import UIKit

extension UIColor {
    public convenience init(hex: Int) {
        let blue = CGFloat(hex & 0xFF)
        let green = CGFloat((hex >> 8) & 0xFF)
        let red = CGFloat((hex >> 16) & 0xFF)
        self.init(red: red / 255.0, green: green / 255.0, blue: blue / 255.0, alpha: 1.0)
    }
}
