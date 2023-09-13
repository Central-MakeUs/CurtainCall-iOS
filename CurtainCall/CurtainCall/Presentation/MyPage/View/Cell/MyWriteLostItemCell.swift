//
//  MyWriteLostItemCell.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/08/31.
//

import UIKit

final class MyWriteLostItemCell: UITableViewCell {
    
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
    
    private let createDateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .hex828996
        label.font = .body4
        return label
    }()
    
    private let getLocationLabel: UILabel = {
        let label = UILabel()
        label.font = .body3
        label.textColor = .hex5A6271
        return label
    }()
    
    private let getDateLabel: UILabel = {
        let label = UILabel()
        label.font = .body3
        label.textColor = .hex5A6271
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
        wholeView.addSubviews(titleLabel, getLocationLabel, getDateLabel, moreButton, createDateLabel)
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
        
        getLocationLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(18)
        }
        getDateLabel.snp.makeConstraints {
            $0.top.equalTo(getLocationLabel.snp.bottom).offset(4)
            $0.leading.equalToSuperview().offset(18)
        }
        
        createDateLabel.snp.makeConstraints {
            $0.top.equalTo(getDateLabel.snp.bottom).offset(12)
            $0.leading.equalToSuperview().offset(18)
            $0.bottom.equalToSuperview().inset(12)
        }
        moreButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(17)
            $0.trailing.equalToSuperview().inset(12)
        }
    }
    
    func draw(item: MyWriteLostItemContent) {
        titleLabel.text = item.title
        getLocationLabel.text = "습득 장소 | \(item.facilityName)"
        getDateLabel.text = "습득 일자 | \(item.foundDate)"
        createDateLabel.text = item.createdAt.convertAPIDateToDateString() + "." + item.createdAt.convertAPIDateToDateTime()
    }
    
}

struct MyWriteLostItemResponse: Decodable {
    let content: [MyWriteLostItemContent]
}

struct MyWriteLostItemContent: Decodable {
    let id: Int
    let facilityId: String
    let facilityName: String
    let title: String
    let type: String
    let foundDate: String
    let foundTime: String
    let imageUrl: String
    let createdAt: String
}
