//
//  MyWriteReviewCell.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/08/31.
//

import UIKit

final class MyWriteReviewCell: UITableViewCell {
    
    private let wholeView: UIView = {
        let view = UIView()
        view.backgroundColor = .hexF5F6F8
        view.layer.cornerRadius = 15
        view.clipsToBounds = true
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .body1
        label.font = .subTitle4
        return label
    }()
    
    private let gradeStackView = GradeStackView()
    
    private let commentLabel: UILabel = {
        let label = UILabel()
        label.textColor = .body1
        label.font = .body3
        return label
    }()
    
    private let createDateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .hex828996
        label.font = .body4
        return label
    }()
    
    private let moreButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: ImageNamespace.myWriteMoreButton), for: .normal)
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
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
        addSubview(wholeView)
        wholeView.addSubviews(titleLabel, commentLabel, gradeStackView, moreButton, createDateLabel)
    }
    
    private func configureConstraints() {
        wholeView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.bottom.equalToSuperview().inset(8)
            $0.horizontalEdges.equalToSuperview().inset(24)
        }
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.leading.equalToSuperview().offset(18)
        }
        gradeStackView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(18)
        }
        
        commentLabel.snp.makeConstraints {
            $0.top.equalTo(gradeStackView.snp.bottom).offset(6)
            $0.leading.equalToSuperview().offset(18)
        }
        createDateLabel.snp.makeConstraints {
            $0.top.equalTo(commentLabel.snp.bottom).offset(12)
            $0.leading.equalToSuperview().offset(18)
            $0.bottom.equalToSuperview().inset(12)
        }
        moreButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(17)
            $0.trailing.equalToSuperview().inset(12)
        }
    }
    
    func draw(item: MyWriteReviewContent) {
        titleLabel.text = item.showName
        gradeStackView.draw(grade: item.grade)
        commentLabel.text = item.content
        createDateLabel.text = item.createdAt.convertAPIDateToDateString() + "." + item.createdAt.convertAPIDateToDateTime()
    }
    
}

struct MyWriteReviewResponse: Decodable {
    let content: [MyWriteReviewContent]
}

struct MyWriteReviewContent: Decodable {
    let id: Int
    let showId: String
    let showName: String
    let grade: Int
    let content: String
    let createdAt: String
    let likeCount: Int
}
