//
//  CheckMarkButton.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/07/06.
//

import UIKit

final class CheckMarkButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setImage(UIImage(named: ImageNamespace.checkmarkButtonDeselected), for: .normal)
        setImage(UIImage(named: ImageNamespace.checkmarkButtonSelected), for: .selected)
        
        // TODO: Deprecated로 인해 변경해야함
        adjustsImageWhenHighlighted = false

    }
    
    @available (*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
