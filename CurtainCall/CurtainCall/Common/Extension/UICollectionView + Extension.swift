//
//  UICollectionView + Extension.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/07/05.
//

import UIKit

extension UICollectionView {
    func dequeueCell<T: UICollectionViewCell>(type: T.Type, indexPath: IndexPath) -> T? {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.identifier, for: indexPath) as? T else {
            return nil
        }
        return cell
    }
}
