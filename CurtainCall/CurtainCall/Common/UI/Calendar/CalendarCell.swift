//
//  CalendarCell.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/07/13.
//

import UIKit

import SnapKit

final class CalendarCell: UICollectionViewCell {
    
    // MARK: - UI properties
    
    private let dayLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textAlignment = .center
        return label
    }()
    
    private let circleView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 20
        return view
    }()
    
    // MARK: - Properties
    
    // MARK: - Lifecycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    @available (*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Helpers
    
    private func configureUI() {
        configureSubviews()
        configureConstraints()
    }
    
    private func configureSubviews() {
        addSubview(circleView)
        circleView.addSubview(dayLabel)
    }
    
    private func configureConstraints() {
        circleView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(40)
        }
        dayLabel.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func configureUI(_ item: CalendarView.Item) {
        if item.isSunday {
            dayLabel.textColor = .myRed
        } else if item.isSaturday {
            dayLabel.textColor = .myBlue
        } else {
            dayLabel.textColor = .hex2B313A
        }
        
        if let date = item.date {
            dayLabel.text = date.convertToDayString()
            dayLabel.alpha = item.isSelectable ? 1 : 0.5
            dayLabel.textColor = item.isSelected ? .white : dayLabel.textColor
            circleView.backgroundColor = item.isSelected ? .pointColor2 : .white
        } else {
            dayLabel.text = ""
        }
        
    }
    
}
