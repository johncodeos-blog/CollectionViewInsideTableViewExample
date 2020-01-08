//
//  Extensions.swift
//  CollectionViewInsideTableViewExample
//
//  Created by John Codeos on 12/21/19.
//  Copyright © 2019 John Codeos. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    static func rgbColor(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red / 255, green: green / 255, blue: blue / 255, alpha: 1.0)
    }
    
    static func colorFromHex(_ hex: String) -> UIColor {
        var hexString = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        if hexString.hasPrefix("#") {
            hexString.remove(at: hexString.startIndex)
        }
        if hexString.count != 6 {
            return UIColor.magenta
        }
        
        var rgb: UInt64 = 0
        Scanner(string: hexString).scanHexInt64(&rgb)
        
        return UIColor(red: CGFloat((rgb & 0xFF0000) >> 16) / 255,
                       green: CGFloat((rgb & 0x00FF00) >> 8) / 255,
                       blue: CGFloat(rgb & 0x0000FF) / 255,
                       alpha: 1.0)
    }
}
