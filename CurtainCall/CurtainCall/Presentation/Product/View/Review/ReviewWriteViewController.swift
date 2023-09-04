//
//  ReviewWriteViewController.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/07/30.
//

import UIKit
import Combine

final class ReviewWriteViewController: UIViewController {
    
    // MARK: - UI properties
    
    private let topView: UIView = {
        let view = UIView()
        view.backgroundColor = .hex2B313A
        return view
    }()
    
    private let navigationView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private let backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: ImageNamespace.navigationBackButtonWhite), for: .normal)
        return button
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .subTitle4
        label.textColor = .white
        label.text = "한 줄 리뷰 작성"
        return label
    }()
    
    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let categoryView: UIView = {
        let view = UIView()
        view.backgroundColor = .pointColor2
        view.layer.cornerRadius = 12
        return view
    }()
    
    private let categoryLabel: UILabel = {
        let label = UILabel()
        label.text = "뮤지컬"
        label.font = .body5
        label.textColor = .white
        return label
    }()
    
    private let productLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .subTitle2
        return label
    }()
    
    private let questionLabel: UILabel = {
        let label = UILabel()
        label.text = "공연은 만족스러우셨나요?"
        label.textColor = .title
        label.font = .subTitle4
        return label
    }()
    
    private let starView: UIView = {
        let view = UIView()
        view.backgroundColor = .hexF5F6F8
        view.layer.cornerRadius = 10
        return view
    }()
    
    private let starStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 5
        return stackView
    }()
    
    private let starImageViews: [UIImageView] = {
        var imageViews: [UIImageView] = []
        for i in 1...5 {
            let imageView = UIImageView()
            imageView.image = UIImage(named: ImageNamespace.reviewGradeStarEmptySymbol)
            imageView.tag = i
            imageViews.append(imageView)
        }
        return imageViews
    }()
    
    private let slider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 0
        slider.maximumValue = 5
        slider.value = 0
        slider.minimumTrackTintColor = .clear
        slider.maximumTrackTintColor = .clear
        slider.thumbTintColor = .clear
        slider.addTapGesture()
        return slider
    }()
    
    private let reviewWriteLabel: UILabel = {
        let label = UILabel()
        label.text = "한 줄 리뷰를 남겨주세요!"
        label.textColor = .title
        label.font = .subTitle4
        return label
    }()
    
    private lazy var reviewTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .hexF5F6F8
        textView.textColor = .hexBEC2CA
        textView.layer.cornerRadius = 10
        textView.delegate = self
        textView.font = .body2
        textView.text = Constants.REVIEW_WRITE_TEXTVIEW_PLACEHOLDER
        textView.textContainerInset = .init(top: 15, left: 18, bottom: 15, right: 18)
        textView.textContainer.lineFragmentPadding = 0
        return textView
    }()
    
    private let textCountLimitLabel: UILabel = {
        let label = UILabel()
        label.text = "글자수 제한 (0/20)"
        label.textColor = .hex828996
        label.font = .body5
        return label
    }()
    
    private let completeButton: BottomNextButton = {
        let button = BottomNextButton()
        button.setTitle("작성 완료", for: .normal)
        return button
    }()
    
    // MARK: - Properties
    
    private var cancellables: Set<AnyCancellable> = []
    private let viewModel: ReviewWriteViewModel
    private let product: ProductDetailResponse
    private let id: String
    
    // MARK: - Lifecycles
    
    init(product: ProductDetailResponse, id: String, viewModel: ReviewWriteViewModel) {
        self.product = product
        self.id = id
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        addTargets()
        bind()
        hideKeyboardWhenTappedArround()
        draw(product)
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardUp), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDown), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        navigationController?.navigationBar.isHidden = false
    }
    
    // MARK: - Helpers
    
    private func configureUI() {
        configureSubviews()
        configureConstraints()
    }
    
    private func configureSubviews() {
        view.backgroundColor = .white
        view.addSubviews(
            topView, questionLabel, starView, slider, reviewWriteLabel, reviewTextView, textCountLimitLabel, completeButton
        )
        topView.addSubviews(navigationView, posterImageView, categoryView, productLabel)
        navigationView.addSubviews(backButton, titleLabel)
        categoryView.addSubview(categoryLabel)
        starView.addSubview(starStackView)
        starImageViews.forEach { starStackView.addArrangedSubview($0) }
    }
    
    private func configureConstraints() {
        topView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
        }
        navigationView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(40)
        }
        backButton.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.centerY.equalToSuperview()
        }
        titleLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        posterImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(navigationView.snp.bottom).offset(20)
            $0.height.equalTo(150)
            $0.width.equalTo(120)
        }
        categoryLabel.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(10)
            $0.verticalEdges.equalToSuperview().inset(4)
        }
        categoryView.snp.makeConstraints {
            $0.top.equalTo(posterImageView.snp.bottom).offset(12)
            $0.centerX.equalToSuperview()
        }
        productLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(categoryView.snp.bottom).offset(6)
            $0.bottom.equalToSuperview().inset(28)
        }
        questionLabel.snp.makeConstraints {
            $0.top.equalTo(topView.snp.bottom).offset(30)
            $0.centerX.equalToSuperview()
        }
        starView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.top.equalTo(questionLabel.snp.bottom).offset(12)
            $0.height.equalTo(67)
        }
        starStackView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        slider.snp.makeConstraints {
            $0.edges.equalTo(starStackView)
        }
        
        reviewWriteLabel.snp.makeConstraints {
            $0.top.equalTo(starView.snp.bottom).offset(40)
            $0.centerX.equalToSuperview()
        }
        reviewTextView.snp.makeConstraints {
            $0.top.equalTo(reviewWriteLabel.snp.bottom).offset(12)
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.height.equalTo(51)
        }
        textCountLimitLabel.snp.makeConstraints {
            $0.top.equalTo(reviewTextView.snp.bottom).offset(10)
            $0.trailing.equalToSuperview().inset(24)
        }
        
        completeButton.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.height.equalTo(55)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(16)
        }
    }
    
    private func addTargets() {
        slider.addTarget(self, action: #selector(onDragStarSlider), for: .valueChanged)
        completeButton.addTarget(self, action: #selector(completeButtonTouchUpInside), for: .touchUpInside)
        backButton.addTarget(self, action: #selector(backButtonTouchUpInside), for: .touchUpInside)
    }
    
    private func draw(_ product: ProductDetailResponse) {
        if let url = URL(string: product.poster) {
            posterImageView.kf.setImage(with: url)
        } else {
            posterImageView.image = nil
        }
        categoryLabel.text = product.genre == "PLAY" ? "연극" : "뮤지컬"
        productLabel.text = product.name
    }
    
    private func bind() {
        viewModel.$isValidReview
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isValid in
                self?.completeButton.setNextButton(isSelected: isValid)
            }.store(in: &cancellables)
        viewModel.$isWriteReview
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isWrite in
                if isWrite {
                    self?.navigationController?.popViewController(animated: true)
                }
            }.store(in: &cancellables)
    }
    
    @objc
    func onDragStarSlider(_ sender: UISlider) {
        let value = Int(sender.value.rounded())
        for index in 1...5 {
            if let starImage = view.viewWithTag(index) as? UIImageView {
                if index <= value {
                    starImage.image = UIImage(named: ImageNamespace.reviewGradeStarSymbol)
                } else {
                    starImage.image = UIImage(named: ImageNamespace.reviewGradeStarEmptySymbol)
                }
            }
        }
    }
    
    @objc
    func completeButtonTouchUpInside() {
        viewModel.requestCreateReview(id: id, grade: Int(slider.value.rounded()), content: reviewTextView.text)
    }
    
    @objc
    private func backButtonTouchUpInside() {
        navigationController?.popViewController(animated: true)
    }
    
    private func updateCountLabel(count: Int) {
        textCountLimitLabel.text = "글자수 제한 (\(count)/20)"
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

extension ReviewWriteViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        updateCountLabel(count: textView.text.count)
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == Constants.REVIEW_WRITE_TEXTVIEW_PLACEHOLDER {
            textView.textColor = .body1
            textView.text = nil
            return
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            textView.text = Constants.REVIEW_WRITE_TEXTVIEW_PLACEHOLDER
            textView.textColor = .hexBEC2CA
            viewModel.reviewTextViewChanged(text: textView.text)
            return
        }
        
    }
    
    func textView(
        _ textView: UITextView,
        shouldChangeTextIn range: NSRange,
        replacementText text: String
    ) -> Bool {
        guard let content = textView.text else { return false }
        viewModel.reviewTextViewChanged(text: textView.text)
        if let char = text.cString(using: String.Encoding.utf8) {
            let isBackSpace = strcmp(char, "\\b")
            if isBackSpace == -92 {
                return true
            }
        }
        guard content.count <= 20 else { return false }
        return true
    }
}
extension UISlider {
    public func addTapGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        addGestureRecognizer(tap)
    }

    @objc private func handleTap(_ sender: UITapGestureRecognizer) {
        let location = sender.location(in: self)
        let percent = minimumValue + Float(location.x / bounds.width) * maximumValue
        setValue(percent, animated: true)
        sendActions(for: .valueChanged)
    }
}
