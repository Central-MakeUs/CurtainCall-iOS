//
//  LiveTalkCell.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/09/05.
//

import UIKit

final class LiveTalkCell: UICollectionViewCell {
    
    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.layer.cornerRadius = 15
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "dummy_poster")
        return imageView
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font =  UIFont(name: "SpoqaHanSansNeo-Bold", size: 13)
        label.text = "19:30~21:00"
        label.textColor = .white
        label.backgroundColor = .red
        label.layer.cornerRadius = 15
        label.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMaxYCorner]
        label.clipsToBounds = true
        return label
    }()
    
    private let enterCountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SpoqaHanSansNeo-Medium", size: 12)
        label.textColor = .white
        label.text = "82명"
        return label
    }()
    
    private let enterCountView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(rgb: 0x242424).withAlphaComponent(0.2)
        view.layer.cornerRadius = 10
        return view
    }()
    
    private let showLabel: UILabel = {
        let label = UILabel()
        label.text = "드림하이"
        label.font = UIFont(name: "SpoqaHanSansNeo-Bold", size: 16)
        label.textColor = .white
        return label
    }()
    
    private let locationLabel: UILabel = {
        let label = UILabel()
        label.text = "대학로 고라파센터"
        label.font = UIFont(name: "SpoqaHanSansNeo-Medium", size: 12)
        label.textColor = .white
        return label
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        configureSubviews()
        configureConstraints()
    }
    
    private func configureSubviews() {
        addSubviews(posterImageView, timeLabel, enterCountView, showLabel, locationLabel)
        enterCountView.addSubviews(enterCountLabel)
    }
    
    private func configureConstraints() {
        posterImageView.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.height.equalTo(220)
        }
        timeLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
            $0.width.equalTo(98)
            $0.height.equalTo(30)
        }
        enterCountView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(6)
            $0.trailing.equalToSuperview().inset(6)
            $0.height.equalTo(17)
        }
        enterCountLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(8)
        }
        showLabel.snp.makeConstraints {
            $0.top.equalTo(posterImageView.snp.bottom).offset(10)
            $0.leading.equalToSuperview()
        }
        locationLabel.snp.makeConstraints {
            $0.top.equalTo(showLabel.snp.bottom).offset(4)
            $0.leading.equalToSuperview()
            $0.bottom.equalToSuperview().inset(12)
        }
    }
}
