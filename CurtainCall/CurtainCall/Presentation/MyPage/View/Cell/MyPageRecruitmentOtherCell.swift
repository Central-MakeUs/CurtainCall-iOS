//
//  MyPageRecruitmentOtherCell.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/08/29.
//

import UIKit

final class MyPageRecruitmentOtherCell: UICollectionViewCell {
    
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
        label.textColor = .hexBEC2CA
        label.font = .body5
        return label
    }()
    
    private let countLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .body4
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
        view.backgroundColor = .hexF5F6F8
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
        label.textColor = .pointColor1
        label.font = .systemFont(ofSize: 12, weight: .medium)
        return label
    }()
    
    private let partyInButton: BottomNextButton = {
        let button = BottomNextButton()
        button.setTitle("TALK 입장", for: .normal)
        button.setNextButton(isSelected: true)
        button.titleLabel?.font = .body3
        return button
    }()
    
    // MARK: - Properties
    
    var id: Int?
    weak var delegate: MyPagePartyInDelegate?
    
    // MARK: - Lifecycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        partyInButton.addTarget(self, action: #selector(enterButtonTapped), for: .touchUpInside)
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
            titleLabel, dateBadgeView, partyInButton
        )
        nicknameDateStackView.addArrangedSubviews(nicknameLabel, writeDateLabel)
        
        dateBadgeView.addSubviews(dateBadgeImageView, dateBadgeLabel)
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
            $0.centerY.equalTo(dateBadgeView)
            $0.trailing.equalToSuperview().inset(20)
        }
        titleLabel.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.top.equalTo(profileImageView.snp.bottom).offset(16)
        }
        
        dateBadgeLabel.snp.makeConstraints {
            $0.leading.equalTo(dateBadgeImageView.snp.trailing).offset(6)
            $0.trailing.equalToSuperview().inset(6)
            $0.centerY.equalToSuperview()
        }
        dateBadgeImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(6)
        }
        
        dateBadgeView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(16)
            $0.leading.equalToSuperview().inset(20)
            $0.height.equalTo(24)
        }
        partyInButton.snp.makeConstraints {
            $0.top.equalTo(dateBadgeView.snp.bottom).offset(20)
            $0.height.equalTo(40)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().inset(19)
        }

    }
    
    func setUI(_ item: MyRecruitmentContent) {
        if let urlString = item.creatorImageUrl, let url = URL(string: urlString) {
            profileImageView.kf.setImage(with: url)
        } else {
            profileImageView.image = UIImage(named: ImageNamespace.defaultProfile)
        }
        id = item.id
        nicknameLabel.text = item.creatorNickname
        countLabel.text = "\(item.curMemberNum)/\(item.maxMemberNum)"
        titleLabel.text = item.title
        writeDateLabel.text = item.createdAt.convertAPIDateToDateString() + " " + item.createdAt.convertAPIDateToDateTime()
        dateBadgeLabel.text = item.showAt?.convertAPIDateToDateWeekString() ?? "날짜 미정"
    }
    
    @objc
    private func enterButtonTapped() {
        guard let id else { return }
        delegate?.didTappedPartyInButton(id: id)
    }
}
