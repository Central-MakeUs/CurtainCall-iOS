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
    
    func draw(grade: Int) {
        switch grade {
        case 1:
            addArrangedSubviews(
                StarImageView(isEmpty: false), StarImageView(isEmpty: true),
                StarImageView(isEmpty: true), StarImageView(isEmpty: true),
                StarImageView(isEmpty: true)
            )
        case 2:
            addArrangedSubviews(
                StarImageView(isEmpty: false), StarImageView(isEmpty: false),
                StarImageView(isEmpty: true), StarImageView(isEmpty: true),
                StarImageView(isEmpty: true)
            )
        case 3:
            addArrangedSubviews(
                StarImageView(isEmpty: false), StarImageView(isEmpty: false),
                StarImageView(isEmpty: false), StarImageView(isEmpty: true),
                StarImageView(isEmpty: true)
            )
        case 4:
            addArrangedSubviews(
                StarImageView(isEmpty: false), StarImageView(isEmpty: false),
                StarImageView(isEmpty: false), StarImageView(isEmpty: false),
                StarImageView(isEmpty: true)
            )
        case 5:
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
