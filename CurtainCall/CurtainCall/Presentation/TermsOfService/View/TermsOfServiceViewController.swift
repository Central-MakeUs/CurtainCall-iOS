//
//  TermsOfServiceViewController.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/07/05.
//

import UIKit
import Combine

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
        label.textColor = .title
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
    
    private let allCheckButton: CheckMarkButton = {
        let button = CheckMarkButton()
        button.tag = 0
        return button
    }()
    
    private let allCheckLabelButton: UIButton = {
        let button = UIButton()
        button.setTitle("전체 동의(선택 포함)", for: .normal)
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
    private let serviceCheckButton: CheckMarkButton = {
        let button = CheckMarkButton()
        button.tag = 1
        return button
    }()
    private let serviceCheckLabelButton: UIButton = {
        let button = UIButton()
        button.setTitle("[필수] 서비스 이용약관 동의", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        button.setTitleColor(UIColor(rgb: 0x797979), for: .normal)
        button.contentHorizontalAlignment = .left
        return button
    }()
    
    private let serviceExpandButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "navigate_next"), for: .normal)
        return button
    }()
    private let serviceView = UIView()
    private let locationCheckButton: CheckMarkButton = {
        let button = CheckMarkButton()
        button.tag = 2
        return button
    }()
    private let locationCheckLabelButton: UIButton = {
        let button = UIButton()
        button.setTitle("[필수] 개인정보 수집·이용 동의", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        button.setTitleColor(UIColor(rgb: 0x797979), for: .normal)
        button.contentHorizontalAlignment = .left
        return button
    }()
    private let locationExpandButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "navigate_next"), for: .normal)
        return button
    }()
    
    private let locationView = UIView()
    
    private let alarmCheckButton: CheckMarkButton = {
        let button = CheckMarkButton()
        button.tag = 3
        return button
    }()
    private let alarmCheckLabelButton: UIButton = {
        let button = UIButton()
        button.setTitle("[필수] 만 14세 이상 회원입니다.", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        button.setTitleColor(UIColor(rgb: 0x797979), for: .normal)
        button.contentHorizontalAlignment = .left
        return button
    }()
    private let alarmExpandButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "navigate_next"), for: .normal)
        button.isHidden = true
        return button
    }()
    
    private let alarmView = UIView()
    
    private let marketingCheckButton: CheckMarkButton = {
        let button = CheckMarkButton()
        button.tag = 4
        return button
    }()
    private let marketingCheckLabelButton: UIButton = {
        let button = UIButton()
        button.setTitle("마케팅 정보 수신 동의 (선택)", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        button.setTitleColor(UIColor(rgb: 0x797979), for: .normal)
        button.contentHorizontalAlignment = .left
        return button
    }()
    private let marketingExpandButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "navigate_next"), for: .normal)
        return button
    }()
    private let marketingStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.isHidden = true
        return stackView
    }()
    
    private let nextButton: BottomNextButton = {
        let button = BottomNextButton()
        button.setTitle("다음", for: .normal)
        button.setNextButton(isSelected: false)
        return button
    }()
    
    private let borderView: UIView = {
        let view = UIView()
        view.backgroundColor = .hexF2F3F5
        return view
    }()
    
    // MARK: - Properties
    
    private let viewModel: TermsOfServiceViewModel
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Lifecycles
    
    init(viewModel: TermsOfServiceViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        addTargets()
        bind()
    }
    
    // MARK: - Helpers
    
    private func configureUI() {
        view.backgroundColor = .white
        title = "약관 동의"
        configureSubviews()
        configureConstraints()
        configureNavigation()
    }
    
    private func configureSubviews() {
        view.addSubviews(scrollView, nextButton)
        scrollView.addSubview(contentView)
        contentView.addSubviews(titleLabel, subTitleLabel, verticalStackView)
        verticalStackView.addArrangedSubviews(
            allCheckStackView, borderView, serviceView,
            locationView, alarmView, marketingStackView
        )
        allCheckStackView.addArrangedSubviews(allCheckButton, allCheckLabelButton)
        serviceView.addSubviews(
            serviceCheckButton, serviceCheckLabelButton, serviceExpandButton
        )
        locationView.addSubviews(
            locationCheckButton, locationCheckLabelButton, locationExpandButton
        )
        alarmView.addSubviews(
            alarmCheckButton, alarmCheckLabelButton, alarmExpandButton
        )
        marketingStackView.addArrangedSubviews(
            marketingCheckButton, marketingCheckLabelButton
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
        [serviceView, locationView, alarmView].forEach {
            $0.snp.makeConstraints { make in
                make.height.equalTo(24)
            }
        }
        [allCheckButton, serviceCheckButton,
         locationCheckButton,  alarmCheckButton,
          marketingCheckButton,
        ].forEach {
            $0.snp.makeConstraints { make in
                make.leading.equalToSuperview()
                make.size.equalTo(24)
                make.centerY.equalToSuperview()
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
        [serviceCheckLabelButton,
        locationCheckLabelButton,
         alarmCheckLabelButton].forEach {
            $0.snp.makeConstraints { make in
                make.leading.equalToSuperview().offset(34)
                make.centerY.equalToSuperview()
            }
        }
        [serviceExpandButton,
         locationExpandButton,
         alarmExpandButton].forEach {
            $0.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.trailing.equalToSuperview()
            }
        }
    }
    
    private func configureNavigation() {
        configureBackbarButton(.pop)
        title = "약관 동의"
    }
    
    private func addTargets() {
        [allCheckButton, serviceCheckButton,
         locationCheckButton, alarmCheckButton, marketingCheckButton].forEach {
            $0.addTarget(self, action: #selector(checkButtonTouchUpInside), for: .touchUpInside)
        }
        nextButton.addTarget(self, action: #selector(nextButtonTouchUpInside), for: .touchUpInside)
        serviceExpandButton.addTarget(self, action: #selector(serviceButtonTapped), for: .touchUpInside)
        locationExpandButton.addTarget(self, action: #selector(privacyButtonTapped), for: .touchUpInside)
    }
    
    private func bind() {
        viewModel.isAllCheck.sink { [weak self] isSelected in
            self?.allCheckButton.isSelected = isSelected
        }.store(in: &cancellables)
        
        viewModel.isServiceCheck.sink { [weak self] isSelected in
            self?.serviceCheckButton.isSelected = isSelected
        }.store(in: &cancellables)
        
        viewModel.isLocationCheck.sink { [weak self] isSelected in
            self?.locationCheckButton.isSelected = isSelected
        }.store(in: &cancellables)
        
        viewModel.isAlarmCheck.sink { [weak self] isSelected in
            self?.alarmCheckButton.isSelected = isSelected
        }.store(in: &cancellables)
        
        viewModel.isMarketingCheck.sink { [weak self] isSelected in
            self?.marketingCheckButton.isSelected = isSelected
        }.store(in: &cancellables)
        
        viewModel.isCheckedRequire.sink { [weak self] isCheck in
            self?.nextButton.setNextButton(isSelected: isCheck)
        }.store(in: &cancellables)

    }
    
    private func moveToNicknameSettingViewController() {
        let nicknameSettingViewController = NicknameSettingViewController(
            viewModel: NicknameSettingViewModel(
            usecase: NicknameSettingInteractor()
            )
        )
        navigationController?.pushViewController(nicknameSettingViewController, animated: true)
    }
    
    // MARK: Actions
    
    @objc
    func checkButtonTouchUpInside(sender: UIButton) {
        viewModel.checkButtonTouchUpInside(tag: sender.tag)
    }
    
    @objc
    func nextButtonTouchUpInside() {
        moveToNicknameSettingViewController()
    }
    
    @objc
    private func serviceButtonTapped() {
        navigationController?.pushViewController(TermsOfUseViewController(), animated: true)
    }
    
    @objc
    private func privacyButtonTapped() {
        navigationController?.pushViewController(PrivacyPolicyViewController(), animated: true)
    }
    

}
