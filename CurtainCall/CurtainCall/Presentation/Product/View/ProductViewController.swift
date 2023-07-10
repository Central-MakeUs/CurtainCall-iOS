//
//  ProductViewController.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/07/07.
//

import UIKit

import SnapKit

final class ProductViewController: UIViewController {
    
    // MARK: - UI properties
    
    private let homeLabel: UILabel = {
        let label = UILabel()
        label.text = "작품"
        return label
    }()
    
    // MARK: - Properties
    
    // MARK: - Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Helpers
    
    private func configureUI() {
        configureSubviews()
        configureConstraints()
    }
    
    private func configureSubviews() {
        view.addSubview(homeLabel)
    }
    
    private func configureConstraints() {
        homeLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
}
