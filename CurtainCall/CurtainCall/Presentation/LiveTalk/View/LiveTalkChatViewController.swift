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
    
    private let bottomView = UIView()
    private let addButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: ImageNamespace.chatAddButton), for: .normal)
        return button
    }()
    
    private let chatView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        view.clipsToBounds = true
        return view
    }()
    
    private let chatTextView: UITextView = {
        let textView = UITextView()
        textView.text = "메시지 입력..."
        textView.textColor = .pointColor1
        textView.font = .body3
        textView.isScrollEnabled = false
        textView.textContainerInset = .zero
        return textView
    }()
    // MARK: - Properties
    
    // MARK: - Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        addTargets()
        hideKeyboardWhenTappedArround()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardUp), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDown), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // MARK: - Helpers
    
    private func configureUI() {
        configureSubviews()
        configureConstraints()
    }
    
    private func configureSubviews() {
        view.backgroundColor = .pointColor1
        view.addSubviews(topView, bottomView)
        topView.addSubviews(backButton, titleLabel, showDateLabel)
        bottomView.addSubviews(addButton, chatView)
        chatView.addSubview(chatTextView)
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
        bottomView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(40)
        }
        addButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(24)
        }
        chatView.snp.makeConstraints {
            $0.height.equalTo(40)
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(addButton.snp.trailing).offset(10)
            $0.trailing.equalToSuperview().inset(24)
        }
        chatTextView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.top.equalToSuperview().offset(10)
            $0.bottom.equalToSuperview().inset(10)
        }
    }
    
    private func addTargets() {
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
    }
    
    @objc
    private func backButtonTapped() {
        dismiss(animated: true)
    }
    
    @objc
    private func keyboardUp(notification: NSNotification) {
        if let keyboardFrame:NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            
            UIView.animate(
                withDuration: 0.3, animations: { [weak self] in
                    self?.view.transform = CGAffineTransform(translationX: 0, y: -keyboardRectangle.height)
                }
            )
        }
    }
    
    @objc
    private func keyboardDown() {
        self.view.transform = .identity
    }
}
