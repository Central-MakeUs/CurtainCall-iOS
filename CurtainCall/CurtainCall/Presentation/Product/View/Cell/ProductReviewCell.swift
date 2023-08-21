//
//  ProductReviewCell.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/07/28.
//

import UIKit

import Kingfisher

final class ProductReviewCell: UITableViewCell {
    
    // MARK: UI Property
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 21
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let gradeNameView = UIView()
    
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
    
    private let reportButton: UIButton = {
        let button = UIButton()
        button.setTitle("신고", for: .normal)
        button.setTitleColor(.hexBEC2CA, for: .normal)
        button.titleLabel?.font = .body4
        button.layer.cornerRadius = 12
        button.layer.borderColor = UIColor.hexBEC2CA?.cgColor
        button.layer.borderWidth = 1
        return button
    }()
    
    private let thumbupView: UIView = {
        let view = UIView()
        view.backgroundColor = .hexF2F3F5
        view.layer.cornerRadius = 6
        return view
    }()
    
    private let thumbupImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: ImageNamespace.thumbUpDeselectedSymbol)
        return imageView
    }()
    
    private let thumbupLabel: UILabel = {
        let label = UILabel()
        label.text = "37"
        label.textColor = UIColor(rgb: 0x99A1B2)
        label.font = UIFont(name: "SpoqaHanSansNeo-Medium", size: 11)
        return label
    }()
    private let thumbupButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    
    // MARK: Property
    
    private var isHeart: Bool = false
    
    // MARK: Life Cycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        configureUI()
        thumbupButton.addTarget(self, action: #selector(thumbupButtonTouchUpInside), for: .touchUpInside)
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
        addSubviews(profileImageView, gradeNameView, contentLabel, reportButton, thumbupView)
        gradeNameView.addSubviews(gradeStackView, nickNameDateLabel)
        thumbupView.addSubviews(thumbupImageView, thumbupLabel, thumbupButton)
    }
    
    private func configureConstraints() {
        profileImageView.snp.makeConstraints {
            $0.size.equalTo(42)
            $0.top.equalToSuperview().offset(20)
            $0.leading.equalToSuperview().offset(24)
        }
        gradeNameView.snp.makeConstraints {
            $0.centerY.equalTo(profileImageView)
            $0.leading.equalTo(profileImageView.snp.trailing).offset(10)
        }
        gradeStackView.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
            $0.width.equalTo(80)
        }
        
        nickNameDateLabel.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.top.equalTo(gradeStackView.snp.bottom).offset(4)
            $0.bottom.equalToSuperview()
        }
        
        reportButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(29)
            $0.trailing.equalToSuperview().offset(-24)
            $0.width.equalTo(40)
            $0.height.equalTo(24)
        }
        
        contentLabel.snp.makeConstraints {
            $0.top.equalTo(nickNameDateLabel.snp.bottom).offset(23)
            $0.horizontalEdges.equalToSuperview().inset(24)
        }
        
        thumbupView.snp.makeConstraints {
            $0.top.equalTo(contentLabel.snp.bottom).offset(14)
            $0.leading.equalToSuperview().offset(24)
            $0.height.equalTo(22)
            $0.bottom.equalToSuperview().inset(24)
        }
        thumbupButton.snp.makeConstraints { $0.edges.equalToSuperview() }
        thumbupImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(6)
            $0.centerY.equalToSuperview()
        }
        thumbupLabel.snp.makeConstraints {
            $0.leading.equalTo(thumbupImageView.snp.trailing).offset(4)
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-4)
        }
    }
    
    func draw(item: ShowReviewContent) {
        if let profileURLString = item.creatorImageUrl, let profileURL = URL(string: profileURLString) {
            profileImageView.kf.setImage(with: profileURL)
        } else {
            profileImageView.image = nil
        }
        gradeStackView.draw(grade: Int(item.grade))
        nickNameDateLabel.text = "\(item.creatorNickname)"
//        nickNameDateLabel.text = "\(item.nickName) | \(item.date.convertToYearMonthDayString())"
        contentLabel.text = item.content
    }
    
    @objc
    func thumbupButtonTouchUpInside() {
        isHeart.toggle()
        setupThumbUpButton()
    }
    
    func setupThumbUpButton() {
        thumbupView.backgroundColor = isHeart ? .pointColor2 : .hexF2F3F5
        thumbupImageView.image = isHeart ?
                                UIImage(named: ImageNamespace.thumbUpSelectedSymbol) :
                                UIImage(named: ImageNamespace.thumbUpDeselectedSymbol)
    }
    
}
