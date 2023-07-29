//
//  BorderView.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/07/28.
//

import UIKit

import SnapKit

final class BorderView: UIView {
    
    init() {
        super.init(frame: .zero)
        backgroundColor = .hexF2F3F5
    }
    
    @available (*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
