//
//  UITextView + Extension.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/09/06.
//

import UIKit

extension UITextView {
    func numberOfLine() -> Int {
        let size = CGSize(width: frame.width, height: .infinity)
        let estimatedSize = sizeThatFits(size)
        
        return Int(estimatedSize.height / self.font!.lineHeight)
    }
}
