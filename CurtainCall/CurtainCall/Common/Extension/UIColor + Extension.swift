//
//  UIColor + Extension.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/07/04.
//

import UIKit

extension UIColor {
    
    /// ex) UIColor(red: 65, green: 65, blue: 65)
    /// - Parameters:
    ///   - red: red value
    ///   - green: green value
    ///   - blue: blue value
    ///   - a: alpha
    convenience init(red: Int, green: Int, blue: Int, alpha: Int = 0xFF) {
        self.init(
            red: CGFloat(red) / 255.0,
            green: CGFloat(green) / 255.0,
            blue: CGFloat(blue) / 255.0,
            alpha: CGFloat(alpha) / 255.0
        )
    }
    
    /// ex) UIColor(rgb: 0xFFFFFF)
    /// - Parameter rgb: 0x + hexCode
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }

}

// MARK: - Color Assets

extension UIColor {
    static let gray1 = UIColor(named: "gray1")
    static let gray2 = UIColor(named: "gray2")
    static let deepDark = UIColor(named: "deep_dark")
    static let sunsetPink = UIColor(named: "sunset_pink")
    
}
