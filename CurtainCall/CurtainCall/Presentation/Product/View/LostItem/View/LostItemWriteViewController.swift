//
//  LostItemWriteViewController.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/08/05.
//

import UIKit
import Combine

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
    
    private lazy var titleTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "제목을 적어주세요."
        textField.font = .body1
        textField.textColor = .body1
        textField.tintColor = .pointColor2
        textField.delegate = self
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
    
    private lazy var getLocationPlaceHoldeLabel: UILabel = {
        let label = UILabel()
        label.font = .body1
        label.textColor = .body1
        label.text = name
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
    
    private lazy var detailLocationTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "세부 장소를 적어주세요."
        textField.font = .body1
        textField.textColor = .body1
        textField.tintColor = .pointColor2
        textField.delegate = self
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
    
    private lazy var lostItemCategoryView: LostItemSmallCategoryView = {
        let view = LostItemSmallCategoryView()
        view.isHidden = true
        view.layer.applySketchShadow(
            color: UIColor(rgb: 0x273041),
            alpha: 0.1,
            x: 0,
            y: 10,
            blur: 20,
            spread: 0
        )
        view.layer.cornerRadius = 10
        view.delegate = self
        return view
    }()
    
    private lazy var calendarView: CalendarView = {
        let calendarView = CalendarView(isSectableDates: [], isSelectableFuture: false)
        calendarView.layer.cornerRadius = 10
        calendarView.isHidden = true
        calendarView.layer.applySketchShadow(
            color: UIColor(rgb: 0x273041),
            alpha: 0.1,
            x: 0,
            y: 10,
            blur: 20,
            spread: 0
        )
        calendarView.delegate = self
        return calendarView
    }()
    
    private lazy var timePickerView: TimePickerView = {
        let pickerView = TimePickerView()
        pickerView.isHidden = true
        pickerView.layer.applySketchShadow(
            color: UIColor(rgb: 0x273041),
            alpha: 0.1,
            x: 0,
            y: 10,
            blur: 20,
            spread: 0
        )
        pickerView.layer.cornerRadius = 10
        pickerView.delegate = self
        return pickerView
    }()
    
    private lazy var lostItemAddFileView: AddFileView = {
        let addFileView = AddFileView()
        addFileView.isHidden = true
        addFileView.layer.applySketchShadow(
            color: UIColor(rgb: 0x273041),
            alpha: 0.1,
            x: 0,
            y: 10,
            blur: 20,
            spread: 0
        )
        addFileView.delegate = self
        addFileView.layer.cornerRadius = 10
        return addFileView
    }()
    
    private let emptyView = UIView()
    
    private lazy var picker: UIImagePickerController = {
        let picker = UIImagePickerController()
        picker.delegate = self
        return picker
    }()
    
    private let photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.contentMode = .scaleAspectFill
        imageView.isHidden = true
        return imageView
    }()
    
    private let photoRemoveButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: ImageNamespace.photoRemoveButton), for: .normal)
        button.isHidden = true
        return button
    }()
    
    // MARK: Property
    
    private let viewModel: LostItemWriteViewModel
    private var cancellables = Set<AnyCancellable>()
    private let id: String
    private let name: String

    // MARK: - Lifecycles
    
    // MARK: Life Cycle
    
    init(id: String, name: String, viewModel: LostItemWriteViewModel) {
        self.id = id
        self.name = name
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
//        hideKeyboardWhenTappedArround()
        addTargets()
        bind()
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
            photoImageView, photoRemoveButton, titleLabel, titleView, categoryLabel,
            categoryView, getLocationLabel, getLocationView,
            detailLocationLabel, detailLocationView, keepDateLabel, keepDateView, keepTimeLabel,
            keepTimeView, otherLabel, addFileLabel, addFileView, otherTextView,
            addFileDescriptionLabel, titleDotView, categoryDotView, getLocationDotView,
            keepDateDotView, addFileDotView, lostItemCategoryView, calendarView, timePickerView,
            lostItemAddFileView
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
            $0.top.equalTo(otherTextView.snp.bottom).offset(12)
            $0.leading.equalTo(addFileLabel.snp.trailing).offset(25)
            $0.height.equalTo(42)
            $0.trailing.equalToSuperview().inset(24)
        }
        
        photoImageView.snp.makeConstraints {
            $0.top.equalTo(otherTextView.snp.bottom).offset(12)
            $0.leading.equalTo(addFileLabel.snp.trailing).offset(25)
            $0.size.equalTo(80)
        }
        
        photoRemoveButton.snp.makeConstraints {
            $0.bottom.trailing.equalTo(photoImageView).offset(2)
            $0.size.equalTo(22)
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
            $0.bottom.equalToSuperview().inset(130)
        }
        
        completeButton.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.bottom.equalTo(emptyView.snp.top).offset(-50)
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
        
        lostItemCategoryView.snp.makeConstraints {
            $0.top.equalTo(categoryView.snp.bottom).offset(10)
            $0.leading.trailing.equalTo(categoryView)
        }
        
        calendarView.snp.makeConstraints {
            $0.top.equalTo(keepDateView.snp.bottom).offset(10)
            $0.horizontalEdges.equalToSuperview().inset(24)
        }
        
        timePickerView.snp.makeConstraints {
            $0.top.equalTo(keepTimeView.snp.bottom).offset(10)
            $0.leading.trailing.equalTo(keepTimeView)
            $0.height.equalTo(268)
        }
        
        lostItemAddFileView.snp.makeConstraints {
            $0.top.equalTo(addFileView.snp.bottom).offset(10)
            $0.leading.trailing.equalTo(addFileView)
            $0.height.equalTo(122)
        }
        
    
    }
    
    private func configureNavigation() {
        title = "분실물 게시물 작성"
        configureBackbarButton()
    }
    
    private func bind() {
        viewModel.$isTitleWrite.combineLatest(
            viewModel.$isCategoryWrite,
            viewModel.$isKeepDateWrite,
            viewModel.$isAddFile)
        .receive(on: DispatchQueue.main)
        .map { $0 && $1 && $2 && $3 }
        .sink { [weak self] isValid in
            self?.completeButton.setNextButton(isSelected: isValid)
        }.store(in: &cancellables)
        
        viewModel.$isSuccesUpload
            .dropFirst(1)
            .sink { [weak self] isSuccess in
                self?.showToast(isSuccess: isSuccess)
            }.store(in: &cancellables)
        
    }
    
    private func viewBorderInit() {
        [titleView, categoryView, detailLocationView, keepDateView, keepTimeView, otherTextView,
            addFileView
        ].forEach { view in
            view.layer.borderWidth = 0
        }
    }
    
    private func addTargets() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissInlineView))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
        
        categoryButton.addTarget(
            self,
            action: #selector(categoryButtonTouchUpInside),
            for: .touchUpInside
        )
        keepDateButton.addTarget(
            self,
            action: #selector(keepDateButtonTouchUpInside),
            for: .touchUpInside
        )
        keepTimeButton.addTarget(
            self,
            action: #selector(keepTimeButtonTouchUpInside),
            for: .touchUpInside
        )
        addFileButton.addTarget(
            self,
            action: #selector(addFileButtonTouchUpInside),
            for: .touchUpInside
        )
        photoRemoveButton.addTarget(
            self,
            action: #selector(photoRemoveButtonTouchUpInside),
            for: .touchUpInside
        )
        titleTextField.addTarget(
            self,
            action: #selector(textFieldChanged),
            for: .editingChanged
        )
        completeButton.addTarget(
            self,
            action: #selector(completeButtonTouchUpInside),
            for: .touchUpInside
        )
    }
    
    @objc
    private func categoryButtonTouchUpInside() {
        lostItemCategoryView.isHidden = false
        viewBorderInit()
        categoryView.layer.borderWidth = 1
    }
    
    @objc
    private func keepDateButtonTouchUpInside() {
        calendarView.isHidden = false
        viewBorderInit()
        keepDateView.layer.borderWidth = 1
    }
    
    @objc
    private func keepTimeButtonTouchUpInside() {
        timePickerView.isHidden = false
        viewBorderInit()
        keepTimeView.layer.borderWidth = 1
    }
    
    @objc
    private func addFileButtonTouchUpInside() {
        lostItemAddFileView.isHidden = false
        viewBorderInit()
        addFileView.layer.borderWidth = 1
    }
    
    @objc
    private func photoRemoveButtonTouchUpInside() {
        photoImageView.isHidden = true
        photoRemoveButton.isHidden = true
        photoImageView.image = nil
        addFileView.isHidden = false
        addFileDescriptionLabel.isHidden = false
        viewModel.isAddFile = false
        viewModel.imageID = nil
    }
    
    @objc
    private func textFieldChanged(sender: UITextField) {
        viewModel.titleTextFieldChanged(text: sender.text)
    }
    
    @objc
    private func completeButtonTouchUpInside() {
        guard let title = titleTextField.text,
              let particulars = otherTextView.text else { return }
        
        viewModel.uploadLostItem(
            title: title,
            id: id,
            detail: detailLocationTextField.text,
            particulars: otherTextView.text ?? ""
        )
//        navigationController?.navigationBar.isHidden = true
//        navigationController?.pushViewController(LostItemWriteCompleteViewController(), animated: true)
    }
    
    func showToast(isSuccess: Bool) {
        let toast = LostItemCompleteToastView(isSuccess: isSuccess)
        view.addSubview(toast)
        toast.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.height.equalTo(66)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(16)
        }
        if isSuccess {
            UIView.animate(
                withDuration: 1.5,
                delay: 0.3,
                animations: {
                    toast.alpha = 0.9
                    
                }) { [weak self] _ in
                    self?.navigationController?.popToRootViewController(animated: true)
                }
        } else {
            UIView.animate(
                withDuration: 1.5,
                delay: 0.3,
                animations: {
                    toast.alpha = 0.9
                }) {  _ in
                    toast.removeFromSuperview()
                }
            
        }
        
    }

    @objc
    private func dismissInlineView() {
        view.endEditing(true)
        lostItemCategoryView.isHidden = true
        calendarView.isHidden = true
        timePickerView.isHidden = true
        lostItemAddFileView.isHidden = true
        categoryView.layer.borderWidth = 0
        keepDateView.layer.borderWidth = 0
        keepTimeView.layer.borderWidth = 0
        addFileView.layer.borderWidth = 0
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
        guard content.count <= 100 else { return false }
        return true
    }
}

extension LostItemWriteViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let char = string.cString(using: String.Encoding.utf8) {
            let isBackSpace = strcmp(char, "\\b")
            if isBackSpace == -92 {
                return true
            }
        }
        guard let text = textField.text, text.count <= 20 else { return false }
        return true
    }
}

extension LostItemWriteViewController: LostItemViewDelegate {
    func didTappedCategoryButton(categoryType: LostItemCategoryType) {
        lostItemCategoryView.isHidden = true
        categoryPlaceHoldeLabel.text = categoryType.name
        categoryPlaceHoldeLabel.textColor = .body1
        viewModel.isCategoryWrite = true
        viewModel.selectCategory = categoryType
    }
}

extension LostItemWriteViewController: CalendarViewDelegate {
    func selectedCalendar(date: Date) {
        calendarView.isHidden = true
        keepDatePlaceHoldeLabel.text = date.convertToYearMonthDayString()
        keepDatePlaceHoldeLabel.textColor = .body1
        viewModel.selectDate(date: date)
    }
}

extension LostItemWriteViewController: TimePickerViewDelegate {
    func didTappedCheckButton(time: Date) {
        timePickerView.isHidden = true
        keepTimePlaceHoldeLabel.text = time.convertToHourMinString()
        keepTimePlaceHoldeLabel.textColor = .body1
        viewModel.selectTime(date: time)
    }
    
}

extension LostItemWriteViewController: AddFileViewDelegate {
    func didTapSelectImage() {
        lostItemAddFileView.isHidden = true
        openLibrary()
    }
    
    func didTapPhoto() {
        lostItemAddFileView.isHidden = true
        openCamera()
    }
}

extension LostItemWriteViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    private func openLibrary() {
        picker.sourceType = .photoLibrary
        present(picker, animated: true)
    }
    
    private func openCamera() {
        picker.sourceType = .camera
        present(picker, animated: true)
    }
    
    func imagePickerController(
        _ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]
    ) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            photoImageView.isHidden = false
            photoRemoveButton.isHidden = false
            photoImageView.image = image
            addFileView.isHidden = true
            addFileDescriptionLabel.isHidden = true
            if let data = image.jpegData(compressionQuality: 0.7) {
                viewModel.addFile(data: data)
                dismiss(animated: true)
            }
        }
    }
}



