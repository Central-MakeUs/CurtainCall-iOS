//
//  TimePickerView.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/08/06.
//

import UIKit

final class TimePickerView: UIView {
    
    private let topView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .hexF2F3F5
        return view
    }()
    
    private let checkButton: UIButton = {
        let button = UIButton()
        button.setTitle("확인", for: .normal)
        button.setTitleColor(.pointColor2, for: .normal)
        button.titleLabel?.font = .subTitle4
        return button
    }()
    
    private let timePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .time
        picker.locale = Locale.init(identifier: "en")
        picker.preferredDatePickerStyle = .wheels
        return picker
    }()
    
    weak var delegate: TimePickerViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        configureUI()
        checkButton.addTarget(
            self,
            action: #selector(checkButtonTouchUpInside),
            for: .touchUpInside
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        configureSubviews()
        configureConstraints()
    }
    
    private func configureSubviews() {
        addSubviews(topView, separatorView, timePicker)
        topView.addSubview(checkButton)
    }
    
    private func configureConstraints() {
        topView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(52)
        }
        separatorView.snp.makeConstraints {
            $0.top.equalTo(topView.snp.bottom)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(1)
        }
        checkButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(20)
            $0.centerY.equalToSuperview()
        }
        timePicker.snp.makeConstraints {
            $0.top.equalTo(separatorView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(216)
        }
    }
    
    @objc
    private func checkButtonTouchUpInside() {
        delegate?.didTappedCheckButton(time: timePicker.date)
    }
}

protocol TimePickerViewDelegate: AnyObject {
    func didTappedCheckButton(time: Date)
}
