//
//  RemoveAccountViewController.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/08/23.
//

import UIKit

import Combine
import SwiftKeychainWrapper

final class RemoveAccountViewController: UIViewController {
    
    // MARK: - UI properties
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        return stackView
    }()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "커튼콜을 떠나시나요?"
        label.font = .heading2
        label.textColor = .heading
        return label
    }()
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "계정을 삭제하는 이유를 알려주세요."
        label.font = .body3
        label.textColor = .hex828996
        return label
    }()
    
    private let deleteView = UIView()
    private let deleteCheckMarkButton: CheckMarkButton = {
        let button = CheckMarkButton()
        button.tag = 0
        return button
    }()
    private let deleteLabel: UILabel = {
        let label = UILabel()
        label.text = "기록을 삭제하기 위해"
        label.font = .body1
        label.textColor = .hex5A6271
        return label
    }()
    private let deleteButton: UIButton = {
        let button = UIButton()
        button.tag = 0
        return button
    }()
    
    private let bugView = UIView()
    private let bugCheckMarkButton: CheckMarkButton = {
        let button = CheckMarkButton()
        button.tag = 1
        return button
    }()
    private let bugLabel: UILabel = {
        let label = UILabel()
        label.text = "이용이 불편하고 장애가 잦아서"
        label.font = .body1
        label.textColor = .hex5A6271
        return label
    }()
    private let bugButton: UIButton = {
        let button = UIButton()
        button.tag = 1
        return button
    }()
    
    private let betterOtherServiceView = UIView()
    private let betterOtherServiceCheckMarkButton: CheckMarkButton = {
        let button = CheckMarkButton()
        button.tag = 2
        return button
    }()
    private let betterOtherServiceLabel: UILabel = {
        let label = UILabel()
        label.text = "타 서비스가 더 좋아서"
        label.font = .body1
        label.textColor = .hex5A6271
        return label
    }()
    private let betterOtherServiceButton: UIButton = {
        let button = UIButton()
        button.tag = 2
        return button
    }()
    
    private let lowFrequencyView = UIView()
    private let lowFrequencyCheckMarkButton: CheckMarkButton = {
        let button = CheckMarkButton()
        button.tag = 3
        return button
    }()
    private let lowFrequencyLabel: UILabel = {
        let label = UILabel()
        label.text = "사용빈도가 낮아서"
        label.font = .body1
        label.textColor = .hex5A6271
        return label
    }()
    private let lowFrequencyButton: UIButton = {
        let button = UIButton()
        button.tag = 3
        return button
    }()
    
    private let notUtilityView = UIView()
    private let notUtilityCheckMarkButton: CheckMarkButton = {
        let button = CheckMarkButton()
        button.tag = 4
        return button
    }()
    private let notUtilityLabel: UILabel = {
        let label = UILabel()
        label.text = "앱 기능이 유용하지 않아서"
        label.font = .body1
        label.textColor = .hex5A6271
        return label
    }()
    private let notUtilityButton: UIButton = {
        let button = UIButton()
        button.tag = 4
        return button
    }()
    
    private let etcView = UIView()
    private let etcCheckMarkButton: CheckMarkButton = {
        let button = CheckMarkButton()
        button.tag = 5
        return button
    }()
    private let etcLabel: UILabel = {
        let label = UILabel()
        label.text = "기타"
        label.font = .body1
        label.textColor = .hex5A6271
        return label
    }()
    private let etcButton: UIButton = {
        let button = UIButton()
        button.tag = 5
        return button
    }()
    private let etcTextView: UITextView = {
        let textView = UITextView()
        textView.font = .body2
        textView.textColor = .body1
        textView.isScrollEnabled = false
        textView.textContainerInset = .init(top: 12, left: 18, bottom: 12, right: 18)
        textView.textContainer.lineFragmentPadding = 0
        textView.isHidden = true
        textView.backgroundColor = .hexF5F6F8
        textView.layer.cornerRadius = 10
        return textView
    }()
    private let textLimitLabel: UILabel = {
        let label = UILabel()
        label.text = "글자수 제한 (0/500)"
        label.font = .body5
        label.textColor = .hex828996
        label.isHidden = true
        return label
    }()
    
    private let nextButton: BottomNextButton = {
        let button = BottomNextButton()
        button.setTitle("다음", for: .normal)
        button.setNextButton(isSelected: false)
        return button
    }()
    
    private let emptyView = UIView()
    
    // MARK: - Properties
    
    private let viewModel: RemoveAccountViewModel
    private var subscriptions: Set<AnyCancellable> = []
    
    // MARK: - Lifecycles
    
    init(viewModel: RemoveAccountViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardUp), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDown), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // MARK: - Helpers
    
    private func configureUI() {
        configureSubviews()
        configureConstraints()
        configureNavigation()
    }
    
    private func configureSubviews() {
        view.backgroundColor = .white
        contentView.backgroundColor = .white
        view.addSubviews(scrollView, nextButton)
        scrollView.addSubview(contentView)
        contentView.addSubviews(stackView, titleLabel, subtitleLabel, etcTextView, textLimitLabel)
        stackView.addArrangedSubviews(deleteView, bugView, betterOtherServiceView, lowFrequencyView, notUtilityView, etcView)
        deleteView.addSubviews(deleteLabel, deleteCheckMarkButton, deleteButton)
        bugView.addSubviews(bugLabel, bugCheckMarkButton, bugButton)
        betterOtherServiceView.addSubviews(betterOtherServiceLabel, betterOtherServiceCheckMarkButton, betterOtherServiceButton)
        lowFrequencyView.addSubviews(lowFrequencyLabel, lowFrequencyCheckMarkButton, lowFrequencyButton)
        notUtilityView.addSubviews(notUtilityLabel, notUtilityCheckMarkButton, notUtilityButton)
        etcView.addSubviews(etcLabel, etcCheckMarkButton, etcButton)
    }
    
    private func configureConstraints() {
        nextButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(16)
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.height.equalTo(55)
        }
        scrollView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
        contentView.snp.makeConstraints {
            $0.edges.equalTo(scrollView.contentLayoutGuide)
            $0.width.equalTo(scrollView.frameLayoutGuide)
        }
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(50)
            $0.leading.equalToSuperview().offset(24)
        }
        subtitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(24)
        }
        stackView.snp.makeConstraints {
            $0.top.equalTo(subtitleLabel.snp.bottom).offset(40)
            $0.horizontalEdges.equalToSuperview()
        }
        deleteView.snp.makeConstraints {
            $0.height.equalTo(42)
            $0.width.equalToSuperview()
        }
        [deleteCheckMarkButton, bugCheckMarkButton, betterOtherServiceCheckMarkButton,
         lowFrequencyCheckMarkButton, notUtilityCheckMarkButton, etcCheckMarkButton
        ].forEach {
            $0.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.leading.equalToSuperview().offset(24)
            }
        }
        
        [deleteLabel, bugLabel, betterOtherServiceLabel,
         lowFrequencyLabel, notUtilityLabel, etcLabel
        ].forEach {
            $0.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.leading.equalToSuperview().offset(54)
            }
        }
        [deleteButton, bugButton, betterOtherServiceButton,
         lowFrequencyButton, notUtilityButton, etcButton
        ].forEach { $0.snp.makeConstraints { make in make.edges.equalToSuperview() } }
        etcTextView.snp.makeConstraints {
            $0.top.equalTo(stackView.snp.bottom).offset(4)
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.height.greaterThanOrEqualTo(145)
        }
        textLimitLabel.snp.makeConstraints {
            $0.top.equalTo(etcTextView.snp.bottom).offset(8)
            $0.trailing.equalToSuperview().inset(24)
            $0.bottom.equalToSuperview().inset(10)
        }
    }
    
    private func configureNavigation() {
        configureBackbarButton()
        title = "계정 삭제"
    }
    
    private func bind() {
        viewModel.isSuccessRemoveAccount
            .sink { [weak self] isSuccess in
                if isSuccess {
                    KeychainWrapper.standard.removeAllKeys()
                    self?.changeRootViewController(RemoveAccountCompleteViewController())
                } else {
                    self?.presentAlert(title: "네트워크 오류로 실패하였습니다.")
                }
            }.store(in: &subscriptions)
    }
    
    private func addTargets() {
        [deleteButton, bugButton, betterOtherServiceButton,
         lowFrequencyButton, notUtilityButton, etcButton
        ].forEach {
            $0.addTarget(self, action: #selector(itemButtonTapped), for: .touchUpInside)
        }
        nextButton.addTarget(
            self,
            action: #selector(nextButtonTouchUpInisde),
            for: .touchUpInside
        )
    }
    
    @objc
    private func itemButtonTapped(sender: UIButton) {
        [deleteButton, bugButton, betterOtherServiceButton,
                         lowFrequencyButton, notUtilityButton, etcButton
        ].forEach { $0.isSelected = false }
        [deleteCheckMarkButton, bugCheckMarkButton, betterOtherServiceCheckMarkButton,
                         lowFrequencyCheckMarkButton, notUtilityCheckMarkButton, etcCheckMarkButton
        ].forEach { $0.isSelected = false }
        
        sender.isSelected = true
        guard let checkmark = [deleteCheckMarkButton, bugCheckMarkButton, betterOtherServiceCheckMarkButton,
                         lowFrequencyCheckMarkButton, notUtilityCheckMarkButton, etcCheckMarkButton
        ].first(where: { $0.tag == sender.tag }) else { return }
        checkmark.isSelected = true
        let isValid = ![deleteButton, bugButton, betterOtherServiceButton,
                       lowFrequencyButton, notUtilityButton, etcButton
                      ].filter { $0.isSelected }.isEmpty
        nextButton.setNextButton(isSelected: isValid)
        etcTextView.isHidden = !etcButton.isSelected
        textLimitLabel.isHidden = !etcButton.isSelected
        
    }
    
    // MARK: Keyboard
    
    @objc
    private func keyboardUp(notification: NSNotification) {
        if let keyboardFrame:NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            scrollView.contentInset = .init(top: 0, left: 0, bottom: keyboardRectangle.height, right: 0)
        }
    }
    
    @objc
    private func nextButtonTouchUpInisde() {
        guard let selected = [deleteCheckMarkButton, bugCheckMarkButton, betterOtherServiceCheckMarkButton,
                              lowFrequencyCheckMarkButton, notUtilityCheckMarkButton, etcCheckMarkButton
        ].first(where: { $0.isSelected }) else {
            return
        }
        
        let reason = viewModel.reasonDict[selected.tag, default: "ETC"]
        var content = ""
        if selected == etcCheckMarkButton {
            content = etcTextView.text ?? ""
        }
        let body = RemoveAccountBody(reason: reason, content: content)
        viewModel.requestRemoveAccount(body: body)
    }
    
    @objc
    private func keyboardDown() {
//        self.view.transform = .identity
        self.scrollView.contentInset = .zero
    }
    
}
