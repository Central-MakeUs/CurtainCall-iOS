//
//  GuideCategoryButton.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/08/12.
//

import UIKit

final class GuideCategoryButton: UIButton {
    
    var guideType: PerformanceExpressionType?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        titleLabel?.font = .body1
        setTitleColor(.hexBEC2CA, for: .normal)
        setTitleColor(.white, for: .selected)
        backgroundColor = !isSelected ? .white : .pointColor1
        layer.cornerRadius = 12
        // TODO: Deprecated로 인해 변경해야함
        adjustsImageWhenHighlighted = false

    }
    
    @available (*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setBackground(_ isSelected: Bool) {
        backgroundColor = !isSelected ? .white : .pointColor1
    }

}

final class MyWriteCategoryButton: UIButton {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        titleLabel?.font = .body1
        setTitleColor(.pointColor1, for: .normal)
        setTitleColor(.white, for: .selected)
        backgroundColor = !isSelected ? .hexF5F6F8 : .pointColor1
        layer.cornerRadius = 12
        // TODO: Deprecated로 인해 변경해야함
        adjustsImageWhenHighlighted = false

    }
    
    @available (*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setBackground(_ isSelected: Bool) {
        backgroundColor = !isSelected ? .hexF5F6F8 : .pointColor1
    }

}
