//
//  LostItemWriteViewController.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/08/05.
//

import UIKit

final class LostItemWriteViewController: UIViewController {
    
    // MARK: UI Property
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "제목"
        label.font = .body1
        label.textColor = .body1
        return label
    }()
    
    private let titleView: UIView = {
        let view = UIView()
        view.backgroundColor = .hexF5F6F8
        view.layer.borderColor = UIColor.hex828996?.cgColor
        view.layer.cornerRadius = 8
        return view
    }()
    
    private let titleTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "제목을 적어주세요."
        textField.font = .body1
        textField.textColor = .body1
        textField.tintColor = .pointColor2
        return textField
    }()
    
    private let titleDotView: UIView = {
        let view = UIView()
        view.backgroundColor = .pointColor2
        view.layer.cornerRadius = 2
        return view
    }()
    
    private let categoryLabel: UILabel = {
        let label = UILabel()
        label.text = "분류"
        label.font = .body1
        label.textColor = .body1
        return label
    }()
    
    private let categoryView: UIView = {
        let view = UIView()
        view.backgroundColor = .hexF5F6F8
        view.layer.borderColor = UIColor.hex828996?.cgColor
        view.layer.cornerRadius = 8
        return view
    }()
    
    private let categoryPlaceHoldeLabel: UILabel = {
        let label = UILabel()
        label.font = .body1
        label.textColor = .hexBEC2CA
        label.text = "물건 종류 선택"
        return label
    }()
    
    private let categoryButton = UIButton()
    
    private let categoryArrowDownImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: ImageNamespace.expandBottomArrow)
        return imageView
    }()
    
    private let categoryDotView: UIView = {
        let view = UIView()
        view.backgroundColor = .pointColor2
        view.layer.cornerRadius = 2
        return view
    }()
    
    private let getLocationLabel: UILabel = {
        let label = UILabel()
        label.text = "습득장소"
        label.font = .body1
        label.textColor = .body1
        return label
    }()
    
    private let getLocationView: UIView = {
        let view = UIView()
        view.backgroundColor = .hexF5F6F8
        view.layer.borderColor = UIColor.hex828996?.cgColor
        view.layer.cornerRadius = 8
        return view
    }()
    
    private let getLocationPlaceHoldeLabel: UILabel = {
        let label = UILabel()
        label.font = .body1
        label.textColor = .body1
        label.text = "습득장소가 나오는 곳~"
        return label
    }()
    
    private let getLocationDotView: UIView = {
        let view = UIView()
        view.backgroundColor = .pointColor2
        view.layer.cornerRadius = 2
        return view
    }()
    
    private let detailLocationLabel: UILabel = {
        let label = UILabel()
        label.text = "세부장소"
        label.font = .body1
        label.textColor = .body1
        return label
    }()
    
    private let detailLocationView: UIView = {
        let view = UIView()
        view.backgroundColor = .hexF5F6F8
        view.layer.borderColor = UIColor.hex828996?.cgColor
        view.layer.cornerRadius = 8
        return view
    }()
    
    private let detailLocationTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "세부 장소를 적어주세요."
        textField.font = .body1
        textField.textColor = .body1
        textField.tintColor = .pointColor2
        return textField
    }()
    
    private let keepDateLabel: UILabel = {
        let label = UILabel()
        label.text = "습득일자"
        label.font = .body1
        label.textColor = .body1
        return label
    }()
    
    private let keepDateView: UIView = {
        let view = UIView()
        view.backgroundColor = .hexF5F6F8
        view.layer.borderColor = UIColor.hex828996?.cgColor
        view.layer.cornerRadius = 8
        return view
    }()
    
    private let keepDatePlaceHoldeLabel: UILabel = {
        let label = UILabel()
        label.font = .body1
        label.textColor = .hexBEC2CA
        label.text = "습득한 날짜를 선택해주세요."
        return label
    }()
    
    private let keepDateButton = UIButton()
    
    private let keepDateDotView: UIView = {
        let view = UIView()
        view.backgroundColor = .pointColor2
        view.layer.cornerRadius = 2
        return view
    }()
    
    private let keepTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "습득시간"
        label.font = .body1
        label.textColor = .body1
        return label
    }()
    
    private let keepTimeView: UIView = {
        let view = UIView()
        view.backgroundColor = .hexF5F6F8
        view.layer.borderColor = UIColor.hex828996?.cgColor
        view.layer.cornerRadius = 8
        return view
    }()
    
    private let keepTimePlaceHoldeLabel: UILabel = {
        let label = UILabel()
        label.font = .body1
        label.textColor = .hexBEC2CA
        label.text = "습득한 시간을 적어주세요."
        return label
    }()
    
    private let keepTimeButton = UIButton()
    
    private let otherLabel: UILabel = {
        let label = UILabel()
        label.text = "특이사항"
        label.font = .body1
        label.textColor = .body1
        return label
    }()
    
    private lazy var otherTextView: UITextView = {
        let textView = UITextView()
        textView.contentInset = .init(top: 3, left: 16, bottom: 0, right: 16)
        textView.backgroundColor = .hexF5F6F8
        textView.layer.cornerRadius = 8
        textView.font = .body1
        textView.textColor = .hexBEC2CA
        textView.text = Constants.LOSTITEM_OTHER_CONTENT_PLACEHOLDER
        textView.tintColor = .pointColor2
        textView.delegate = self
        return textView
    }()
    
    private let addFileLabel: UILabel = {
        let label = UILabel()
        label.text = "첨부파일"
        label.font = .body1
        label.textColor = .body1
        return label
    }()
    
    private let addFileView: UIView = {
        let view = UIView()
        view.backgroundColor = .hexF5F6F8
        view.layer.borderColor = UIColor.hex828996?.cgColor
        view.layer.cornerRadius = 8
        return view
    }()
    
    private let addFilePlaceHoldeLabel: UILabel = {
        let label = UILabel()
        label.font = .body1
        label.textColor = .hexBEC2CA
        label.text = "파일을 선택해주세요."
        return label
    }()
    
    private let addFileButton = UIButton()
    
    private let addFileDescriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.text = "5MB 이하의 이미지 파일(jpg, png)을 첨부하실 수 있습니다."
        label.font = .body5
        label.textColor = .hex828996
        return label
    }()
    
    private let addFileDotView: UIView = {
        let view = UIView()
        view.backgroundColor = .pointColor2
        view.layer.cornerRadius = 2
        return view
    }()
    
    private let completeButton: BottomNextButton = {
        let button = BottomNextButton()
        button.setTitle("작성 완료", for: .normal)
        return button
    }()
    
    private let emptyView = UIView()
    
    
    // MARK: Property
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
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
    
    // MARK: Configure
    
    private func configureUI() {
        configureSubviews()
        configureConstraints()
        configureNavigation()
    }
    
    private func configureSubviews() {
        view.backgroundColor = .white
        view.addSubviews(scrollView, completeButton, emptyView)
        scrollView.addSubview(contentView)
        
        contentView.addSubviews(
            titleLabel, titleView, categoryLabel, categoryView, getLocationLabel, getLocationView,
            detailLocationLabel, detailLocationView, keepDateLabel, keepDateView, keepTimeLabel,
            keepTimeView, otherLabel, addFileLabel, addFileView, otherTextView,
            addFileDescriptionLabel, titleDotView, categoryDotView, getLocationDotView,
            keepDateDotView, addFileDotView
        )
        titleView.addSubviews(titleTextField)
        categoryView.addSubviews(
            categoryPlaceHoldeLabel, categoryArrowDownImageView, categoryButton
        )
        getLocationView.addSubviews(getLocationPlaceHoldeLabel)
        detailLocationView.addSubview(detailLocationTextField)
        keepDateView.addSubviews(keepDateButton, keepDatePlaceHoldeLabel)
        keepTimeView.addSubviews(keepTimeButton, keepTimePlaceHoldeLabel)
        addFileView.addSubviews(addFilePlaceHoldeLabel, addFileButton)
    }
    
    private func configureConstraints() {
        scrollView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalTo(completeButton.snp.top).offset(-10)
        }
        contentView.snp.makeConstraints {
            $0.edges.equalTo(scrollView.contentLayoutGuide)
            $0.width.equalTo(scrollView.frameLayoutGuide)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(42)
            $0.leading.equalToSuperview().offset(24)
            $0.width.equalTo(60)
        }
        
        titleView.snp.makeConstraints {
            $0.leading.equalTo(titleLabel.snp.trailing).offset(25)
            $0.centerY.equalTo(titleLabel)
            $0.height.equalTo(42)
            $0.trailing.equalToSuperview().inset(24)
        }
        
        titleTextField.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
        
        categoryLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(24)
            $0.top.equalTo(titleLabel.snp.bottom).offset(32)
            $0.width.equalTo(60)
        }
        
        categoryView.snp.makeConstraints {
            $0.leading.equalTo(categoryLabel.snp.trailing).offset(25)
            $0.centerY.equalTo(categoryLabel)
            $0.height.equalTo(42)
            $0.trailing.equalToSuperview().inset(24)
        }
        
        categoryPlaceHoldeLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
        categoryArrowDownImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(9)
        }
        
        categoryButton.snp.makeConstraints { $0.edges.equalToSuperview() }
        
        getLocationLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(24)
            $0.top.equalTo(categoryLabel.snp.bottom).offset(32)
            $0.width.equalTo(60)
        }
        
        getLocationView.snp.makeConstraints {
            $0.leading.equalTo(getLocationLabel.snp.trailing).offset(25)
            $0.centerY.equalTo(getLocationLabel)
            $0.height.equalTo(42)
            $0.trailing.equalToSuperview().inset(24)
        }
        
        getLocationPlaceHoldeLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
        
        detailLocationLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(24)
            $0.top.equalTo(getLocationLabel.snp.bottom).offset(32)
            $0.width.equalTo(60)
        }
        
        detailLocationView.snp.makeConstraints {
            $0.leading.equalTo(detailLocationLabel.snp.trailing).offset(25)
            $0.centerY.equalTo(detailLocationLabel)
            $0.height.equalTo(42)
            $0.trailing.equalToSuperview().inset(24)
        }
        
        detailLocationTextField.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
        
        keepDateLabel.snp.makeConstraints {
            $0.top.equalTo(detailLocationLabel.snp.bottom).offset(32)
            $0.leading.equalToSuperview().offset(24)
            $0.width.equalTo(60)
        }
        
        keepDateView.snp.makeConstraints {
            $0.leading.equalTo(keepDateLabel.snp.trailing).offset(25)
            $0.centerY.equalTo(keepDateLabel)
            $0.height.equalTo(42)
            $0.trailing.equalToSuperview().inset(24)
        }
        
        keepDatePlaceHoldeLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
        
        keepDateButton.snp.makeConstraints { $0.edges.equalToSuperview() }
        
        keepTimeLabel.snp.makeConstraints {
            $0.top.equalTo(keepDateLabel.snp.bottom).offset(32)
            $0.leading.equalToSuperview().offset(24)
            $0.width.equalTo(60)
        }
        
        keepTimeView.snp.makeConstraints {
            $0.leading.equalTo(keepTimeLabel.snp.trailing).offset(25)
            $0.centerY.equalTo(keepTimeLabel)
            $0.height.equalTo(42)
            $0.trailing.equalToSuperview().inset(24)
        }
        
        keepTimePlaceHoldeLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
        
        keepTimeButton.snp.makeConstraints { $0.edges.equalToSuperview() }
        
        otherLabel.snp.makeConstraints {
            $0.top.equalTo(keepTimeLabel.snp.bottom).offset(32)
            $0.leading.equalToSuperview().offset(24)
            $0.width.equalTo(60)
        }
        
        otherTextView.snp.makeConstraints {
            $0.top.equalTo(keepTimeView.snp.bottom).offset(12)
            $0.leading.equalTo(otherLabel.snp.trailing).offset(25)
            $0.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(170)
        }
        
        addFileLabel.snp.makeConstraints {
            $0.top.equalTo(otherLabel.snp.bottom).offset(164)
            $0.leading.equalToSuperview().offset(24)
            $0.width.equalTo(60)
        }
        
        addFileView.snp.makeConstraints {
            $0.leading.equalTo(addFileLabel.snp.trailing).offset(25)
            $0.centerY.equalTo(addFileLabel)
            $0.height.equalTo(42)
            $0.trailing.equalToSuperview().inset(24)
        }
        
        addFilePlaceHoldeLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
        
        addFileButton.snp.makeConstraints { $0.edges.equalToSuperview() }
        
        addFileDescriptionLabel.snp.makeConstraints {
            $0.top.equalTo(addFileView.snp.bottom).offset(10)
            $0.leading.equalTo(addFileView)
            $0.trailing.equalToSuperview().inset(24)
            $0.bottom.equalToSuperview()
        }
        
        completeButton.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.bottom.equalTo(emptyView.snp.top).offset(-16)
            $0.height.equalTo(55)
        }
        
        emptyView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(1)
            $0.bottom.equalToSuperview()
        }
        
        titleDotView.snp.makeConstraints {
            $0.size.equalTo(4)
            $0.bottom.equalTo(titleLabel.snp.top)
            $0.leading.equalTo(titleLabel.snp.leading).offset(32)
        }
        
        categoryDotView.snp.makeConstraints {
            $0.size.equalTo(4)
            $0.bottom.equalTo(categoryLabel.snp.top)
            $0.leading.equalTo(categoryLabel.snp.leading).offset(32)
        }
        
        getLocationDotView.snp.makeConstraints {
            $0.size.equalTo(4)
            $0.bottom.equalTo(getLocationLabel.snp.top)
            $0.leading.equalTo(getLocationLabel.snp.trailing).offset(2)
        }
        
        keepDateDotView.snp.makeConstraints {
            $0.size.equalTo(4)
            $0.bottom.equalTo(keepDateLabel.snp.top)
            $0.leading.equalTo(keepDateLabel.snp.trailing).offset(2)
        }
        
        addFileDotView.snp.makeConstraints {
            $0.size.equalTo(4)
            $0.bottom.equalTo(addFileLabel.snp.top)
            $0.leading.equalTo(addFileLabel.snp.trailing).offset(2)
        }
        
        
    }
    
    private func configureNavigation() {
        title = "분실물 게시물 작성"
        configureBackbarButton()
    }
    
}

// MARK: Keyboard

extension LostItemWriteViewController {
    @objc
    private func keyboardUp(notification: NSNotification) {
        if let keyboardFrame:NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            
            UIView.animate(
                withDuration: 0.3, animations: { [weak self] in
                    self?.emptyView.snp.updateConstraints {
                        $0.height.equalTo(keyboardRectangle.height)
                    }
                }
            )
        }
    }
    
    @objc
    private func keyboardDown() {
        emptyView.snp.updateConstraints {
            $0.height.equalTo(1)
        }
    }
    
}

extension LostItemWriteViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == Constants.LOSTITEM_OTHER_CONTENT_PLACEHOLDER {
            textView.text = nil
            textView.textColor = .body1
            return
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            textView.text = Constants.LOSTITEM_OTHER_CONTENT_PLACEHOLDER
            textView.textColor = .hexBEC2CA
            return
        }

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
        
        // TODO: count 변경
        guard content.count <= 5 else { return false }
        return true
    }
}
