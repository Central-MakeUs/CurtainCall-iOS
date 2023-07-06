//
//  UIStackView + Extension.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/07/06.
//

import UIKit

extension UIStackView {
    func addSubviews(_ views: UIView...) { views.forEach { addArrangedSubview($0) }}
}
