//
//  LiveTalkChatViewController.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/09/06.
//

import UIKit

final class LiveTalkChatViewController: UIViewController {
    
    // MARK: - UI properties
    
    private let topView: UIView = {
        let view = UIView()
        view.backgroundColor = .white.withAlphaComponent(0.05)
        return view
    }()
    
    private let backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: ImageNamespace.navigationBackButtonWhite), for: .normal)
        return button
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "드림하이 (82/100)"
        label.font = .subTitle3
        label.textColor = .white
        return label
    }()
    
    private let showDateLabel: UILabel = {
        let label = UILabel()
        label.text = "일시 | 2023.06.24 (수) 오후 7:30"
        label.font = .body3
        label.textColor = .white
        return label
    }()
    
    // MARK: - Properties
    
    // MARK: - Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        addTargets()
    }
    
    // MARK: - Helpers
    
    private func configureUI() {
        configureSubviews()
        configureConstraints()
    }
    
    private func configureSubviews() {
        view.backgroundColor = .pointColor1
        view.addSubviews(topView)
        topView.addSubviews(backButton, titleLabel, showDateLabel)
    }
    
    private func configureConstraints() {
        topView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(124)
        }
        backButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(51)
            $0.leading.equalToSuperview().offset(20)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(54)
            $0.leading.equalTo(backButton.snp.trailing).offset(16)
            $0.trailing.lessThanOrEqualToSuperview().offset(24)
        }
        showDateLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(7)
            $0.leading.equalTo(titleLabel)
            $0.trailing.lessThanOrEqualToSuperview().inset(24)
        }
    }
    
    private func addTargets() {
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
    }
    
    @objc
    private func backButtonTapped() {
        dismiss(animated: true)
    }
    
}
