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
        view.backgroundColor = .hexF5F6F8
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
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .body3
        label.textColor = .body1
        return label
    }()
    
    private let contentLabel: UILabel = {
        let label = UILabel()
        label.font = .body3
        label.textColor = .body1
        return label
    }()
    
    private let countLabel: UILabel = {
        let label = UILabel()
        label.font = .body5
        label.textColor = .hex828996
        return label
    }()
    
    private let dateView: UIView = {
        let view = UIView()
        view.backgroundColor = .pointColor2
        view.layer.cornerRadius = 4
        return view
    }()
    
    private let dateIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: ImageNamespace.homeMyDateIcon)
        return imageView
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .body5
        return label
    }()
    
    private let timeView: UIView = {
        let view = UIView()
        view.backgroundColor = .pointColor2
        view.layer.cornerRadius = 4
        return view
    }()
    
    private let timeIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: ImageNamespace.homeMyTimeIcon)
        return imageView
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
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
            posterImageView, titleLabel, contentLabel, countLabel,
            dateView, timeView
        )
        dateView.addSubviews(dateIcon, dateLabel)
        timeView.addSubviews(timeLabel, timeIcon)
    }
    
    private func configureConstraints() {
        wholeView.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview().inset(7)
            $0.horizontalEdges.equalToSuperview().inset(24)
        }
        posterImageView.snp.makeConstraints {
            $0.top.leading.bottom.equalToSuperview().inset(10)
            $0.width.equalTo(58)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.leading.equalTo(posterImageView.snp.trailing).offset(12)
            $0.trailing.equalToSuperview().inset(55)
        }
        contentLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(4)
            $0.leading.equalTo(posterImageView.snp.trailing).offset(12)
            $0.trailing.equalToSuperview().inset(55)
        }
        dateView.snp.makeConstraints {
            $0.height.equalTo(23)
            $0.top.equalTo(contentLabel.snp.bottom).offset(14)
            $0.leading.equalTo(posterImageView.snp.trailing).offset(12)
            $0.bottom.equalToSuperview().inset(10)
        }
        timeView.snp.makeConstraints {
            $0.height.equalTo(23)
            $0.top.equalTo(contentLabel.snp.bottom).offset(14)
            $0.leading.equalTo(dateView.snp.trailing).offset(6)
            $0.bottom.equalToSuperview().inset(10)
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
            $0.trailing.equalToSuperview().inset(10)
        }
    }
    
    func draw(item: MyRecruitmentContent) {
        if let url = URL(string: item.showPoster ?? "") {
            posterImageView.kf.setImage(with: url)
        } else {
            posterImageView.image = nil
        }
        if let showName = item.showName {
            titleLabel.text = "[\(showName)]"
        } else {
            titleLabel.text = nil
        }
        contentLabel.text = item.title
        dateLabel.text = item.showAt?.convertAPIDateToDateString()
        timeLabel.text = item.showAt?.convertAPIDateToDateTime()
        countLabel.text = "\(item.curMemberNum)/\(item.maxMemberNum)"
    }
}
