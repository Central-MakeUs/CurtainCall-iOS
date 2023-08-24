//
//  MyPageRecruitmentCell.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/08/15.
//

import UIKit

final class MyPageRecruitmentCell: UICollectionViewCell {
    
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
    
    private let dateBadgeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: ImageNamespace.myPageDateSymbol)
        return imageView
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
    
    private let timeBadgeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: ImageNamespace.myPageTimeSymbol)
        return imageView
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
    
    private let locationBadgeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: ImageNamespace.myPageLocationSymbol)
        return imageView
    }()
    
    private let locationBadgeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.textColor = .pointColor1
        return label
    }()
    
    private let enterTalkButton: UIButton = {
        let button = UIButton()
        button.setTitle("TALK 입장", for: .normal)
        button.backgroundColor = .pointColor2
        button.layer.cornerRadius = 8
        button.titleLabel?.font = .body3
        return button
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
            profileImageView, nicknameDateStackView, countLabel, titleLabel, borderView,
            posterImageView, dateBadgeView, timeBadgeView, locationBadgeView, enterTalkButton
        )
        productLabelView.addSubview(productTitleLabel)
        nicknameDateStackView.addArrangedSubviews(nicknameLabel, dateLabel)
        dateBadgeView.addSubviews(dateBadgeImageView, dateBadgeLabel)
        timeBadgeView.addSubviews(timeBadgeImageView, timeBadgeLabel)
        locationBadgeView.addSubviews(locationBadgeImageView, locationBadgeLabel)
        
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
        titleLabel.snp.makeConstraints {
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
            $0.height.equalTo(85)
            $0.width.equalTo(64)
        }
        
        dateBadgeImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(6)
        }
        dateBadgeLabel.snp.makeConstraints {
            $0.leading.equalTo(dateBadgeImageView.snp.trailing).offset(6)
            $0.trailing.equalToSuperview().inset(6)
            $0.verticalEdges.equalToSuperview().inset(4)
        }
        dateBadgeView.snp.makeConstraints {
            $0.top.equalTo(posterImageView.snp.top)
            $0.leading.equalTo(posterImageView.snp.trailing).offset(14)
        }
        
        timeBadgeImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(6)
        }
        timeBadgeLabel.snp.makeConstraints {
            $0.leading.equalTo(timeBadgeImageView.snp.trailing).offset(6)
            $0.trailing.equalToSuperview().inset(6)
            $0.verticalEdges.equalToSuperview().inset(4)
        }
        timeBadgeView.snp.makeConstraints {
            $0.top.equalTo(dateBadgeView.snp.bottom).offset(8)
            $0.leading.equalTo(posterImageView.snp.trailing).offset(14)
        }
        
        locationBadgeImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(6)
        }
        
        locationBadgeLabel.snp.makeConstraints {
            $0.leading.equalTo(locationBadgeImageView.snp.trailing).offset(6)
            $0.trailing.equalToSuperview().inset(6)
            $0.verticalEdges.equalToSuperview().inset(4)
        }
        locationBadgeView.snp.makeConstraints {
            $0.top.equalTo(timeBadgeView.snp.bottom).offset(8)
            $0.leading.equalTo(posterImageView.snp.trailing).offset(14)
        }
        enterTalkButton.snp.makeConstraints {
            $0.top.equalTo(posterImageView.snp.bottom).offset(22)
            $0.horizontalEdges.bottom.equalToSuperview().inset(20)
            $0.height.equalTo(40)
        }
        
    }

    func setUI(_ item: MyRecruitmentContent) {
        productTitleLabel.text = item.showName
        if let urlString = item.creatorImageUrl, let url = URL(string: urlString) {
            profileImageView.kf.setImage(with: url)
        } else {
            profileImageView.image = UIImage(named: ImageNamespace.defaultProfile)
        }
        nicknameLabel.text = item.creatorNickname
//        dateLabel.text = item.writeDate.convertToYearMonthDayHourMinString()
        dateLabel.text = "createAt"
        countLabel.text = "\(item.curMemberNum)/\(item.maxMemberNum)"
        titleLabel.text = item.title
        if let url = URL(string: item.showPoster) {
            posterImageView.kf.setImage(with: url)
        } else {
            posterImageView.image = nil
        }
        dateBadgeLabel.text = "ShowAt Date"
        timeBadgeLabel.text = "ShowAt Time"
//        dateBadgeLabel.text = item.productDate.convertToYearMonthDayWeekString()
//        timeBadgeLabel.text = item.productDate.convertToHourMinString()
        locationBadgeLabel.text = item.facilityName
    }
}
