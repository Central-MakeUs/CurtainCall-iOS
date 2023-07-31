//
//  CALayer + Extension.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/07/31.
//

import UIKit

extension CALayer {
    func applySketchShadow(
           color: UIColor,
           alpha: Float,
           x: CGFloat,
           y: CGFloat,
           blur: CGFloat,
           spread: CGFloat
       ) {
           masksToBounds = false
           shadowColor = color.cgColor
           shadowOpacity = alpha
           shadowOffset = CGSize(width: x, height: y)
           shadowRadius = blur / UIScreen.main.scale
           if spread == 0 {
               shadowPath = nil
           } else {
               let rect = bounds.insetBy(dx: -spread, dy: -spread)
               shadowPath = UIBezierPath(rect: rect).cgPath
           }
       }
}
