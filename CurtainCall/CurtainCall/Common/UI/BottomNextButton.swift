//
//  BottomNextButton.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/07/22.
//

import UIKit

final class BottomNextButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureButton()
    }
    
    @available (*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureButton() {
        titleLabel?.font = .systemFont(ofSize: 18, weight: .medium)
        backgroundColor = .hexE4E7EC
        setTitleColor(.hexBEC2CA, for: .normal)
        layer.cornerRadius = 12
    }
    
    func setNextButton(isSelected: Bool) {
        backgroundColor = isSelected ? .pointColor2 : .hexE4E7EC
        setTitleColor(isSelected ? .white : .hexBEC2CA, for: .normal)
        isUserInteractionEnabled = isSelected
    }
}
