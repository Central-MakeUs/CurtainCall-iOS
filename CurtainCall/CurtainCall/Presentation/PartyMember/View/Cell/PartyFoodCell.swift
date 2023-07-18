//
//  PartyFoodCell.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/07/11.
//

import UIKit

import SnapKit

final class PartyFoodCell: UICollectionViewCell {
    
    // MARK: - UI properties
    
    private let cardView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.backgroundColor = .white
        return view
    }()
    
    private let productLabelView: UIView = {
        let view = UIView()
        view.backgroundColor = .pointColor2
        view.layer.cornerRadius = 4
        view.layer.maskedCorners = CACornerMask(
            arrayLiteral: .layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMaxXMaxYCorner
        )
        return view
    }()
    
    private let productTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .subTitle4
        return label
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
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .hexBEC2CA
        label.font = .body5
        return label
    }()
    
    private let countLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .body1
        return label
    }()
    
    private let contentLabel: UILabel = {
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
    
    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let dateBadgeView: UIView = {
        let view = UIView()
        view.backgroundColor = .hexE4E7EC
        view.layer.cornerRadius = 4
        return view
    }()
    
    private let dateBadgeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.textColor = .pointColor1
        return label
    }()
    
    private let timeBadgeView: UIView = {
        let view = UIView()
        view.backgroundColor = .hexE4E7EC
        view.layer.cornerRadius = 4
        return view
    }()
    
    private let timeBadgeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.textColor = .pointColor1
        return label
    }()
    
    private let locationBadgeView: UIView = {
        let view = UIView()
        view.backgroundColor = .hexE4E7EC
        view.layer.cornerRadius = 4
        return view
    }()
    
    private let locationBadgeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.textColor = .pointColor1
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
        addSubviews(cardView, productLabelView)
        cardView.addSubviews(
            profileImageView, nicknameDateStackView, countLabel, contentLabel, borderView,
            posterImageView, dateBadgeView, timeBadgeView, locationBadgeView, partyMemberStackView
        )
        productLabelView.addSubview(productTitleLabel)
        nicknameDateStackView.addArrangedSubviews(nicknameLabel, dateLabel)
        dateBadgeView.addSubview(dateBadgeLabel)
        timeBadgeView.addSubview(timeBadgeLabel)
        locationBadgeView.addSubview(locationBadgeLabel)
        partyMemberStackView.addArrangedSubviews(
            partyMemberImageView1, partyMemberImageView2, partyMemberImageView3,
            partyMemberImageView4, partyMemberImageView5
        )
    }
    
    private func configureConstraints() {
        cardView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.top.equalToSuperview().offset(12)
            $0.bottom.equalToSuperview()
        }
        productTitleLabel.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(12)
            $0.top.bottom.equalToSuperview().inset(4)
        }
        productLabelView.snp.makeConstraints {
            $0.leading.equalTo(cardView.snp.leading)
            $0.top.equalToSuperview()
        }
        profileImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(29)
            $0.leading.equalToSuperview().offset(20)
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
            $0.bottom.equalTo(posterImageView.snp.top).offset(-16)
        }
        posterImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.height.equalTo(92)
            $0.width.equalTo(69)
            $0.bottom.equalToSuperview().inset(20)
        }
        dateBadgeLabel.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(10)
            $0.verticalEdges.equalToSuperview().inset(4)
        }
        dateBadgeView.snp.makeConstraints {
            $0.top.equalTo(posterImageView.snp.top)
            $0.leading.equalTo(posterImageView.snp.trailing).offset(14)
        }
        timeBadgeLabel.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(10)
            $0.verticalEdges.equalToSuperview().inset(4)
        }
        timeBadgeView.snp.makeConstraints {
            $0.top.equalTo(dateBadgeView.snp.top)
            $0.leading.equalTo(dateBadgeView.snp.trailing).offset(8)
        }
        locationBadgeLabel.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(10)
            $0.verticalEdges.equalToSuperview().inset(4)
        }
        locationBadgeView.snp.makeConstraints {
            $0.top.equalTo(dateBadgeView.snp.bottom).offset(8)
            $0.leading.equalTo(dateBadgeView)
        }
        partyMemberStackView.snp.makeConstraints {
            $0.top.equalTo(locationBadgeView.snp.bottom).offset(12)
            $0.leading.equalTo(locationBadgeView)
        }
        [partyMemberImageView1, partyMemberImageView2, partyMemberImageView3,
         partyMemberImageView4, partyMemberImageView5].forEach {
            $0.snp.makeConstraints { make in
                make.size.equalTo(24)
            }
        }
    }
    
    func setUI(_ item: FoodPartyInfo) {
        productTitleLabel.text = item.productName
        profileImageView.image = item.profileImage
        nicknameLabel.text = item.nickname
        dateLabel.text = item.writeDate.convertToYearMonthDayHourMinString()
        countLabel.text = "\(item.minCount)/\(item.maxCount)"
        contentLabel.text = item.content
        posterImageView.image = item.posterImage
        dateBadgeLabel.text = item.productDate.convertToYearMonthDayWeekString()
        timeBadgeLabel.text = item.productDate.convertToHourMinString()
        locationBadgeLabel.text = item.location
        let partymemberImageViews = [
            partyMemberImageView1, partyMemberImageView2, partyMemberImageView3,
            partyMemberImageView4, partyMemberImageView5
        ]
        item.partyMemberImages.enumerated().forEach { index, image in
            partymemberImageViews[index].image = image
        }
    }
}
