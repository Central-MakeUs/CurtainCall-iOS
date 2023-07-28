//
//  GradeStackView.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/07/28.
//

import UIKit

final class GradeStackView: UIStackView {
    
    init() {
        super.init(frame: .zero)
        axis = .horizontal
        spacing = 0
        distribution = .fillEqually
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func draw(grade: Double) {
        switch grade {
        case 0.5..<1:
            addArrangedSubview(StarImageView(isEmpty: true))
        case 1..<1.5:
            addArrangedSubview(StarImageView(isEmpty: false))
        case 1.5..<2:
            addArrangedSubviews(StarImageView(isEmpty: false), StarImageView(isEmpty: true))
        case 2..<2.5:
            addArrangedSubviews(StarImageView(isEmpty: false), StarImageView(isEmpty: false))
        case 2.5..<3:
            addArrangedSubviews(
                StarImageView(isEmpty: false), StarImageView(isEmpty: false),
                StarImageView(isEmpty: true)
            )
        case 3..<3.5:
            addArrangedSubviews(
                StarImageView(isEmpty: false), StarImageView(isEmpty: false),
                StarImageView(isEmpty: false)
            )
        case 3.5..<4:
            addArrangedSubviews(
                StarImageView(isEmpty: false), StarImageView(isEmpty: false),
                StarImageView(isEmpty: false), StarImageView(isEmpty: true)
            )
        case 4..<4.5:
            addArrangedSubviews(
                StarImageView(isEmpty: false), StarImageView(isEmpty: false),
                StarImageView(isEmpty: false), StarImageView(isEmpty: false)
            )
        case 4.5...:
            addArrangedSubviews(
                StarImageView(isEmpty: false), StarImageView(isEmpty: false),
                StarImageView(isEmpty: false), StarImageView(isEmpty: false),
                StarImageView(isEmpty: false)
            )
        default:
            return
        }
    }
}
