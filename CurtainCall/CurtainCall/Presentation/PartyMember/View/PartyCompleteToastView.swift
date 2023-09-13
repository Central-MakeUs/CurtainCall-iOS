//
//  PartyCompleteToastView.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/09/01.
//

import UIKit

final class PartyCompleteToastView: UIView {
    
    // MARK: UI Property
    
    private lazy var markImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: isSuccess ? ImageNamespace.toastSuccessParty : ImageNamespace.toastFailParty)
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = isSuccess ? "파티원 모집글이 게시되었어요" : "오류로 인해 게시글 업로드에 실패했어요"
        label.textColor = .white
        label.font = .body2
        return label
    }()
    
    // MARK: Property
    
    private let isSuccess: Bool
    
    // MARK: Life Cycle
    
    init(isSuccess: Bool) {
        self.isSuccess = isSuccess
        super.init(frame: .zero)
        configureUI()
        alpha = 0
        backgroundColor = UIColor(rgb: 0x525457)
        layer.cornerRadius = 12
        clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Configure
    
    private func configureUI() {
        configureSubviews()
        configureConstraints()
    }
    
    private func configureSubviews() {
        addSubviews(markImage, titleLabel)
    }
    
    private func configureConstraints() {
        markImage.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(16)
            $0.size.equalTo(28)
        }
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(markImage.snp.trailing).offset(12)
            $0.trailing.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
    }
}
