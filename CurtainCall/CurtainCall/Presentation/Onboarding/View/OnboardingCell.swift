//
//  OnboardingCell.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/07/05.
//

import UIKit

import SnapKit

final class OnboardingCell: UICollectionViewCell {
    
    // MARK: - UI properties
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 26, weight: .bold)
        label.textColor = .white
        label.text = "작품 탐색"
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.textColor = .white
        label.numberOfLines = 3
        label.text = "현재 상연 중인 연극 및\n뮤지컬에 관한 모든 정보를\n확인할 수 있어요."
        return label
    }()
    
    // MARK: - Properties
    
    // MARK: - Lifecycles

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    private func configureUI() {
        configureSubviews()
        configureConstraints()
    }
    
    private func configureSubviews() {
        [titleLabel, descriptionLabel].forEach { addSubview($0) }
    }
    
    private func configureConstraints() {
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(30)
            $0.leading.equalToSuperview().offset(24)
        }
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.top).offset(50)
            $0.leading.equalToSuperview().offset(24)
        }
    }
    
    func setupUI() {
        
    }
}
