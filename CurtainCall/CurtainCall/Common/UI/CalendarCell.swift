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
        label.font = .systemFont(ofSize: 16)
        label.textAlignment = .center
        return label
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
        addSubview(dayLabel)
    }
    
    private func configureConstraints() {
        dayLabel.snp.makeConstraints { $0.center.equalToSuperview() }
    }
    
    func configureUI(_ item: CalendarView.Item) {
        if item.isSunday {
            dayLabel.textColor = .red
        } else if item.isSaturday {
            dayLabel.textColor = .blue
        } else {
            dayLabel.textColor = .black
        }
        
        if let date = item.date {
            dayLabel.text = date.convertToDayString()
            
        } else {
            dayLabel.text = ""
        }
        
    }
    
}
