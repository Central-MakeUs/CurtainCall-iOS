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
    static let hex2B313A = UIColor(named: "#2B313A")
    static let hex3B4350 = UIColor(named: "#3B4350")
    static let hex5A6271 = UIColor(named: "#5A6271")
    static let hex161A20 = UIColor(named: "#161A20")
    static let hex828996 = UIColor(named: "#828996")
    static let hexBEC2CA = UIColor(named: "#BEC2CA")
    static let hexE4E7EC = UIColor(named: "#E4E7EC")
    static let hexF2F3F5 = UIColor(named: "#F2F3F5")
    static let hexF5F6F8 = UIColor(named: "#F5F6F8")
    static let heading = UIColor(named: "heading")
    static let body1 = UIColor(named: "body 1")
    static let myBlue = UIColor(named: "myBlue")
    static let myRed = UIColor(named: "myRed")
    static let pointColor1 = UIColor(named: "point color 1")
    static let pointColor2 = UIColor(named: "point color 2")
    static let pointColor3 = UIColor(named: "point color 3")
    static let title = UIColor(named: "title")
    
    
}
