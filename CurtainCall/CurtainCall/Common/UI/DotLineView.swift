//
//  DotLineView.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/07/24.
//

import UIKit

import SnapKit

final class DotLineView: UIView {
    
    init() {
        super.init(frame: .zero)
        backgroundColor = .white
        drawDotLine()
    }
    
    @available (*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
    private func drawDotLine() {
        let borderLayer = CAShapeLayer()
        borderLayer.strokeColor = UIColor.black.cgColor
        borderLayer.lineDashPattern = [2, 2]
        borderLayer.frame = bounds
        borderLayer.fillColor = nil
        borderLayer.path = UIBezierPath(rect: bounds).cgPath
        layer.addSublayer(borderLayer)
    }
}
