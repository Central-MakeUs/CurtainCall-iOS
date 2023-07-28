//
//  DetailInfoView.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/07/28.
//

import UIKit

final class DetailInfoView: UIView {
    
    // MARK: UI Property
    
    private let timeTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "공연시간"
        label.font = .subTitle3
        label.textColor = .title
        return label
    }()
    
    private let reservationDotView: UIView = {
        let view = UIView()
        view.backgroundColor = .body1
        view.layer.cornerRadius = 3
        return view
    }()
    
    private let reservationLabel: UILabel = {
        let label = UILabel()
        label.text = "예매 가능 시간: 관람 2시간 전까지"
        label.textColor = .body1
        label.font = .body3
        return label
    }()
    
    private let duringDotView: UIView = {
        let view = UIView()
        view.backgroundColor = .body1
        view.layer.cornerRadius = 3
        return view
    }()
    
    private let duringLabel: UILabel = {
        let label = UILabel()
        label.text = """
        화, 수, 목, 금 | 19:30
        주말 | 15:00
        * 단, 6/6 화 | 15:00
        """
        label.numberOfLines = 0
        label.font = .body3
        label.textColor = .body1
        return label
    }()
    
    private let infoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 6
        return stackView
    }()
    
    private let locationTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "장소 정보"
        label.font = .subTitle3
        label.textColor = .title
        return label
    }()
    
    private let concertHallStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 20
        return stackView
    }()
    
    private let concertHallTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "공연장명"
        label.font = .body3
        label.textColor = .hex5A6271
        return label
    }()
    
    private let concertHallLabel: UILabel = {
        let label = UILabel()
        label.text = "LG 아트센터 서울"
        label.textAlignment = .left
        label.font = UIFont(name: "SpoqaHanSansNeo-Regular", size: 14)
        label.textColor = .body1
        return label
    }()
    
    private let addressStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 20
        return stackView
    }()
    
    private let addressTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "주소"
        label.font = .body3
        label.textColor = .hex5A6271
        return label
    }()
    
    private let addressLabel: UILabel = {
        let label = UILabel()
        label.text = "서울 강서구 마곡중앙로 136"
        label.textAlignment = .left
        label.font = UIFont(name: "SpoqaHanSansNeo-Regular", size: 14)
        label.textColor = .body1
        return label
    }()
    
    private let phoneStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 20
        return stackView
    }()
    
    private let phoneTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "전화번호"
        label.font = .body3
        label.textColor = .hex5A6271
        return label
    }()
    
    private let phoneLabel: UILabel = {
        let label = UILabel()
        label.text = "1661-0070"
        label.textAlignment = .left
        label.font = UIFont(name: "SpoqaHanSansNeo-Regular", size: 14)
        label.textColor = .body1
        return label
    }()
    
    private let websiteStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 20
        return stackView
    }()
    
    private let websiteTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "웹사이트"
        label.font = .body3
        label.textColor = .hex5A6271
        return label
    }()
    
    private let websiteLabel: UILabel = {
        let label = UILabel()
        label.text = "https://www.lgart.com/"
        label.font = UIFont(name: "SpoqaHanSansNeo-Regular", size: 14)
        label.textColor = .body1
        return label
    }()
    	
    // MARK: Property
    
    // MARK: Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    @available (*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Configure
    
    private func configureUI() {
        configureSubviews()
        configureConstraints()
    }
    
    private func configureSubviews() {
        backgroundColor = .brown
        addSubviews(
            timeTitleLabel, reservationDotView, reservationLabel, duringDotView, duringLabel,
            locationTitleLabel, infoStackView
        )
        infoStackView.addArrangedSubviews(
            concertHallStackView, addressStackView, phoneStackView, websiteStackView
        )
        concertHallStackView.addArrangedSubviews(concertHallTitleLabel, concertHallLabel)
        addressStackView.addArrangedSubviews(addressTitleLabel, addressLabel)
        phoneStackView.addArrangedSubviews(phoneTitleLabel, phoneLabel)
        websiteStackView.addArrangedSubviews(websiteTitleLabel, websiteLabel)
    }
    
    private func configureConstraints() {
        timeTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(30)
            $0.leading.equalToSuperview().offset(24)
        }
        reservationDotView.snp.makeConstraints {
            $0.top.equalTo(timeTitleLabel.snp.bottom).offset(24)
            $0.leading.equalToSuperview().offset(24)
            $0.size.equalTo(6)
        }
        reservationLabel.snp.makeConstraints {
            $0.centerY.equalTo(reservationDotView)
            $0.leading.equalTo(reservationDotView.snp.trailing).offset(10)
        }
        duringDotView.snp.makeConstraints {
            $0.top.equalTo(reservationDotView.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(24)
            $0.size.equalTo(6)
        }
        duringLabel.snp.makeConstraints {
            $0.top.equalTo(reservationLabel.snp.bottom).offset(4)
            $0.leading.equalTo(duringDotView.snp.trailing).offset(10)
        }
        locationTitleLabel.snp.makeConstraints {
            $0.top.equalTo(duringLabel.snp.bottom).offset(30)
            $0.leading.equalTo(24)
        }
        addressTitleLabel.snp.makeConstraints {
            $0.width.equalTo(52)
        }
        infoStackView.snp.makeConstraints {
            $0.top.equalTo(locationTitleLabel.snp.bottom).offset(10)
            $0.leading.equalTo(24)
            $0.bottom.equalToSuperview().offset(-10)
        }
        
    }
}
