//
//  TermsOfServiceViewController.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/07/05.
//

import UIKit

import SnapKit

final class TermsOfServiceViewController: UIViewController {
    
    // MARK: - UI properties
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "커튼콜 서비스 이용을 위해\n약관 동의가 필요해요."
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 26, weight: .bold)
        label.textColor = UIColor(rgb: 0x111111)
        return label
    }()
    
    private let subTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "아래 약관 내용에 동의 후 서비스 이용이 가능합니다."
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = UIColor(rgb: 0x91959D)
        return label
    }()
    
    private let verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 24
        return stackView
    }()
    
    private let allCheckButton = CheckMarkButton()
    private let allCheckLabelButton: UIButton = {
        let button = UIButton()
        button.setTitle("전체 동의(선택사항 포함)", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        button.setTitleColor(.black, for: .normal)
        button.contentHorizontalAlignment = .left
        return button
    }()
    private let allCheckStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        return stackView
    }()
    
    private let serviceCheckButton = CheckMarkButton()
    private let serviceCheckLabelButton: UIButton = {
        let button = UIButton()
        button.setTitle("서비스 이용약관(필수)", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        button.setTitleColor(UIColor(rgb: 0x797979), for: .normal)
        button.contentHorizontalAlignment = .left
        return button
    }()
    
    private let serviceExpandButton = ExpandButton()
    
    private let serviceStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        return stackView
    }()
    
    private let locationCheckButton = CheckMarkButton()
    private let locationCheckLabelButton: UIButton = {
        let button = UIButton()
        button.setTitle("위치 (선택)", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        button.setTitleColor(UIColor(rgb: 0x797979), for: .normal)
        button.contentHorizontalAlignment = .left
        return button
    }()
    private let locationExpandButton = ExpandButton()
    private let locationStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        return stackView
    }()
    
    private let alarmCheckButton = CheckMarkButton()
    private let alarmCheckLabelButton: UIButton = {
        let button = UIButton()
        button.setTitle("알림 (선택)", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        button.setTitleColor(UIColor(rgb: 0x797979), for: .normal)
        button.contentHorizontalAlignment = .left
        return button
    }()
    private let alarmExpandButton = ExpandButton()
    private let alarmStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        return stackView
    }()
    
    private let marketingCheckButton = CheckMarkButton()
    private let marketingCheckLabelButton: UIButton = {
        let button = UIButton()
        button.setTitle("마케팅 정보 수신 동의 (선택)", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        button.setTitleColor(UIColor(rgb: 0x797979), for: .normal)
        button.contentHorizontalAlignment = .left
        return button
    }()
    private let marketingExpandButton = ExpandButton()
    private let marketingStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        return stackView
    }()
    
    private let nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("동의하고 계속하기", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        button.backgroundColor = UIColor(rgb: 0x91959D)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 15
        return button
    }()
    
    private let borderView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(rgb: 0xF2F3F5)
        return view
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
        view.backgroundColor = .white
        title = "약관 동의"
        configureSubviews()
        configureConstraints()
    }
    
    private func configureSubviews() {
        view.addSubviews(scrollView, nextButton)
        scrollView.addSubview(contentView)
        contentView.addSubviews(titleLabel, subTitleLabel, verticalStackView)
        verticalStackView.addArrangedSubviews(
            allCheckStackView, borderView, serviceStackView,
            locationStackView, alarmStackView, marketingStackView
        )
        allCheckStackView.addArrangedSubviews(allCheckButton, allCheckLabelButton)
        serviceStackView.addArrangedSubviews(
            serviceCheckButton, serviceCheckLabelButton, serviceExpandButton
        )
        locationStackView.addArrangedSubviews(
            locationCheckButton, locationCheckLabelButton, locationExpandButton
        )
        alarmStackView.addArrangedSubviews(
            alarmCheckButton, alarmCheckLabelButton, alarmExpandButton
        )
        marketingStackView.addArrangedSubviews(
            marketingCheckButton, marketingCheckLabelButton, marketingExpandButton
        )
    }
    
    private func configureConstraints() {
        scrollView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalTo(nextButton.snp.top).offset(-15)
        }
        
        contentView.snp.makeConstraints {
            $0.edges.equalTo(scrollView.contentLayoutGuide)
            $0.width.equalTo(scrollView.frameLayoutGuide.snp.width)
        }
        
        [allCheckButton, serviceCheckButton, serviceExpandButton,
         locationCheckButton, locationExpandButton, alarmCheckButton,
         alarmExpandButton, marketingCheckButton, marketingExpandButton
        ].forEach {
            $0.snp.makeConstraints { make in
                make.size.equalTo(24)
            }
        }
        nextButton.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.height.equalTo(58)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-20)
        }
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(32)
            $0.leading.equalToSuperview().offset(24)
        }
        subTitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(12)
            $0.leading.equalToSuperview().offset(24)
        }
        verticalStackView.snp.makeConstraints {
            $0.top.equalTo(subTitleLabel.snp.bottom).offset(48)
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.bottom.equalToSuperview().offset(-20)
        }
        borderView.snp.makeConstraints {
            $0.height.equalTo(1)
        }
        
    }
    
    private func addTargets() {
        [allCheckButton, serviceCheckButton,
         locationCheckButton, alarmCheckButton, marketingCheckButton].forEach {
            $0.addTarget(self, action: #selector(checkButtonTouchUpInside), for: .touchUpInside)
        }
    }
    
    // MARK: Actions
    
    @objc
    func checkButtonTouchUpInside(sender: UIButton) {
        sender.isSelected.toggle()
    }
    
}
