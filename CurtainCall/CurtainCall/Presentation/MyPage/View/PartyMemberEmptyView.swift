//
//  PartyMemberEmptyView.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/08/15.
//

import UIKit

final class PartyMemberEmptyView: UIView {
    private let wholeView = UIView()
    private let bangMarkImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: ImageNamespace.emptyBangMark)
        return imageView
    }()
    private let headLabel: UILabel = {
        let label = UILabel()
        label.text = "참여 중인 파티원이 없어요."
        label.font = .subTitle1
        label.textColor = .body1
        return label
    }()
    
    private let decriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "다양한 파티원 모집에 참여하여\n네트워킹을 즐겨보세요!"
        label.font = .body3
        label.textColor = .hex5A6271
        return label
    }()
    
    private let movePartymemberButton: UIButton = {
        let button = UIButton()
        button.setTitle("파티원으로 이동하기", for: .normal)
        button.setTitleColor(.hex5A6271, for: .normal)
        button.layer.cornerRadius = 20
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.hex5A6271?.cgColor
        button.titleLabel?.font = .body2
        return button
    }()
    
    init() {
        super.init(frame: .zero)
        configureUI()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        configureSubviews()
        configureConstraints()
    }
    private func configureSubviews() {
        addSubviews(bangMarkImageView, headLabel, decriptionLabel, movePartymemberButton)
    }
    private func configureConstraints() {
        bangMarkImageView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.centerX.equalToSuperview()
        }
        headLabel.snp.makeConstraints {
            $0.top.equalTo(bangMarkImageView.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
        }
        decriptionLabel.snp.makeConstraints {
            $0.top.equalTo(headLabel.snp.bottom).offset(22)
            $0.centerX.equalToSuperview()
        }
        movePartymemberButton.snp.makeConstraints {
            $0.top.equalTo(decriptionLabel.snp.bottom).offset(14)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(168)
            $0.height.equalTo(40)
            $0.bottom.equalToSuperview()
        }
    }
}
