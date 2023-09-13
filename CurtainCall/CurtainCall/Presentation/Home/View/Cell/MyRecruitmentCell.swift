//
//  MyRecruitmentCell.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/08/07.
//

import UIKit

final class MyRecruitmentCell: UITableViewCell {
    private let wholeView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.clipsToBounds = true
        view.layer.applySketchShadow(
            color: .black,
            alpha: 0.1,
            x: 0,
            y: 2,
            blur: 10,
            spread:0
        )
        view.layer.cornerRadius = 10
        return view
    }()
    
    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 4
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let showView: UIView = {
        let view = UIView()
        view.backgroundColor = .pointColor2
        view.layer.cornerRadius = 4
        return view
    }()
    
    private let showLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SpoqaHanSansNeo-Bold", size: 14)
        label.textColor = .white
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SpoqaHanSansNeo-Bold", size: 14)
        label.textColor = .body1
        return label
    }()
    
    private let contentLabel: UILabel = {
        let label = UILabel()
        label.font = .body3
        label.textColor = .hex5A6271
        return label
    }()
    
    private let countLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SpoqaHanSansNeo-Bold", size: 14)
        label.textColor = .hexBEC2CA
        return label
    }()
    
    private let categoryLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.backgroundColor = .hexF5F6F8
        label.font = .body5
        label.textColor = .hex5A6271
        label.clipsToBounds = true
        label.layer.cornerRadius = 4
        return label
    }()
    
    private let dateView: UIView = {
        let view = UIView()
        view.backgroundColor = .hexF5F6F8
        view.layer.cornerRadius = 4
        return view
    }()
    
    private let dateIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: ImageNamespace.homeOtherCellDateIcon)
        return imageView
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .hex5A6271
        label.font = .body5
        return label
    }()
    
    private let timeView: UIView = {
        let view = UIView()
        view.backgroundColor = .hexF5F6F8
        view.layer.cornerRadius = 4
        return view
    }()
    
    private let timeIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: ImageNamespace.homeOtherMyTimeIcon)
        return imageView
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .hex5A6271
        label.font = .body5
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    @available (*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configureUI() {
        configureSubviews()
        configureConstraints()
    }
    
    private func configureSubviews() {
        addSubviews(wholeView)
        wholeView.addSubviews(
            posterImageView, showView, titleLabel, contentLabel, countLabel,
            categoryLabel, dateView, timeView
        )
        showView.addSubview(showLabel)
        dateView.addSubviews(dateIcon, dateLabel)
        timeView.addSubviews(timeLabel, timeIcon)
    }
    
    private func configureConstraints() {
        wholeView.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview().inset(5)
            $0.horizontalEdges.equalToSuperview().inset(24)
        }
        posterImageView.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(12)
            $0.width.equalTo(58)
            $0.height.equalTo(76)
        }
        
        showView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(12)
            $0.leading.equalTo(posterImageView.snp.trailing).offset(12)
            $0.trailing.lessThanOrEqualToSuperview().inset(50)
            $0.height.equalTo(24)
        }
        
        showLabel.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(8)
            $0.verticalEdges.equalToSuperview().inset(3)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(showView.snp.bottom).offset(8)
            $0.leading.equalTo(posterImageView.snp.trailing).offset(12)
            $0.trailing.equalToSuperview().inset(12)
        }
        contentLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(4)
            $0.leading.equalTo(posterImageView.snp.trailing).offset(12)
            $0.trailing.equalToSuperview().inset(12)
        }
        categoryLabel.snp.makeConstraints {
            $0.top.equalTo(posterImageView.snp.bottom).offset(10)
            $0.leading.equalToSuperview().inset(12)
            $0.bottom.equalToSuperview().inset(12)
            $0.height.equalTo(23)
            $0.width.equalTo(59)
        }
        
        dateView.snp.makeConstraints {
            $0.height.equalTo(23)
            $0.top.equalTo(categoryLabel)
            $0.leading.equalTo(categoryLabel.snp.trailing).offset(8)
//            $0.bottom.equalToSuperview().inset(10)
        }
        timeView.snp.makeConstraints {
            $0.height.equalTo(23)
            $0.top.equalTo(categoryLabel)
            $0.leading.equalTo(dateView.snp.trailing).offset(8)
//            $0.bottom.equalToSuperview().inset(10)
        }
        dateIcon.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(6)
            $0.centerY.equalToSuperview()
        }
        dateLabel.snp.makeConstraints {
            $0.leading.equalTo(dateIcon.snp.trailing).offset(6)
            $0.trailing.equalToSuperview().inset(6)
            $0.centerY.equalToSuperview()
        }
        timeIcon.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(6)
            $0.centerY.equalToSuperview()
        }
        timeLabel.snp.makeConstraints {
            $0.leading.equalTo(timeIcon.snp.trailing).offset(6)
            $0.trailing.equalToSuperview().inset(6)
            $0.centerY.equalToSuperview()
        }
        countLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(13)
            $0.trailing.equalToSuperview().inset(12)
        }
    }
    
    func draw(item: MyRecruitmentContent) {
        if let url = URL(string: item.showPoster ?? "") {
            posterImageView.kf.setImage(with: url)
        } else {
            posterImageView.image = nil
        }
        showLabel.text = item.showName
        titleLabel.text = item.title
        contentLabel.text = item.content
        dateLabel.text = item.showAt?.convertAPIDateToDateWeekString()
        timeLabel.text = item.showAt?.convertAPIDateToDateTime()
        countLabel.text = "\(item.curMemberNum)/\(item.maxMemberNum)"
        categoryLabel.text = (PartyCategoryType(rawValue: item.category) ?? .watching).title
    }
}
