//
//  LostItemCollectionViewCell.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/08/05.
//

import UIKit

final class LostItemCollectionViewCell: UICollectionViewCell {
    
    // MARK: UI Property
    
    private let wholeView: UIView = {
        let view = UIView()
        view.backgroundColor = .hexF5F6F8
        view.layer.cornerRadius = 10
        
        return view
    }()
    
    private let itemImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let itemTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .subTitle4
        label.textColor = .title
        return label
    }()
    
    private let getItemStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private let getItemLocationLabel: UILabel = {
        let label = UILabel()
        label.font = .body5
        label.textColor = .body1
        return label
    }()
    
    private let getItemDateLabel: UILabel = {
        let label = UILabel()
        label.font = .body5
        label.textColor = .body1
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
        configureSubviews()
        configureConstraints()
    }
    
    private func configureSubviews() {
        addSubview(wholeView)
        wholeView.addSubviews(itemImageView, itemTitleLabel, getItemStackView)
        getItemStackView.addArrangedSubviews(getItemLocationLabel, getItemDateLabel)
    }
    
    private func configureConstraints() {
        wholeView.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview().inset(9)
            $0.horizontalEdges.equalToSuperview().inset(6)
        }
        itemImageView.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview().inset(12)
            $0.height.equalTo(itemImageView.snp.width)
        }
        itemTitleLabel.snp.makeConstraints {
            $0.top.equalTo(itemImageView.snp.bottom).offset(14)
            $0.horizontalEdges.equalToSuperview().inset(12)
        }
        getItemStackView.snp.makeConstraints {
            $0.top.equalTo(itemTitleLabel.snp.bottom).offset(10)
            $0.horizontalEdges.bottom.equalToSuperview().inset(12)
        }
    }
    
    func drawUI(item: LostItemContent) {
        if let urlString = item.imageUrl, let url = URL(string: urlString) {
            itemImageView.kf.setImage(with: url)
            itemImageView.kf.indicatorType = .activity
        } else {
            itemImageView.image = nil
        }
        itemTitleLabel.text = item.title
//        dateLabel.text = item.date.convertToYearMonthDayString()
//        locationLabel.text = """
//                             습득 장소ㅣ\(item.getLocation)
//                             보관 장소ㅣ\(item.keepLocation)
//                             """
        getItemLocationLabel.text = """
                             습득 장소ㅣ\(item.facilityName)
                             """
        getItemDateLabel.text = "습득일자 | \(item.foundDate)"
    }
    
}
