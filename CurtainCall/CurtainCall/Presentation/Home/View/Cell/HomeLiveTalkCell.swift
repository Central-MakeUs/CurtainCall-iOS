//
//  HomeLiveTalkCell.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/08/08.
//

import UIKit

final class HomeLiveTalkCell: UICollectionViewCell {
    
    // MARK: UI Property
    
    private let posterImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 7
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .title
        label.font = .body3
        return label
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .myRed
        label.textColor = .white
        label.font = .body5
        label.clipsToBounds = true
        label.layer.cornerRadius = 7
        label.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMaxYCorner]
        label.text = "19:30~"
        label.textAlignment = .center
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
        addSubviews(posterImage, titleLabel, timeLabel)
    }
    
    private func configureConstraints() {
        posterImage.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
        }
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(posterImage.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        timeLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
            $0.width.equalTo(51)
            $0.height.equalTo(24)
        }
    }
    
    func drawCell(data: LiveTalkData) {
        posterImage.image = data.posterImage
        titleLabel.text = data.title
    }
    
}
