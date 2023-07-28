//
//  StarImageView.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/07/28.
//

import UIKit

final class StarImageView: UIImageView {
    
    private let isEmpty: Bool
    
    init(isEmpty: Bool) {
        self.isEmpty = isEmpty
        super.init(frame: .zero)
        image = UIImage(
            named: isEmpty ? ImageNamespace.productStarEmptySymbol : ImageNamespace.productStarSymbol
        )
    }
    
    @available (*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
