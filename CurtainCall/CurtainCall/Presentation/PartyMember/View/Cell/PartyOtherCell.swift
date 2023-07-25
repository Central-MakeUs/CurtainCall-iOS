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
        label.font = .subTitle4
        label.textColor = .black
        return label
    }()
    
    private let writeDateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .hexE4E7EC
        label.font = .body5
        return label
    }()
    
    private let countLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .body1
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .body1
        label.numberOfLines = 0
        return label
    }()
    
    private let borderView: UIView = {
        let view = UIView()
        view.backgroundColor = .hexF2F3F5
        return view
    }()
    
    private let dateBadgeView: UIView = {
        let view = UIView()
        view.backgroundColor = .hexE4E7EC
        view.layer.cornerRadius = 4
        return view
    }()
    
    private let dateBadgeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .pointColor1
        label.font = .systemFont(ofSize: 12, weight: .medium)
        return label
    }()
    
    private let partyMemberStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = -4
        return stackView
    }()
    
    private let partyMemberImageView1: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 12
        return imageView
    }()
    
    private let partyMemberImageView2: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 12
        return imageView
    }()
    private let partyMemberImageView3: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 12
        return imageView
    }()
    private let partyMemberImageView4: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 12
        return imageView
    }()
    private let partyMemberImageView5: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 12
        return imageView
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
            profileImageView, nicknameDateStackView, countLabel,
            titleLabel, borderView, dateBadgeView, partyMemberStackView
        )
        nicknameDateStackView.addArrangedSubviews(nicknameLabel, writeDateLabel)
        partyMemberStackView.addArrangedSubviews(
            partyMemberImageView1, partyMemberImageView2, partyMemberImageView3,
            partyMemberImageView4, partyMemberImageView5
        )
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
        titleLabel.snp.makeConstraints {
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
            $0.horizontalEdges.equalToSuperview().inset(10)
            $0.verticalEdges.equalToSuperview().inset(4)
        }
        dateBadgeView.snp.makeConstraints {
            $0.leading.bottom.equalToSuperview().inset(20)
        }
        [partyMemberImageView1, partyMemberImageView2, partyMemberImageView3,
         partyMemberImageView4, partyMemberImageView5].forEach {
            $0.snp.makeConstraints { make in
                make.size.equalTo(24)
            }
        }
        partyMemberStackView.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(20)
            $0.centerY.equalTo(dateBadgeLabel)
        }
    }
    
    func setUI(_ item: OtherPartyInfo) {
        profileImageView.image = item.profileImage
        nicknameLabel.text = item.nickname
        writeDateLabel.text = item.writeDate.convertToYearMonthDayHourMinString()
        countLabel.text = "\(item.minCount)/\(item.maxCount)"
        titleLabel.text = item.title
        if let meetinDate = item.meetingDate {
            dateBadgeLabel.text = meetinDate.convertToYearMonthDayWeekString()
        } else {
            dateBadgeLabel.text = "날짜 미정"
        }
        let partymemberImageViews = [
            partyMemberImageView5, partyMemberImageView4, partyMemberImageView3,
            partyMemberImageView2, partyMemberImageView1
        ]
        item.partyMemberImages.enumerated().forEach { index, image in
            partymemberImageViews[index].image = image
        }
    }
    
}
