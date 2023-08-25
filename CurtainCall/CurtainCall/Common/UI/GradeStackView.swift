//
//  GradeStackView.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/07/28.
//

import UIKit

final class GradeStackView: UIStackView {
    
    private let star1 = StarImageView()
    private let star2 = StarImageView()
    private let star3 = StarImageView()
    private let star4 = StarImageView()
    private let star5 = StarImageView()
    
    init() {
        super.init(frame: .zero)
        axis = .horizontal
        spacing = 0
        distribution = .fillEqually
        addArrangedSubviews(star1, star2, star3, star4, star5)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func draw(grade: Int) {
        switch grade {
        case 1:
            star1.setImage(isEmpty: false)
            star2.setImage(isEmpty: true)
            star3.setImage(isEmpty: true)
            star4.setImage(isEmpty: true)
            star5.setImage(isEmpty: true)
        case 2:
            star1.setImage(isEmpty: false)
            star2.setImage(isEmpty: false)
            star3.setImage(isEmpty: true)
            star4.setImage(isEmpty: true)
            star5.setImage(isEmpty: true)
        case 3:
            star1.setImage(isEmpty: false)
            star2.setImage(isEmpty: false)
            star3.setImage(isEmpty: false)
            star4.setImage(isEmpty: true)
            star5.setImage(isEmpty: true)
        case 4:
            star1.setImage(isEmpty: false)
            star2.setImage(isEmpty: false)
            star3.setImage(isEmpty: false)
            star4.setImage(isEmpty: false)
            star5.setImage(isEmpty: true)
        case 5:
            star1.setImage(isEmpty: false)
            star2.setImage(isEmpty: false)
            star3.setImage(isEmpty: false)
            star4.setImage(isEmpty: false)
            star5.setImage(isEmpty: false)
        default:
            return
        }
    }
}
