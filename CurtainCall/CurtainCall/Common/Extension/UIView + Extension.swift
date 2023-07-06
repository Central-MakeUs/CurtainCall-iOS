//
//  UIView + Extension.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/07/06.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) { views.forEach { addSubview($0) } }
}
