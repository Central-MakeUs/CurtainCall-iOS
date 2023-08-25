//
//  StarImageView.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/07/28.
//

import UIKit

final class StarImageView: UIImageView {
    
    func setImage(isEmpty: Bool) {
        image = UIImage(
            named: isEmpty ? ImageNamespace.productStarEmptySymbol : ImageNamespace.productStarSymbol
        )
    }
}
