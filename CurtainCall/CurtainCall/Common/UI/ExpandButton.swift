//
//  ExpandButton.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/07/06.
//

import UIKit

final class ExpandButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setImage(UIImage(named: ImageNamespace.ExpandButtonArrowBottom), for: .normal)
        setImage(UIImage(named: ImageNamespace.ExpandButtonArrowUp), for: .selected)
    }
    
    @available (*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
