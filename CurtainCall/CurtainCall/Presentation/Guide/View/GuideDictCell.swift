//
//  GuideDictCell.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/08/12.
//

import UIKit

final class GuideDictCell: UITableViewCell {
    private let wholeView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    private let numberLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .pointColor2
        label.textColor = .white
        label.font = UIFont(name: "SpoqaHanSansNeo-Bold", size: 14)
        label.textAlignment = .center
        label.layer.cornerRadius = 12.5
        label.clipsToBounds = true
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .title
        label.font = .subTitle4
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .hex5A6271
        label.font = UIFont(name: "SpoqaHanSansNeo-Regular", size: 14)
        label.numberOfLines = 0
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
        wholeView.addSubviews(numberLabel, titleLabel, descriptionLabel)
    }
    
    private func configureConstraints() {
        wholeView.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(24)
        }
        numberLabel.snp.makeConstraints {
            $0.size.equalTo(25)
            $0.top.equalToSuperview().offset(20)
            $0.left.equalToSuperview()
        }
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(23)
            $0.left.equalTo(numberLabel.snp.right).offset(12)
        }
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.left.equalTo(titleLabel)
            $0.right.equalToSuperview()
            $0.bottom.equalToSuperview().inset(20)
        }
    }
    
    func draw(data: PerformanceExpressionDictionaryData) {
        titleLabel.text = data.title
        descriptionLabel.text = data.description
    }
    
    func drawNumber(index: Int) {
        numberLabel.text = "\(index)"
    }
}

