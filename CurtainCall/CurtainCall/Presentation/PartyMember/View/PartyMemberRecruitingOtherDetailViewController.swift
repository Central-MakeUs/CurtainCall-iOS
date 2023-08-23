//
//  PartyMemberRecruitingOtherDetailViewController.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/07/25.
//

import UIKit

final class PartyMemberRecruitingOtherDetailViewController: UIViewController {
    
    // MARK: - UI properties
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private let headerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 26
        return imageView
    }()
    
    private let profileLabelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 2
        return stackView
    }()
    
    private let nickNameLabel: UILabel = {
        let label = UILabel()
        label.font = .subTitle4
        label.textColor = .title
        return label
    }()
    
    private let writeDateLabel: UILabel = {
        let label = UILabel()
        label.font = .body5
        label.textColor = .hexBEC2CA
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .subTitle4
        label.textColor = .body1
        return label
    }()
    
    private let contentLabel: UILabel = {
        let label = UILabel()
        label.font = .body1
        label.textColor = .hex5A6271
        label.numberOfLines = 0
        return label
    }()
    
    private let detailView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private let detailLabel: UILabel = {
        let label = UILabel()
        label.font = .subTitle4
        label.textColor = .pointColor1
        label.text = "상세 정보"
        return label
    }()
    
    private let detailStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        return stackView
    }()
    
    private let detailStateView = UIView()
    private let detailStateSymbolImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: ImageNamespace.partymemberDetailCountStateSymbol)
        return imageView
    }()
    private let detailStateLabel: UILabel = {
        let label = UILabel()
        label.font = .body2
        label.text = "참여 상태"
        label.textColor = .hex5A6271
        return label
    }()
    private let detailCountLabel: UILabel = {
        let label = UILabel()
        label.font = .body2
        label.textColor = .body1
        return label
    }()
    
    private let grayBorderView: UIView = {
        let view = UIView()
        view.backgroundColor = .hexF5F6F8
        return view
    }()
    
    private let detailDateView = UIView()
    private let detailDateSymbolImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: ImageNamespace.partymemberDetailDateSymbol)
        return imageView
    }()
    private let detailDateLabel: UILabel = {
        let label = UILabel()
        label.font = .body2
        label.text = "날짜"
        label.textColor = .hex5A6271
        return label
    }()
    private let detailProductDateLabel: UILabel = {
        let label = UILabel()
        label.font = .body2
        label.textColor = .body1
        return label
    }()
    
    private let partyInButton: BottomNextButton = {
        let button = BottomNextButton()
        button.setTitle("참여하기", for: .normal)
        return button
    }()
    
    private let dotLineViews = DotLineView()
    
    // MARK: - Properties
    
    private let id: Int
    
    // MARK: - Lifecycles
    
    init(id: Int) {
        self.id = id
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        
    }
    
    // MARK: - Helpers
    
    private func configureUI() {
        configureSubviews()
        configureConstraints()
        configureNavigation()
    }
    
    private func configureSubviews() {
        view.backgroundColor = .white
        view.addSubviews(scrollView, partyInButton)
        scrollView.addSubviews(contentView)
        contentView.addSubviews(headerView, grayBorderView, detailView)
        headerView.addSubviews(profileImageView, profileLabelStackView, titleLabel, contentLabel)
        profileLabelStackView.addArrangedSubviews(nickNameLabel, writeDateLabel)
        detailView.addSubviews(detailLabel, detailStackView)
        detailStackView.addArrangedSubviews(
            detailDateView,
            detailStateView
        )
        detailStateView.addSubviews(
            detailStateSymbolImageView, detailStateLabel, detailCountLabel
        )
        detailDateView.addSubviews(
            detailDateSymbolImageView, detailDateLabel, detailProductDateLabel
        )
        partyInButton.setNextButton(isSelected: true)
    }
    
    private func configureConstraints() {
        scrollView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalTo(partyInButton.snp.top).inset(30)
        }
        partyInButton.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.height.equalTo(55)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(16)
        }
        contentView.snp.makeConstraints {
            $0.edges.equalTo(scrollView.contentLayoutGuide)
            $0.width.equalTo(scrollView.frameLayoutGuide.snp.width)
        }
        headerView.snp.makeConstraints { $0.top.leading.trailing.equalToSuperview() }
        profileImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(24)
            $0.top.equalToSuperview().offset(31)
            $0.size.equalTo(52)
        }
        profileLabelStackView.snp.makeConstraints {
            $0.centerY.equalTo(profileImageView)
            $0.leading.equalTo(profileImageView.snp.trailing).offset(16)
        }
        titleLabel.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.top.equalTo(profileImageView.snp.bottom).offset(30)
        }
        contentLabel.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.top.equalTo(titleLabel.snp.bottom).offset(14)
            $0.bottom.equalToSuperview().inset(38)
        }
        grayBorderView.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(10)
        }
        detailView.snp.makeConstraints {
            $0.top.equalTo(grayBorderView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        detailLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(30)
            $0.leading.equalToSuperview().offset(24)
        }
        detailStackView.snp.makeConstraints {
            $0.top.equalTo(detailLabel.snp.bottom).offset(12)
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.bottom.equalToSuperview().offset(-20)

        }
        
        detailStateView.snp.makeConstraints {
            $0.height.equalTo(48)
        }
        detailStateSymbolImageView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.size.equalTo(24)
        }
        detailStateLabel.snp.makeConstraints {
            $0.leading.equalTo(detailStateSymbolImageView.snp.trailing).offset(10)
            $0.centerY.equalToSuperview()
        }
        detailCountLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(121)
            $0.centerY.equalToSuperview()
        }
        detailDateView.snp.makeConstraints {
            $0.height.equalTo(48)
        }
        detailDateSymbolImageView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        detailDateLabel.snp.makeConstraints {
            $0.leading.equalTo(detailDateSymbolImageView.snp.trailing).offset(10)
            $0.centerY.equalToSuperview()
        }
        detailProductDateLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(121)
            $0.centerY.equalToSuperview()
        }
       
    }
    
    private func configureNavigation() {
        configureBackbarButton()
        title = "기타"
    }
    
//    private func draw() {
//        profileImageView.image = partyInfo.profileImage
//        nickNameLabel.text = partyInfo.nickname
//        titleLabel.text = partyInfo.title
//
//        writeDateLabel.text = partyInfo.writeDate.convertToYearMonthDayHourMinString()
//        contentLabel.text = partyInfo.content
//        detailCountLabel.text = "\(partyInfo.minCount)/\(partyInfo.maxCount)"
//        if let date = partyInfo.meetingDate {
//            detailProductDateLabel.text = date.convertToYearMonthDayWeekString()
//        } else {
//            detailProductDateLabel.text = "날짜 미정"
//        }
//
//    }
    
}

