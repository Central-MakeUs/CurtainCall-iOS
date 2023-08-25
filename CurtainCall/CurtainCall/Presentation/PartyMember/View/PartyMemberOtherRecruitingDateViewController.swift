//
//  PartyMemberOtherRecruitingDateViewController.swift.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/07/19.
//

import UIKit
import Combine

final class PartyMemberOtherRecruitingDateViewController: UIViewController {
    
    // MARK: - UI properties
    
    private let step1Label: UILabel = {
        let label = UILabel()
        label.textColor = .pointColor1
        label.text = "Step 1"
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        return label
    }()
    
    private let step2Label: UILabel = {
        let label = UILabel()
        label.textColor = .hexE4E7EC
        label.text = "Step 2"
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        return label
    }()
    
    private let stepLabelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    
    private let step1View: UIView = {
        let view = UIView()
        view.backgroundColor = .pointColor1
        view.layer.cornerRadius = 4
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        
        return view
    }()

    private let step2View: UIView = {
        let view = UIView()
        view.backgroundColor = .hexE4E7EC
        view.layer.cornerRadius = 4
        view.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]
        return view
    }()
    
    private let stepViewStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 3
        return stackView
    }()
    
    private let titleView: UIView = {
        let view = UIView()
        view.backgroundColor = .pointColor1
        view.layer.cornerRadius = 12
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "기타"
        label.textColor = .white
        label.font = .body5
        return label
    }()
    
    private let dateSelectLabel: UILabel = {
        let label = UILabel()
        label.text = "날짜를 선택해주세요."
        label.textColor = .hex161A20
        label.font = .subTitle2
        return label
    }()
    
    private let dateEssentialLabel: UILabel = {
        let label = UILabel()
        label.text = "필수"
        label.textAlignment = .center
        label.textColor = .pointColor2
        label.layer.borderColor = UIColor.pointColor2?.cgColor
        label.layer.borderWidth = 1
        label.layer.cornerRadius = 11
        label.font = .body4
        return label
    }()
    
    private let dateSelectButton: UIButton = {
        let button = UIButton()
        button.setTitle("날짜를 선택해주세요.", for: .normal)
        button.setTitleColor(.hex828996, for: .normal)
        button.backgroundColor = .hexF5F6F8
        button.titleLabel?.font = .body2
        button.layer.cornerRadius = 10
        button.layer.borderColor = UIColor.hex828996?.cgColor
        button.layer.borderWidth = 0
        button.contentHorizontalAlignment = .left
        button.titleEdgeInsets = .init(top: 0, left: 18, bottom: 0, right: 0)
        return button
    }()
    private let noDateButton: UIButton = {
        let button = UIButton()
        button.setTitle("날짜 미정", for: .normal)
        button.setTitleColor(.hex828996, for: .normal)
        button.backgroundColor = .hexF5F6F8
        button.titleLabel?.font = .body2
        button.layer.cornerRadius = 10
        return button
    }()
    
    private let countSelectLabel: UILabel = {
        let label = UILabel()
        label.text = "인원을 선택해주세요."
        label.textColor = .hex161A20
        label.font = .subTitle2
        return label
    }()
    
    private let countEssentialLabel: UILabel = {
        let label = UILabel()
        label.text = "필수"
        label.textAlignment = .center
        label.textColor = .pointColor2
        label.layer.borderColor = UIColor.pointColor2?.cgColor
        label.layer.borderWidth = 1
        label.layer.cornerRadius = 11
        label.font = .body4
        return label
    }()
    
    private let countStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.layer.cornerRadius = 10
        stackView.clipsToBounds = true
        return stackView
    }()
    private let minusButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "minus"), for: .normal)
        button.tintColor = .title
        button.backgroundColor = .hexF5F6F8
        button.tag = -1
        return button
    }()
    private let plusButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.tintColor = .title
        button.backgroundColor = .hexF5F6F8
        button.tag = 1
        return button
    }()
    
    private let countLabel: UILabel = {
        let label = UILabel()
        label.textColor = .title
        label.text = "1"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    private lazy var calendarView: CalendarView = {
        let calendarView = CalendarView(isSectableDates: Date.currentTo90Days())
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
    
    private let nextButton: BottomNextButton = {
        let button = BottomNextButton()
        button.setTitle("다음", for: .normal)
        button.isUserInteractionEnabled = false
        return button
    }()
    
    // MARK: - Properties
    
    private let viewModel: PartyMemberOtherRecruitingDateViewModel
    private var cancellables: Set<AnyCancellable> = []
    var selectedDate: Date?
    // MARK: - Lifecycles
    
    init(viewModel: PartyMemberOtherRecruitingDateViewModel) {
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
        addTargets()
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
        view.addSubviews(
            stepLabelStackView, stepViewStackView, titleView, dateSelectLabel,
            dateEssentialLabel, dateSelectButton, noDateButton, countStackView,
            countEssentialLabel, countSelectLabel, calendarView, nextButton
        )
        stepLabelStackView.addArrangedSubviews(step1Label, step2Label)
        stepViewStackView.addArrangedSubviews(step1View, step2View)
        titleView.addSubview(titleLabel)
        countStackView.addArrangedSubviews(minusButton, countLabel, plusButton)
    }
    
    private func configureConstraints() {
        stepLabelStackView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(30)
            $0.horizontalEdges.equalToSuperview().inset(22)
        }
        stepViewStackView.snp.makeConstraints {
            $0.top.equalTo(stepLabelStackView.snp.bottom).offset(4)
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.height.equalTo(8)
        }
        titleView.snp.makeConstraints {
            $0.top.equalTo(stepViewStackView.snp.bottom).offset(24)
            $0.leading.equalToSuperview().offset(24)
        }
        titleLabel.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview().inset(4)
            $0.horizontalEdges.equalToSuperview().inset(12)
        }
        dateSelectLabel.snp.makeConstraints {
            $0.top.equalTo(titleView.snp.bottom).offset(11)
            $0.leading.equalToSuperview().offset(24)
        }
        dateEssentialLabel.snp.makeConstraints {
            $0.centerY.equalTo(dateSelectLabel)
            $0.trailing.equalToSuperview().inset(24)
            $0.width.equalTo(40)
            $0.height.equalTo(22)
        }
        dateSelectButton.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(24)
            $0.top.equalTo(dateSelectLabel.snp.bottom).offset(10)
            $0.height.equalTo(42)
            $0.width.equalToSuperview().multipliedBy(0.57)
        }
        noDateButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(24)
            $0.centerY.equalTo(dateSelectButton)
            $0.height.equalTo(42)
            $0.leading.equalTo(dateSelectButton.snp.trailing).offset(8)
        }
        countSelectLabel.snp.makeConstraints {
            $0.top.equalTo(dateSelectButton.snp.bottom).offset(40)
            $0.leading.equalToSuperview().offset(24)
        }
        countEssentialLabel.snp.makeConstraints {
            $0.centerY.equalTo(countSelectLabel)
            $0.trailing.equalToSuperview().inset(24)
            $0.width.equalTo(40)
            $0.height.equalTo(22)
        }
        countStackView.snp.makeConstraints {
            $0.top.equalTo(countSelectLabel.snp.bottom).offset(10)
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.height.equalTo(42)
        }
        calendarView.snp.makeConstraints {
            $0.top.equalTo(dateSelectButton.snp.bottom).offset(10)
            $0.horizontalEdges.equalToSuperview().inset(24)
        }
        nextButton.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.height.equalTo(55)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(16)
        }
    }
    
    private func configureNavigation() {
        configureBackbarButton()
        title = "파티원 모집"
    }
    
    private func addTargets() {
        [plusButton, minusButton].forEach { $0.addTarget(
            self,
            action: #selector(stepperButtonTouchUpInside),
            for: .touchUpInside
            )
        }
        
        dateSelectButton.addTarget(
            self,
            action: #selector(dateSelectButtonTouchUpInside),
            for: .touchUpInside
        )
        
        noDateButton.addTarget(
            self,
            action: #selector(noDateButtonTouchUpInside),
            for: .touchUpInside
        )

        nextButton.addTarget(
            self,
            action: #selector(nextButtonTouchUpInside),
            for: .touchUpInside
        )
    }
    
    private func bind() {
        viewModel.$countValue
            .receive(on: DispatchQueue.main)
            .sink { [weak self] value in
                self?.countLabel.text = "\(value)"
            }.store(in: &cancellables)
        
        viewModel.selectedDate
            .receive(on: DispatchQueue.main)
            .sink { [weak self] date in
                self?.nextButton.setNextButton(isSelected: true)
            }.store(in: &cancellables)
    }
    
    @objc
    private func dateSelectButtonTouchUpInside() {
        calendarView.isHidden = false
        noDateButton.isSelected = false
        dateSelectButton.isSelected = true
        dateSelectButton.layer.borderWidth = 1
        noDateButton.backgroundColor = .hexF5F6F8
        noDateButton.setTitleColor(.hex828996, for: .normal)
    }
    
    @objc
    private func noDateButtonTouchUpInside() {
        calendarView.isHidden = true
        noDateButton.isSelected = true
        dateSelectButton.isSelected = false
        dateSelectButton.layer.borderWidth = 0
        noDateButton.backgroundColor = .pointColor2
        noDateButton.setTitleColor(.white, for: .normal)
        dateSelectButton.setTitle("날짜를 선택해주세요.", for: .normal)
        viewModel.selectedDate.send(nil)
        selectedDate = nil
    }
    
    
    @objc
    private func stepperButtonTouchUpInside(_ sender: UIButton) {
        viewModel.countValueChanged(sender.tag)
    }
    
    @objc
    private func nextButtonTouchUpInside() {
        let step2ViewController = PartyMemberOtherRecruitingContentViewController(date: selectedDate, count: Int(countLabel.text ?? "") ?? 1,
            viewModel: PartyMemberRecruitingContentViewModel()
        )
        navigationController?.pushViewController(step2ViewController, animated: true)
    }
}

extension PartyMemberOtherRecruitingDateViewController: CalendarViewDelegate {
    func selectedCalendar(date: Date) {
        calendarView.isHidden = true
        viewModel.selectedDate.send(date)
        dateSelectButton.setTitle(date.convertToYearMonthDayKoreanString(), for: .normal)
        selectedDate = date
    }
}
