//
//  LogoutPopup.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/08/26.
//

import UIKit

protocol LogoutPopupDelegate: AnyObject {
    func logoutButtonTapped()
}

final class LogoutPopup: UIViewController {
    
    // MARK: - UI properties
    
    private let popupView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 15
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .subTitle2
        label.textColor = .title
        label.text = "정말 삭제하시겠습니까?"
        return label
    }()
    
    private let buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 12
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private let cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("아니요", for: .normal)
        button.backgroundColor = .hexE4E7EC
        button.setTitleColor(.hexBEC2CA, for: .normal)
        button.layer.cornerRadius = 10
        return button
    }()
    
    private let completeButton: UIButton = {
        let button = UIButton()
        button.setTitle("로그아웃", for: .normal)
        button.backgroundColor = .pointColor2
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        return button
    }()
    
    // MARK: - Properties
    
    weak var delegate: LogoutPopupDelegate?
    
    // MARK: - Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        view.backgroundColor = .black.withAlphaComponent(0.36)
        addTargets()
    }
    
    // MARK: - Helpers
    
    private func configureUI() {
        configureSubviews()
        configureConstraints()
    }
    
    private func configureSubviews() {
        view.addSubview(popupView)
        popupView.addSubviews(titleLabel, buttonStackView)
        buttonStackView.addArrangedSubviews(cancelButton, completeButton)
    }
    
    private func configureConstraints() {
        popupView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(24)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(38)
            $0.centerX.equalToSuperview()
        }

        buttonStackView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(34)
            $0.horizontalEdges.equalToSuperview().inset(18)
            $0.height.equalTo(46)
            $0.bottom.equalToSuperview().inset(20)
        }
    }
    
    private func addTargets() {
        cancelButton.addTarget(
            self,
            action: #selector(cancelButtonTouchUpInside),
            for: .touchUpInside
        )
        completeButton.addTarget(
            self,
            action: #selector(completeButtonTouchUpInside),
            for: .touchUpInside
        )
    }
    
    @objc
    func completeButtonTouchUpInside() {
        delegate?.logoutButtonTapped()
        dismiss(animated: false)
    }
    
    @objc
    func cancelButtonTouchUpInside() {
        dismiss(animated: false)
    }
    
}

