//
//  MyRecruitmentEditViewController.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/08/15.
//

import UIKit
import Combine

final class MyRecruitmentEditViewController: UIViewController {
    
    // MARK: - UI properties
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.contentInset = .init(top: 0, left: 0, bottom: 30, right: 0)
        return scrollView
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private let headerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 26
        return imageView
    }()
    
    private let profileLabelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 2
        return stackView
    }()
    
    private let nickNameLabel: UILabel = {
        let label = UILabel()
        label.font = .subTitle4
        label.textColor = .title
        return label
    }()
    
    private let writeDateLabel: UILabel = {
        let label = UILabel()
        label.font = .body5
        label.textColor = .hexBEC2CA
        return label
    }()
    
    private lazy var titleTextField: UITextField = {
        let textField = UITextField()
        textField.text = prevInfo.title
        textField.backgroundColor = .hexF5F6F8
        textField.layer.cornerRadius = 10
        textField.font = .body2
        textField.textColor = .body1
        textField.addLeftPadding(width: 18)
        textField.delegate = self
        return textField
    }()
    
    private lazy var contentTextView: UITextView = {
        let textView = UITextView()
        textView.text = prevInfo.content
        textView.backgroundColor = .hexF5F6F8
        textView.layer.cornerRadius = 10
        textView.font = .body2
        textView.textColor = .body1
        textView.textContainerInset = .init(top: 12, left: 18, bottom: 12, right: 18)
        textView.textContainer.lineFragmentPadding = 0
        textView.delegate = self
        return textView
    }()
    
    private lazy var textLimitLabel: UILabel = {
        let label = UILabel()
        label.text = "글자수 제한 (\(prevInfo.content.count)/400)"
        label.font = .body5
        label.textColor = .hex828996
        return label
    }()
    
    
    private let grayBorderView: UIView = {
        let view = UIView()
        view.backgroundColor = .hexF5F6F8
        return view
    }()
    
    private let detailView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private let detailLabel: UILabel = {
        let label = UILabel()
        label.font = .subTitle4
        label.textColor = .pointColor1
        label.text = "상세 정보"
        return label
    }()
    
    private let detailStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        return stackView
    }()
    
    private let detailTitleView = UIView()
    private let detailTitleSymbolImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: ImageNamespace.partymemberDetailTitleSymbol)
        return imageView
    }()
    private let detailTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .body2
        label.text = "작품명"
        label.textColor = .hex5A6271
        return label
    }()
    private let detailProductLabel: UILabel = {
        let label = UILabel()
        label.font = .body2
        label.textColor = .body1
        return label
    }()
    
    private let detailStateView = UIView()
    private let detailStateSymbolImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: ImageNamespace.partymemberDetailCountStateSymbol)
        return imageView
    }()
    private let detailStateLabel: UILabel = {
        let label = UILabel()
        label.font = .body2
        label.text = "참여 상태"
        label.textColor = .hex5A6271
        return label
    }()
    private let detailCountLabel: UILabel = {
        let label = UILabel()
        label.font = .body2
        label.textColor = .body1
        return label
    }()
    
    private let detailDateView = UIView()
    private let detailDateSymbolImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: ImageNamespace.partymemberDetailDateSymbol)
        return imageView
    }()
    private let detailDateLabel: UILabel = {
        let label = UILabel()
        label.font = .body2
        label.text = "공연 일자"
        label.textColor = .hex5A6271
        return label
    }()
    private let detailProductDateLabel: UILabel = {
        let label = UILabel()
        label.font = .body2
        label.textColor = .body1
        return label
    }()
    
    private let detailTimeView = UIView()
    private let detailTimeSymbolImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: ImageNamespace.partymemberDetailTimeSymbol)
        return imageView
    }()
    private let detailTimeLabel: UILabel = {
        let label = UILabel()
        label.font = .body2
        label.text = "공연 시간"
        label.textColor = .hex5A6271
        return label
    }()
    private let detailProductTimeLabel: UILabel = {
        let label = UILabel()
        label.font = .body2
        label.textColor = .body1
        return label
    }()
    
    private let detailLocationView = UIView()
    private let detailLocationSymbolImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: ImageNamespace.partymemberDetailLocationSymbol)
        return imageView
    }()
    private let detailLocationLabel: UILabel = {
        let label = UILabel()
        label.font = .body2
        label.text = "공연 장소"
        label.textColor = .hex5A6271
        return label
    }()
    private let detailProductLocationLabel: UILabel = {
        let label = UILabel()
        label.font = .body2
        label.textColor = .body1
        return label
    }()
    
    private let partyInButton: BottomNextButton = {
        let button = BottomNextButton()
        button.setTitle("TALK 만들기", for: .normal)
        button.setNextButton(isSelected: true)
        return button
    }()
    
    // MARK: - Properties
    
    private let prevInfo: ProductPartyInfo
    private let viewModel: MyRecruitmentEditViewModel
    private var cancellables: Set<AnyCancellable> = []
    
    // MARK: - Lifecycles
    
    init(viewModel: MyRecruitmentEditViewModel, partyInfo: ProductPartyInfo) {
        self.viewModel = viewModel
        self.prevInfo = partyInfo
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        draw()
        addTarget()
        hideKeyboardWhenTappedArround()
        bind()
        
    }
    
    // MARK: - Helpers
    
    private func configureUI() {
        configureSubviews()
        configureConstraints()
        configureNavigation()
    }
    
    private func configureSubviews() {
        view.backgroundColor = .white
        view.addSubviews(scrollView, partyInButton)
        scrollView.addSubviews(contentView)
        contentView.addSubviews(headerView, grayBorderView, detailView)
        headerView.addSubviews(profileImageView, profileLabelStackView, titleTextField, contentTextView, textLimitLabel)
        profileLabelStackView.addArrangedSubviews(nickNameLabel, writeDateLabel)
        
        detailView.addSubviews(detailLabel, detailStackView)
        detailStackView.addArrangedSubviews(
            detailTitleView,
            detailStateView,
            detailDateView,
            detailTimeView,
            detailLocationView
        )
        detailTitleView.addSubviews(
            detailTitleSymbolImageView, detailTitleLabel, detailProductLabel
        )
        detailStateView.addSubviews(
            detailStateSymbolImageView, detailStateLabel, detailCountLabel
        )
        detailDateView.addSubviews(
            detailDateSymbolImageView, detailDateLabel, detailProductDateLabel
        )
        detailTimeView.addSubviews(
            detailTimeSymbolImageView, detailTimeLabel, detailProductTimeLabel
        )
        detailLocationView.addSubviews(
            detailLocationSymbolImageView, detailLocationLabel, detailProductLocationLabel
        )
        partyInButton.setNextButton(isSelected: true)
    }
    
    private func configureConstraints() {
        scrollView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalTo(partyInButton.snp.top).inset(30)
        }
        partyInButton.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.height.equalTo(55)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(16)
        }
        contentView.snp.makeConstraints {
            $0.edges.equalTo(scrollView.contentLayoutGuide)
            $0.width.equalTo(scrollView.frameLayoutGuide.snp.width)
            
        }
        headerView.snp.makeConstraints { $0.top.leading.trailing.equalToSuperview() }
        profileImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(24)
            $0.top.equalToSuperview().offset(31)
            $0.size.equalTo(52)
        }
        profileLabelStackView.snp.makeConstraints {
            $0.centerY.equalTo(profileImageView)
            $0.leading.equalTo(profileImageView.snp.trailing).offset(16)
        }
        
        titleTextField.snp.makeConstraints {
            $0.top.equalTo(profileImageView.snp.bottom).offset(30)
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.height.equalTo(42)
        }
        
        contentTextView.snp.makeConstraints {
            $0.top.equalTo(titleTextField.snp.bottom).offset(16)
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.height.equalTo(227)
        }
        
        textLimitLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(24)
            $0.top.equalTo(contentTextView.snp.bottom).offset(8)
            $0.bottom.equalToSuperview().inset(30)
        }
        
        grayBorderView.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(10)
        }
        
        detailView.snp.makeConstraints {
            $0.top.equalTo(grayBorderView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        detailLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(30)
            $0.leading.equalToSuperview().offset(24)
        }
        detailStackView.snp.makeConstraints {
            $0.top.equalTo(detailLabel.snp.bottom).offset(12)
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.bottom.equalToSuperview().offset(-20)

        }
        detailTitleView.snp.makeConstraints {
            $0.height.equalTo(48)
        }
        detailTitleSymbolImageView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.size.equalTo(24)
        }
        detailTitleLabel.snp.makeConstraints {
            $0.leading.equalTo(detailTitleSymbolImageView.snp.trailing).offset(10)
            $0.centerY.equalToSuperview()
        }
        detailProductLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(121)
            $0.centerY.equalToSuperview()
        }
        detailStateView.snp.makeConstraints {
            $0.height.equalTo(48)
        }
        detailStateSymbolImageView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.size.equalTo(24)
        }
        detailStateLabel.snp.makeConstraints {
            $0.leading.equalTo(detailStateSymbolImageView.snp.trailing).offset(10)
            $0.centerY.equalToSuperview()
        }
        detailCountLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(121)
            $0.centerY.equalToSuperview()
        }
        detailDateView.snp.makeConstraints {
            $0.height.equalTo(48)
        }
        detailDateSymbolImageView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        detailDateLabel.snp.makeConstraints {
            $0.leading.equalTo(detailDateSymbolImageView.snp.trailing).offset(10)
            $0.centerY.equalToSuperview()
        }
        detailProductDateLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(121)
            $0.centerY.equalToSuperview()
        }
        detailTimeView.snp.makeConstraints {
            $0.height.equalTo(48)
        }
        detailTimeSymbolImageView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        detailTimeLabel.snp.makeConstraints {
            $0.leading.equalTo(detailTimeSymbolImageView.snp.trailing).offset(10)
            $0.centerY.equalToSuperview()
        }
        detailProductTimeLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(121)
            $0.centerY.equalToSuperview()
        }
        detailLocationView.snp.makeConstraints {
            $0.height.equalTo(48)
        }
        detailLocationSymbolImageView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.centerY.equalToSuperview()
            
        }
        detailLocationLabel.snp.makeConstraints {
            $0.leading.equalTo(detailLocationSymbolImageView.snp.trailing).offset(10)
            $0.centerY.equalToSuperview()
        }
        detailProductLocationLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(121)
            $0.centerY.equalToSuperview()
        }
    }
    
    private func configureNavigation() {
        configureBackbarButton(.pop)
        title = "MY 모집"
    }
    
    private func draw() {
        profileImageView.image = prevInfo.profileImage
        nickNameLabel.text = prevInfo.nickname
        
        writeDateLabel.text = prevInfo.writeDate.convertToYearMonthDayHourMinString()
        detailProductLabel.text = prevInfo.productName
        detailCountLabel.text = "\(prevInfo.minCount)/\(prevInfo.maxCount)"
        detailProductDateLabel.text = prevInfo.productDate.convertToYearMonthDayWeekString()
        detailProductTimeLabel.text = prevInfo.productDate.convertToHourMinString()
        detailProductLocationLabel.text = prevInfo.location
    }
    
    private func updateCountLabel(count: Int) {
        textLimitLabel.text = "글자수 제한 (\(count)/400)"
    }
    
    private func bind() {
        viewModel.isValid
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isValid in
                self?.setNextButton(isSelected: isValid)
            }.store(in: &cancellables)
    }
    private func addTarget() {
        partyInButton.addTarget(
            self,
            action: #selector(partyInButtonTouchUpInside), for: .touchUpInside)
        titleTextField.addTarget(
            self,
            action: #selector(textFieldChanged),
            for: .editingChanged
        )
    }
    
    private func setNextButton(isSelected: Bool) {
        partyInButton.backgroundColor = isSelected ? .pointColor2 : .hexE4E7EC
        partyInButton.setTitleColor(
            isSelected ? .white : .hexBEC2CA,
            for: .normal
        )
        partyInButton.isUserInteractionEnabled = isSelected
    }
    
    @objc
    private func textFieldChanged(sender: UITextField) {
        viewModel.titleTextFieldChanged(text: sender.text)
    }
    
    @objc
    private func partyInButtonTouchUpInside() {
        navigationController?.popViewController(animated: true)
    }
    
}

extension MyRecruitmentEditViewController: UITextFieldDelegate {
    func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String
    ) -> Bool {
        viewModel.titleTextFieldChanged(text: textField.text)
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        viewModel.titleTextFieldChanged(text: textField.text)
    }
}

extension MyRecruitmentEditViewController: UITextViewDelegate {
    func textViewDidEndEditing(_ textView: UITextView) {
        viewModel.contentTextViewChanged(text: textView.text)
    }
    
    func textView(
        _ textView: UITextView,
        shouldChangeTextIn range: NSRange,
        replacementText text: String
    ) -> Bool {
        guard let content = textView.text else { return false }
        if let char = text.cString(using: String.Encoding.utf8) {
            let isBackSpace = strcmp(char, "\\b")
            if isBackSpace == -92 {
                return true
            }
        }
        guard content.count <= 400 else { return false }
        return true
    }
    
    func textViewDidChange(_ textView: UITextView) {
        updateCountLabel(count: textView.text.count)
        viewModel.contentTextViewChanged(text: textView.text)
    }
}
