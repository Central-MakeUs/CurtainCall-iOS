//
//  SameShowCell.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/09/08.
//

import UIKit

final class SameShowCell: UICollectionViewCell {
    
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
        imageView.contentMode = .scaleToFill
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
        wholeView.addSubviews(posterImage, titleLabel, bottomStackView)
        bottomStackView.addArrangedSubviews(starIcon, averageLabel, countLabel)
    }
    
    private func configureConstraints() {
        wholeView.snp.makeConstraints { $0.edges.equalToSuperview() }
        posterImage.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
            $0.height.equalTo(160)
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
    
    func drawCell(data: SameShowContent, index: Int) {
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
        countLabel.text = "(\(Int(data.reviewCount)))"
        
    }
    
}


