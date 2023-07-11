//
//  PartyOtherCell.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/07/11.
//

import UIKit

final class PartyOtherCell: UICollectionViewCell {
    
    // MARK: - UI properties
    
    private let cardView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.backgroundColor = .white
        return view
    }()
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 21
        return imageView
    }()
    
    private let nicknameDateStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 2
        return stackView
    }()
    
    private let nicknameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    private let writeDateLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(rgb: 0x99A1B2)
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    
    private let countLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 17, weight: .bold)
        return label
    }()
    
    private let contentLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 16)
        label.numberOfLines = 0
        return label
    }()
    
    private let borderView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(rgb: 0xF2F3F5)
        return view
    }()
    
    private let dateBadgeView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 4
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor(rgb: 0xF04E87).cgColor
        return view
    }()
    
    private let dateBadgeLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(rgb: 0xF04E87)
        label.text = "날짜"
        label.font = .systemFont(ofSize: 12, weight: .medium)
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = UIColor(rgb: 0x273041)
        return label
    }()
    
    // MARK: - Properties
    
    // MARK: - Lifecycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    @available (*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    // MARK: - Helpers
    
    private func configureUI() {
        configureSubviews()
        configureConstraints()
    }
    
    private func configureSubviews() {
        addSubviews(cardView)
        cardView.addSubviews(
            profileImageView, nicknameDateStackView,
            countLabel, contentLabel, borderView, dateBadgeView, dateLabel
        )
        nicknameDateStackView.addArrangedSubviews(nicknameLabel, writeDateLabel)
        dateBadgeView.addSubview(dateBadgeLabel)
    }
    
    private func configureConstraints() {
        cardView.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(24)
        }
        profileImageView.snp.makeConstraints {
            $0.top.leading.equalToSuperview().offset(20)
            $0.size.equalTo(42)
        }
        nicknameDateStackView.snp.makeConstraints {
            $0.leading.equalTo(profileImageView.snp.trailing).offset(10)
            $0.centerY.equalTo(profileImageView)
        }
        countLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(31)
            $0.trailing.equalToSuperview().offset(-20)
        }
        contentLabel.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.top.equalTo(profileImageView.snp.bottom).offset(16)
            $0.bottom.equalTo(borderView.snp.top).offset(-15)
            
        }
        borderView.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.bottom.equalTo(dateBadgeView.snp.top).offset(-12)
        }
        dateBadgeLabel.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(18)
            $0.verticalEdges.equalToSuperview().inset(4)
        }
        dateBadgeView.snp.makeConstraints {
            $0.leading.bottom.equalToSuperview().inset(20)
        }
        dateLabel.snp.makeConstraints {
            $0.centerY.equalTo(dateBadgeView)
            $0.leading.equalTo(dateBadgeView.snp.trailing).offset(10)
        }
    }
    
    func setUI(_ item: OtherPartyInfo) {
        profileImageView.image = item.profileImage
        nicknameLabel.text = item.nickname
        writeDateLabel.text = item.writeDate.convertToYearMonthDayHourMinString()
        countLabel.text = "\(item.minCount)/\(item.maxCount)"
        contentLabel.text = item.content
        if let meetinDate = item.meetingDate {
            dateLabel.text = meetinDate.convertToYearMonthDayHourMinString()
        } else {
            dateLabel.text = "미정"
        }
    }
    
}
