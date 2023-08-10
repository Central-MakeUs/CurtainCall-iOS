//
//  HomeBannerCell.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/08/06.
//

import UIKit

final class HomeBannerCell: UICollectionViewCell {
    
    // MARK: UI Property
    
    private let bannerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 12
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .pointColor1
        label.font = .heading2
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .pointColor1
        label.font = .body4
        label.numberOfLines = 2
        return label
    }()
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private let seeLabel: UILabel = {
        let label = UILabel()
        label.font = .body3
        label.textColor = .white
        label.backgroundColor = .pointColor1
        label.layer.cornerRadius = 12
        label.text = "보기"
        label.textAlignment = .center
        label.clipsToBounds = true
        return label
    }()
    // MARK: Property
    
    // MARK: Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Configure
    
    private func configureUI() {
        configureSubview()
        configureConstraints()
    }
    private func configureSubview() {
        addSubview(bannerView)
        bannerView.addSubviews(titleLabel, descriptionLabel, iconImageView, seeLabel)
    }
    
    private func configureConstraints() {
        bannerView.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(24)
        }
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.leading.equalToSuperview().offset(18)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(18)
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
        }
        seeLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(18)
            $0.bottom.equalToSuperview().inset(20)
            $0.height.equalTo(30)
            $0.width.equalTo(50)
        }
        iconImageView.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().inset(20)
        }
        
    }
    
    func drawCell(data: BannerData) {
        bannerView.backgroundColor = data.color
        titleLabel.text = data.title
        descriptionLabel.text = data.description
        iconImageView.image = data.icon
    }
    
}
