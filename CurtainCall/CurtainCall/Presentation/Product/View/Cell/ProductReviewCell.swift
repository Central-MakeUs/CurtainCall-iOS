//
//  ProductReviewCell.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/07/28.
//

import UIKit

final class ProductReviewCell: UITableViewCell {
    
    // MARK: UI Property
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 21
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let gradeStackView = GradeStackView()
    private let nickNameDateLabel: UILabel = {
        let label = UILabel()
        label.font = .body4
        label.textColor = .body1
        return label
    }()
    
    private let contentLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .body1
        label.textColor = .body1
        return label
    }()
    
    private let thumbupButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: ImageNamespace.thumb_up_deselected_symbol), for: .normal)
        button.setTitle("0", for: .normal)
        button.backgroundColor = UIColor(rgb: 0xF9F9FA)
        return button
    }()
    
    
    // MARK: Property
    
    // MARK: Life Cycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
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
        addSubviews(profileImageView, gradeStackView, nickNameDateLabel, contentLabel)
    }
    
    private func configureConstraints() {
        profileImageView.snp.makeConstraints {
            $0.size.equalTo(42)
            $0.top.equalToSuperview().offset(20)
            $0.leading.equalToSuperview().offset(24)
        }
        gradeStackView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(25)
            $0.leading.equalTo(profileImageView.snp.trailing).offset(10)
        }
        nickNameDateLabel.snp.makeConstraints {
            $0.top.equalTo(gradeStackView.snp.bottom).offset(4)
            $0.leading.equalTo(profileImageView.snp.trailing).offset(10)
        }
        contentLabel.snp.makeConstraints {
            $0.top.equalTo(nickNameDateLabel.snp.bottom).offset(23)
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.bottom.equalToSuperview().inset(20)
        }
    }
    
    func draw(item: ReviewInfo) {
        profileImageView.image = UIImage(named: "dummy_profile")
        gradeStackView.draw(grade: item.grade)
        nickNameDateLabel.text = "\(item.nickName)|\(item.date.convertToYearMonthDayString())"
        contentLabel.text = item.content
    }
    
}
