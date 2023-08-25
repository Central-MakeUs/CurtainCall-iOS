//
//  ScheduledToOpenProductCell.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/08/09.
//

import UIKit

final class ScheduledToOpenProductCell: UICollectionViewCell {
    
    // MARK: UI Property
    
    private let wholeView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        view.layer.applySketchShadow(
            color: .black,
            alpha: 0.1,
            x: 0,
            y: 2,
            blur: 10,
            spread: 0
        )
        
        return view
    }()
    
    private let posterImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .title
        label.font = .body2
        return label
    }()
    
    private let bottomStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 2
        return stackView
    }()
    
    private let starIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: ImageNamespace.productStarSymbol)
        return imageView
    }()
    
    private let averageLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SpoqaHanSansNeo-Bold", size: 13)
        label.textColor = .pointColor1
        return label
    }()
    
    private let countLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SpoqaHanSansNeo-Bold", size: 13)
        label.textColor = UIColor(rgb: 0x99A1B2)
        return label
    }()
    
    private let dayLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor(rgb: 0x242424).withAlphaComponent(0.7)
        label.textAlignment = .center
        label.textColor = .white
        label.font = .subTitle2
        label.layer.cornerRadius = 10
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
        addSubview(wholeView)
        wholeView.addSubviews(posterImage, dayLabel, titleLabel, bottomStackView)
        bottomStackView.addArrangedSubviews(starIcon, averageLabel, countLabel)
    }
    
    private func configureConstraints() {
        wholeView.snp.makeConstraints { $0.edges.equalToSuperview() }
        posterImage.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
            $0.height.equalTo(160)
        }
        dayLabel.snp.makeConstraints {
            $0.top.left.equalToSuperview()
            $0.height.equalTo(36)
            $0.width.equalTo(53)
        }
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(posterImage.snp.bottom).offset(10)
            $0.horizontalEdges.equalToSuperview().inset(12)
        }
        bottomStackView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(12)
            $0.top.equalTo(titleLabel.snp.bottom).offset(3)
            $0.bottom.equalToSuperview().inset(12)
        }
        
    }
    
    func drawCell(data: OpenShowContent) {
        if let url = URL(string: data.poster) {
            posterImage.kf.setImage(with: url)
            posterImage.kf.indicatorType = .activity
        } else {
            posterImage.image = nil
        }
        titleLabel.text = data.name
        if data.reviewCount == 0 && data.reviewGradeSum == 0 {
            averageLabel.text = "0"
        } else {
            averageLabel.text = String(format: "%.1f", data.reviewGradeSum / data.reviewCount)
        }
        
        dayLabel.text = "D-\(dateDiff(startDateString: data.startDate) ?? 0)"
        countLabel.text = "(\(Int(data.reviewCount)))"
        
    }
    
    private func dateDiff(startDateString: String) -> Int? {
        guard let startDate = startDateString.convertYearMonthDayDashStringToDate() else {
            return nil
        }
        let diff = Calendar.current.dateComponents([.day], from: Date(), to: startDate)
        return diff.day
    }
    
}


