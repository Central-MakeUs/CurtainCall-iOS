//
//  NicknameSettingViewController.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/07/06.
//

import UIKit

import SnapKit

final class NicknameSettingViewController: UIViewController {
    
    // MARK: - UI properties
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "커튼콜에서 사용할\n닉네임을 입력해주세요."
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 26, weight: .bold)
        label.textColor = UIColor(rgb: 0x111111)
        return label
    }()
    
    private let subTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "닉네임은 공백없이 15자리 이하로,\n특수문자를 포함해주세요."
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = UIColor(rgb: 0x91959D)
        return label
    }()
    
    private let nicknameView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(rgb: 0xF5F6F8)
        view.layer.cornerRadius = 10
        return view
    }()
    
    private let nicknameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "닉네임을 입력해주세요."
        textField.textColor = UIColor(rgb: 0x91959D)
        textField.font = .systemFont(ofSize: 18, weight: .medium)
        textField.borderStyle = .none
        return textField
    }()
    
    private let duplicateCheckButton: UIButton = {
        let button = UIButton()
        button.setTitle("중복 확인", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 13)
        button.setTitleColor(UIColor(rgb: 0x91959D), for: .normal)
        button.backgroundColor = UIColor(rgb: 0xE1E4E9)
        button.layer.cornerRadius = 8
        return button
    }()
    
    private let nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("다음", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        button.backgroundColor = UIColor(rgb: 0xE1E4E9)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 15
        button.isEnabled = false
        return button
    }()
    
    // MARK: - Properties
    
    // MARK: - Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        hideKeyboardWhenTappedArround()
    }
    
    // MARK: - Helpers
    
    private func configureUI() {
        view.backgroundColor = .white
        configureSubviews()
        configureConstraints()
    }
    
    private func configureSubviews() {
        view.addSubviews(
            titleLabel, subTitleLabel,nicknameView, duplicateCheckButton, nextButton
        )
        nicknameView.addSubview(nicknameTextField)
    }
    
    private func configureConstraints() {
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(32)
            $0.leading.equalToSuperview().offset(24)
        }
        
        subTitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(12)
            $0.leading.equalToSuperview().offset(24)
        }
        
        nicknameView.snp.makeConstraints {
            $0.top.equalTo(subTitleLabel.snp.bottom).offset(32)
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.height.equalTo(60)
        }
        
        nicknameTextField.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(20)
        }
        
        duplicateCheckButton.snp.makeConstraints {
            $0.top.equalTo(nicknameView.snp.bottom).offset(16)
            $0.trailing.equalToSuperview().offset(-24)
            $0.width.equalTo(90)
            $0.height.equalTo(32)
        }
        
        nextButton.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.height.equalTo(58)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-20)
        }
    }
    
    private func nextButtonCheck(_ isCheck: Bool) {
        nextButton.backgroundColor = UIColor(rgb: isCheck ? 0x273041 : 0xE1E4E9)
        nextButton.setTitleColor(
            UIColor(rgb: isCheck ? 0xFFFFFF : 0x91959D),
            for: .normal
        )
        nextButton.isEnabled = isCheck
    }
    
}
