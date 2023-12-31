//
//  NicknameSettingViewController.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/07/06.
//

import UIKit
import Combine

import SnapKit

final class NicknameSettingViewController: UIViewController {
    
    // MARK: - UI properties
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "커튼콜에서 사용할\n닉네임을 입력해주세요."
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 26, weight: .bold)
        label.textColor = .title
        return label
    }()
    
    private let subTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "닉네임은 공백없이 최소 2자에서 최대 10자 이하로,\n한글, 영문, 숫자를 자유롭게 조합해주세요."
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = UIColor(rgb: 0x91959D)
        return label
    }()
    
    private let nicknameView: UIView = {
        let view = UIView()
        view.backgroundColor = .hexF5F6F8
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.clear.cgColor
        return view
    }()
    
    private lazy var nicknameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "닉네임을 입력해주세요."
        textField.textColor = UIColor(rgb: 0x91959D)
        textField.font = .systemFont(ofSize: 18, weight: .medium)
        textField.borderStyle = .none
        textField.delegate = self
        textField.addTarget(self, action: #selector(nicknameTextFieldChanged), for: .editingChanged)
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
        button.setTitle("닉네임 설정 완료", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        button.backgroundColor = UIColor(rgb: 0xE1E4E9)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 15
        button.isEnabled = false
        return button
    }()
    
    private let validLabel: UILabel = {
        let label = UILabel()
        label.font = .body4
        label.numberOfLines = 0
        return label
    }()
    
    // MARK: - Properties
    
    private let NICKNAME_MAX_LENGTH: Int = 15
    private let viewModel: NicknameSettingViewModel
    private var cancellables = Set<AnyCancellable>()
    private var isValidNickname = false
    
    // MARK: - Lifecycles
    
    init(viewModel: NicknameSettingViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
    }
    
    @available (*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        bind()
        addTargets()
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
            titleLabel, subTitleLabel,nicknameView, duplicateCheckButton, nextButton, validLabel
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
            $0.leading.trailing.equalToSuperview().inset(20)
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
        
        validLabel.snp.makeConstraints {
            $0.top.equalTo(nicknameView.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(24)
            $0.trailing.equalToSuperview().inset(125)
        }
    }
    
    private func buttonValidCheck(_ isValid: Bool) {
        nextButton.backgroundColor = !isValid ? .hexE4E7EC : .pointColor2
        nextButton.setTitleColor(isValid ? .white : .hexBEC2CA, for: .normal)
        nextButton.isEnabled = isValid
        
    }
    
    private func bind() {
        viewModel.isValidRegexNickname
            .sink { completion in
                if case let .failure(error) = completion {
                    print(error.localizedDescription)
                    return
                }
            } receiveValue: { isValid in
                self.validLabel.text = isValid.message
                self.validLabel.textColor = isValid == .success ? UIColor(rgb: 0x00C271) : .myRed
                self.nicknameView.layer.borderColor = isValid == .success ? UIColor(rgb: 0x00C271).cgColor : UIColor.myRed?.cgColor
                self.buttonValidCheck(isValid == .success)
                self.isValidNickname = isValid == .success
                self.duplicateCheckButton.backgroundColor = isValid == .success ? .hexE4E7EC : .pointColor2
                self.duplicateCheckButton.setTitleColor(isValid != .success ? .white : .hexBEC2CA, for: .normal)
                self.duplicateCheckButton.isUserInteractionEnabled = isValid != .success
                self.nicknameTextField.isUserInteractionEnabled = isValid != .success
            }.store(in: &cancellables)
    }
    
    private func addTargets() {
        duplicateCheckButton.addTarget(
            self,
            action: #selector(duplicateButtonTouchUpInside),
            for: .touchUpInside
        )
        nextButton.addTarget(
            self,
            action: #selector(nextButtonTouchUpInside),
            for: .touchUpInside
        )
    }
    
    
    // MARK: - Actions
    
    @objc
    func duplicateButtonTouchUpInside() {
        viewModel.isValidNickname(nickname: nicknameTextField.text)
    }
    
    @objc
    func nextButtonTouchUpInside() {
        guard let nickname = nicknameTextField.text else { return }
        let viewModel = LoginCompleteViewModel()
        navigationController?.pushViewController(LoginCompleteViewController(viewModel: viewModel, nickname: nickname), animated: true)
    }
    
    @objc
    private func nicknameTextFieldChanged(_ sender: UITextField) {
        guard let text = sender.text, !isValidNickname else { return }
        
        duplicateCheckButton.backgroundColor = text.isEmpty ? .hexE4E7EC : .pointColor2
        duplicateCheckButton.setTitleColor(!text.isEmpty ? .white : .hexBEC2CA, for: .normal)
        duplicateCheckButton.isUserInteractionEnabled = !text.isEmpty
        
    }
    
}

extension NicknameSettingViewController: UITextFieldDelegate {
    func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String
    ) -> Bool {
        guard let text = textField.text else { return false }
        
        
        if let char = string.cString(using: String.Encoding.utf8) {
            let isBackSpace = strcmp(char, "\\b")
            if isBackSpace == -92 {
                return true
            }
        }
        guard text.count < NICKNAME_MAX_LENGTH else { return false }
        return true
    }
}
