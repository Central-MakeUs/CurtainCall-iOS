//
//  MyRecruitmentOtherCell.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/09/08.
//

import UIKit

final class MyRecruitmentOtherCell: UITableViewCell {
    
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
    
    private let otherLabel: UILabel = {
        let label = UILabel()
        label.text = "기타"
        label.textAlignment = .center
        label.backgroundColor = .hexF5F6F8
        label.font = .body5
        label.textColor = .hex5A6271
        label.clipsToBounds = true
        label.layer.cornerRadius = 4
        return label
    }()
    
    private let countLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SpoqaHanSansNeo-Bold", size: 14)
        label.textColor = .hexBEC2CA
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
            titleLabel, dateView, contentLabel, otherLabel, countLabel
        )
        dateView.addSubviews(dateIcon, dateLabel)
    }
    
    private func configureConstraints() {
        wholeView.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview().inset(7)
            $0.horizontalEdges.equalToSuperview().inset(24)
        }
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(15)
            $0.leading.equalToSuperview().offset(12)
            $0.trailing.equalToSuperview().offset(50)
        }
        contentLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(6)
            $0.horizontalEdges.equalToSuperview().inset(12)
        }
        
        otherLabel.snp.makeConstraints {
            $0.top.equalTo(contentLabel.snp.bottom).offset(18)
            $0.leading.equalToSuperview().offset(12)
            $0.height.equalTo(23)
            $0.width.equalTo(35)
        }
        dateView.snp.makeConstraints {
            $0.height.equalTo(23)
            $0.top.equalTo(contentLabel.snp.bottom).offset(18)
            $0.bottom.equalToSuperview().inset(15)
            $0.leading.equalTo(otherLabel.snp.trailing).offset(8)
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
        countLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(13)
            $0.trailing.equalToSuperview().inset(10)
        }
    }
    
    func draw(item: MyRecruitmentContent) {
        titleLabel.text = item.title
        contentLabel.text = item.content
        if let showAt = item.showAt {
            dateLabel.text = showAt.convertAPIDateToDateString()
        } else {
            dateLabel.text = "날짜 미정"
        }
        countLabel.text = "\(item.curMemberNum)/\(item.maxMemberNum)"
        
    }
}
