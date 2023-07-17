//
//  UITableView + Extension.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/07/17.
//

import UIKit

extension UITableView {
    func dequeueCell<T: UITableViewCell>(type: T.Type, indexPath: IndexPath) -> T? {
        guard let cell = dequeueReusableCell(withIdentifier: T.identifier, for: indexPath) as? T else {
            return nil
        }
        return cell
    }
}
