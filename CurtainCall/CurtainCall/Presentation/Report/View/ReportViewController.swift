//
//  ReportViewController.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/08/15.
//

import UIKit
import Combine

final class ReportViewController: UIViewController {
    
    // MARK: - UI properties
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "해당 게시물은\n신고하는 이유를 선택해주세요."
        label.font = .subTitle2
        label.textColor = .title
        label.numberOfLines = 0
        return label
    }()
    
    private let itemStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        return stackView
    }()
    
    private let spamView = UIView()
    private let spamButton = UIButton()
    private let spamCheckMarkImage: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: ImageNamespace.checkmarkButtonDeselected), for: .normal)
        button.setImage(UIImage(named: ImageNamespace.checkmarkButtonSelected), for: .selected)
        button.tag = 0
        return button
    }()
    private let spamLabel: UILabel = {
        let label = UILabel()
        label.text = "스팸홍보/도배글입니다."
        label.font = .body1
        label.textColor = .hex5A6271
        return label
    }()
    private let spamExpendImageView: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: ImageNamespace.ExpandButtonArrowBottom), for: .normal)
        button.tag = 0
        return button
    }()
    
    private let abuseView = UIView()
    private let abuseButton = UIButton()
    private let abuseCheckMarkImage: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: ImageNamespace.checkmarkButtonDeselected), for: .normal)
        button.setImage(UIImage(named: ImageNamespace.checkmarkButtonSelected), for: .selected)
        button.tag = 1
        return button
    }()
    private let abuseLabel: UILabel = {
        let label = UILabel()
        label.text = "욕설/혐오/차별적 표현입니다."
        label.font = .body1
        label.textColor = .hex5A6271
        return label
    }()
    private let abuseExpendImageView: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: ImageNamespace.ExpandButtonArrowBottom), for: .normal)
        button.tag = 1
        return button
    }()
    
    private let illegalView = UIView()
    private let illegalButton = UIButton()
    private let illegalCheckMarkImage: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: ImageNamespace.checkmarkButtonDeselected), for: .normal)
        button.setImage(UIImage(named: ImageNamespace.checkmarkButtonSelected), for: .selected)
        button.tag = 2
        return button
    }()
    private let illegalLabel: UILabel = {
        let label = UILabel()
        label.text = "불법정보를 포함하고 있습니다."
        label.font = .body1
        label.textColor = .hex5A6271
        return label
    }()
    private let illegalExpendImageView: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: ImageNamespace.ExpandButtonArrowBottom), for: .normal)
        button.tag = 2
        return button
    }()
    
    private let badMannersView = UIView()
    private let badMannersButton = UIButton()
    private let badMannersCheckMarkImage: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: ImageNamespace.checkmarkButtonDeselected), for: .normal)
        button.setImage(UIImage(named: ImageNamespace.checkmarkButtonSelected), for: .selected)
        button.tag = 3
        return button
    }()
    private let badMannersLabel: UILabel = {
        let label = UILabel()
        label.text = "비매너 사용자입니다."
        label.font = .body1
        label.textColor = .hex5A6271
        return label
    }()
    private let badMannersExpendImageView: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: ImageNamespace.ExpandButtonArrowBottom), for: .normal)
        button.tag = 3
        return button
    }()
    
    private let harmfulnessView = UIView()
    private let harmfulnessButton = UIButton()
    private let harmfulnessCheckMarkImage: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: ImageNamespace.checkmarkButtonDeselected), for: .normal)
        button.setImage(UIImage(named: ImageNamespace.checkmarkButtonSelected), for: .selected)
        button.tag = 4
        return button
    }()
    private let harmfulnessLabel: UILabel = {
        let label = UILabel()
        label.text = "청소년에게 유해한 내용입니다."
        label.font = .body1
        label.textColor = .hex5A6271
        return label
    }()
    private let harmfulnessExpendImageView: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: ImageNamespace.ExpandButtonArrowBottom), for: .normal)
        button.tag = 4
        return button
    }()
    
    private let privacyView = UIView()
    private let privacyButton = UIButton()
    private let privacyCheckMarkImage: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: ImageNamespace.checkmarkButtonDeselected), for: .normal)
        button.setImage(UIImage(named: ImageNamespace.checkmarkButtonSelected), for: .selected)
        button.tag = 5
        return button
    }()
    private let privacyLabel: UILabel = {
        let label = UILabel()
        label.text = "개인정보 노출 게시물입니다."
        label.font = .body1
        label.textColor = .hex5A6271
        return label
    }()
    private let privacyExpendImageView: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: ImageNamespace.ExpandButtonArrowBottom), for: .normal)
        button.tag = 5
        return button
    }()
    
    private let otherView = UIView()
    private let otherButton = UIButton()
    private let otherCheckMarkImage: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: ImageNamespace.checkmarkButtonDeselected), for: .normal)
        button.setImage(UIImage(named: ImageNamespace.checkmarkButtonSelected), for: .selected)
        button.tag = 6
        return button
    }()
    private let otherLabel: UILabel = {
        let label = UILabel()
        label.text = "청소년에게 유해한 내용입니다."
        label.font = .body1
        label.textColor = .hex5A6271
        return label
    }()
    private let otherExpendImageView: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: ImageNamespace.ExpandButtonArrowBottom), for: .normal)
        button.tag = 6
        return button
    }()
    
    private let nextButton: BottomNextButton = {
        let button = BottomNextButton()
        button.setTitle("다음", for: .normal)
        button.setNextButton(isSelected: false)
        return button
    }()
    
    // MARK: - Properties
    
    private let viewModel: ReportViewModel
    private var subscriptions: Set<AnyCancellable> = []
    
    // MARK: - Lifecycles
    
    init(viewModel: ReportViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        [spamButton, abuseButton, illegalButton, badMannersButton,
        harmfulnessButton, privacyButton, otherButton
        ].enumerated().forEach {
            $0.element.tag = $0.offset
            $0.element.addTarget(
                self,
                action: #selector(itemTapped),
                for: .touchUpInside
            )
        }
        nextButton.addTarget(self, action: #selector(nextButtonTouchUpInside), for: .touchUpInside)
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
        view.addSubviews(titleLabel, itemStackView, nextButton)
        itemStackView.addArrangedSubviews(
            spamView, abuseView, illegalView, badMannersView, harmfulnessView, privacyView, otherView
        )
        spamView.addSubviews(spamCheckMarkImage, spamLabel, spamExpendImageView, spamButton)
        abuseView.addSubviews(abuseCheckMarkImage, abuseLabel, abuseExpendImageView, abuseButton)
        illegalView.addSubviews(illegalCheckMarkImage, illegalLabel, illegalExpendImageView, illegalButton)
        badMannersView.addSubviews(badMannersCheckMarkImage, badMannersLabel, badMannersExpendImageView, badMannersButton)
        harmfulnessView.addSubviews(harmfulnessCheckMarkImage, harmfulnessLabel, harmfulnessExpendImageView, harmfulnessButton)
        privacyView.addSubviews(privacyCheckMarkImage, privacyLabel, privacyExpendImageView, privacyButton)
        otherView.addSubviews(otherCheckMarkImage, otherLabel, otherExpendImageView, otherButton)
    }
    
    private func configureConstraints() {
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(32)
            $0.horizontalEdges.equalToSuperview().inset(24)
        }
        itemStackView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(30)
            $0.horizontalEdges.equalToSuperview().inset(24)
        }
        
        [spamView, abuseView, illegalView, badMannersView,
            harmfulnessView, privacyView, otherView
        ].forEach {
            $0.snp.makeConstraints { make in
                make.height.equalTo(44)
            }
        }
        
        [spamCheckMarkImage,
         abuseCheckMarkImage,
         illegalCheckMarkImage,
         badMannersCheckMarkImage,
         harmfulnessCheckMarkImage,
         privacyCheckMarkImage,
         otherCheckMarkImage]
            .forEach {
                $0.snp.makeConstraints { make in
                    make.leading.equalToSuperview()
                    make.centerY.equalToSuperview()
                }
            }
        
        [spamLabel, abuseLabel, illegalLabel, badMannersLabel,
         harmfulnessLabel, privacyLabel, otherLabel]
            .forEach {
                $0.snp.makeConstraints { make in
                    make.leading.equalToSuperview().offset(30)
                    make.centerY.equalToSuperview()
                    
                }
            }
        [spamExpendImageView, abuseExpendImageView, illegalExpendImageView, badMannersExpendImageView,
         harmfulnessExpendImageView, privacyExpendImageView, otherExpendImageView]
            .forEach {
                $0.snp.makeConstraints { make in
                    make.trailing.equalToSuperview()
                    make.centerY.equalToSuperview()
                }
            }
        [spamButton, abuseButton, illegalButton, badMannersButton, harmfulnessButton, privacyButton, otherButton]
            .forEach {
                $0.snp.makeConstraints { make in make.edges.equalToSuperview() }
            }
        
        nextButton.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(16)
            $0.height.equalTo(55)
        }
    }
    
    private func configureNavigation() {
        configureBackbarButton()
        title = "신고하기"
    }
    
    private func bind() {
        viewModel.$isChecked
            .sink { [weak self] isChecked in
                self?.nextButton.setNextButton(isSelected: isChecked)
            }.store(in: &subscriptions)
    }
    
    @objc
    private func itemTapped(_ sender: UIButton) {
        let tag = sender.tag
        let itemCheckMark = [
            spamCheckMarkImage, abuseCheckMarkImage, illegalCheckMarkImage, badMannersCheckMarkImage,
            harmfulnessCheckMarkImage, privacyCheckMarkImage, otherCheckMarkImage
        ]
        let selectedImage = itemCheckMark[tag]
        selectedImage.isSelected.toggle()
        viewModel.isCheckReport(tag: itemCheckMark.filter { $0.isSelected }.map { $0.tag })
    }
    
    @objc
    private func nextButtonTouchUpInside() {
        let detailViewController = ReportDetailViewController()
        navigationController?.pushViewController(detailViewController, animated: true)
    }
    
}
