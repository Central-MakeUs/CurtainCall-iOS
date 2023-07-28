//
//  DetailReviewView.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/07/28.
//

import UIKit

final class DetailReviewView: UIView {
    
    // MARK: UI Property
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "총 324개의 한 줄 리뷰"
        label.font = .subTitle3
        label.textColor = .title
        return label
    }()
    
    private let allViewButton: UIButton = {
        let button = UIButton()
        button.setTitle("모두 보기", for: .normal)
        button.setTitleColor(.pointColor2, for: .normal)
        button.layer.cornerRadius = 14
        button.layer.borderColor = UIColor.pointColor2?.cgColor
        button.layer.borderWidth = 1
        return button
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ReviewCell.self, forCellReuseIdentifier: ReviewCell.identifier)
        tableView.separatorStyle = .none
        return tableView
    }()
    
    // MARK: Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    @available (*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Configure
    
    private func configureUI() {
        configureSubviews()
        configureConstraints()
    }
    
    private func configureSubviews() {
        addSubviews(titleLabel, allViewButton, tableView)
    }
    
    private func configureConstraints() {
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(30)
            $0.leading.equalToSuperview().offset(24)
        }
        allViewButton.snp.makeConstraints {
            $0.centerY.equalTo(titleLabel)
            $0.trailing.equalToSuperview().inset(24)
        }
        tableView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(17)
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.height.equalTo(min(ReviewInfo.list.count, 3) * 112)
            $0.bottom.equalToSuperview()
        }
    }
}

extension DetailReviewView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return min(3, ReviewInfo.list.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: ReviewCell.identifier) as? ReviewCell else {
            return UITableViewCell()
        }
        cell.draw(item: ReviewInfo.list[indexPath.row])
        return cell
    }
}

extension DetailReviewView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 112
    }
}

final class ReviewCell: UITableViewCell {
    
    private let gradeStackView = GradeStackView()
    
    private let wholeView: UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor.hexE4E7EC?.cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 10
        return view
    }()
    
    private let nickNameDateLabel: UILabel = {
        let label = UILabel()
        label.font = .body4
        label.textColor = .hex5A6271
        return label
    }()
    
    private let reviewLabel: UILabel = {
        let label = UILabel()
        label.font = .body3
        label.textColor = .body1
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: .init(top: 0, left: 0, bottom: 12, right: 0))
    }
    
    
    func draw(item: ReviewInfo) {
        nickNameDateLabel.text = "\(item.nickName) | \(item.date.convertToYearMonthDayString())"
        reviewLabel.text = item.content
        gradeStackView.draw(grade: item.grade)
    }
    
    private func configureUI() {
        configureSubviews()
        configureConstarints()
    }
    
    private func configureSubviews() {
        addSubviews(wholeView)
        wholeView.addSubviews(gradeStackView, nickNameDateLabel, reviewLabel)
    }
    
    private func configureConstarints() {
        wholeView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.bottom.equalToSuperview().inset(6)
        }
        gradeStackView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(14)
            $0.leading.equalToSuperview().offset(12)
        }
        
        nickNameDateLabel.snp.makeConstraints {
            $0.top.equalTo(gradeStackView.snp.bottom).offset(6)
            $0.leading.equalToSuperview().offset(12)
        }
        reviewLabel.snp.makeConstraints {
            $0.top.equalTo(nickNameDateLabel.snp.bottom).offset(12)
            $0.leading.equalToSuperview().offset(12)
        }
    }
    
}
