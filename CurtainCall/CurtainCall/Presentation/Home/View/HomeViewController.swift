//
//  HomeViewController.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/07/07.
//

import UIKit
import Combine

import SnapKit

final class HomeViewController: UIViewController {
    
    // MARK: - UI properties
    
    private let homeLabel: UILabel = {
        let label = UILabel()
        label.text = "홈"
        return label
    }()
    
    // MARK: - Properties
    
    var c = Set<AnyCancellable>()
    
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
