//
//  PartyMemberRecruitingDateViewController.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/07/13.
//

import UIKit
import Combine

final class PartyMemberRecruitingDateViewController: UIViewController {
    
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
        label.textColor = .pointColor1
        label.text = "Step 2"
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        return label
    }()
    
    private let step3Label: UILabel = {
        let label = UILabel()
        label.textColor = .hexE4E7EC
        label.text = "Step 3"
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
        view.backgroundColor = .pointColor1
        return view
    }()
    
    private let step3View: UIView = {
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
        label.text = partyType.title
        label.textColor = .white
        label.font = .systemFont(ofSize: 12, weight: .medium)
        return label
    }()
    
    private let dateSelectLabel: UILabel = {
        let label = UILabel()
        label.text = "공연 날짜를 선택해주세요."
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
        button.contentHorizontalAlignment = .left
        button.titleEdgeInsets = .init(top: 0, left: 18, bottom: 0, right: 0)
        return button
    }()
    
    private let timeSelectLabel: UILabel = {
        let label = UILabel()
        label.text = "시간대를 선택해주세요."
        label.textColor = .hex161A20
        label.font = .subTitle2
        return label
    }()
    
    private let timeEssentialLabel: UILabel = {
        let label = UILabel()
        label.text = "필수"
        label.textAlignment = .center
        label.textColor = .pointColor2
        label.layer.borderColor = UIColor.pointColor2?.cgColor
        label.layer.borderWidth = 1
        label.layer.cornerRadius = 11
        label.font = .systemFont(ofSize: 13, weight: .medium)
        return label
    }()
    
    private let timeSelectButton: UIButton = {
        let button = UIButton()
        button.setTitle("시간대를 선택해주세요.", for: .normal)
        button.setTitleColor(.hex828996, for: .normal)
        button.backgroundColor = .hexF5F6F8
        button.titleLabel?.font = .body2
        button.layer.cornerRadius = 10
        button.contentHorizontalAlignment = .left
        button.titleEdgeInsets = .init(top: 0, left: 18, bottom: 0, right: 0)
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
    
    private let nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("다음", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .medium)
        button.backgroundColor = .hexE4E7EC
        button.setTitleColor(.hexBEC2CA, for: .normal)
        button.layer.cornerRadius = 12
        button.isUserInteractionEnabled = false
        return button
    }()
    
    private lazy var calendarView: CalendarView = {
//        let calendarView = CalendarView(isSectableDates: product.date)
        let calendarView = CalendarView(
            isSectableDates: Date.getDuringDate(start: product.startDate, end: product.endDate)
        )
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
    
    // MARK: - Properties
    
    private let partyType: PartyCategoryType
    private let viewModel: PartyMemberRecruitingDateViewModel
    private let product: ProductListContentHaveSelected
    private var cancellabels: Set<AnyCancellable> = []
    private var dateDict: [String: [String]] = [:]
    private var selectDate: Date?
    private var selectTime: String?
    
    
    // MARK: - Lifecycles
    
    init(
        partyType: PartyCategoryType,
        viewModel: PartyMemberRecruitingDateViewModel,
        product: ProductListContentHaveSelected
    ) {
        self.partyType = partyType
        self.viewModel = viewModel
        self.product = product
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
             dateEssentialLabel, dateSelectButton, nextButton, timeSelectLabel,
            timeEssentialLabel, timeSelectButton, countSelectLabel,
            countEssentialLabel, countStackView, calendarView
        )
        stepLabelStackView.addArrangedSubviews(step1Label, step2Label, step3Label)
        stepViewStackView.addArrangedSubviews(step1View, step2View, step3View)
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
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.top.equalTo(dateSelectLabel.snp.bottom).offset(10)
            $0.height.equalTo(42)
        }
        
        timeSelectLabel.snp.makeConstraints {
            $0.top.equalTo(dateSelectButton.snp.bottom).offset(40)
            $0.leading.equalToSuperview().offset(24)
        }
        timeEssentialLabel.snp.makeConstraints {
            $0.centerY.equalTo(timeSelectLabel)
            $0.trailing.equalToSuperview().inset(24)
            $0.width.equalTo(40)
            $0.height.equalTo(22)
        }
        timeSelectButton.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.top.equalTo(timeSelectLabel.snp.bottom).offset(10)
            $0.height.equalTo(42)
        }
        countSelectLabel.snp.makeConstraints {
            $0.top.equalTo(timeSelectButton.snp.bottom).offset(40)
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
        
        nextButton.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.height.equalTo(55)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(16)
        }
        calendarView.snp.makeConstraints {
            $0.top.equalTo(dateSelectButton.snp.bottom).offset(10)
            $0.horizontalEdges.equalToSuperview().inset(24)
        }
    }
    
    private func configureNavigation() {
        configureBackbarButton()
        title = "파티원 모집"
    }
    
    private func bind() {
        viewModel.$countValue
            .receive(on: DispatchQueue.main)
            .sink { [weak self] value in
                self?.countLabel.text = "\(value)"
            }.store(in: &cancellabels)
        
        viewModel.selectedDate
            .receive(on: DispatchQueue.main)
            .sink { [weak self] date in
                guard let date else {
                    self?.setNextButton(isSelected: false)
                    return
                }
                self?.setNextButton(isSelected: true)
            }.store(in: &cancellabels)
    }
    
    private func setNextButton(isSelected: Bool) {
        nextButton.backgroundColor = isSelected ? .pointColor2 : .hexE4E7EC
        nextButton.setTitleColor(
            isSelected ? .white : .hexBEC2CA,
            for: .normal
        )
        nextButton.isUserInteractionEnabled = isSelected
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
        timeSelectButton.addTarget(
            self,
            action: #selector(timeSelectButtonTouchUpInside),
            for: .touchUpInside
        )
        nextButton.addTarget(
            self,
            action: #selector(nextButtonTouchUpInside),
            for: .touchUpInside
        )
    }
    
    private func configureTimeSelectView(times: [String]) {
        let timeSelectView: TimeSelectView = {
            let view = TimeSelectView(times: times)
            view.tag = 100
            view.layer.applySketchShadow(color: .black, alpha: 0.25, x: 0, y: 4, blur: 4, spread: 0)
            view.delegate = self
            return view
        }()
        view.addSubview(timeSelectView)
        timeSelectButton.isUserInteractionEnabled = false
        timeSelectView.snp.makeConstraints {
            $0.top.equalTo(timeSelectButton.snp.bottom).offset(10)
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.height.equalTo(min(60 * times.count, 180))
        }
        
    }
    
    // MARK: - Actions
    
    @objc
    private func dateSelectButtonTouchUpInside() {
        calendarView.isHidden = false
        let viewWithTag = view.viewWithTag(100)
        viewWithTag?.removeFromSuperview()
        timeSelectButton.setTitle("시간대를 선택해주세요.", for: .normal)
        viewModel.isValidDate(
            date: dateSelectButton.titleLabel?.text,
            time: timeSelectButton.titleLabel?.text
        )
    }
    
    @objc
    private func timeSelectButtonTouchUpInside() {
        guard let selectDate else {
            return
        }
        let weekDay = selectDate.convertToWeekend()
        var times: [String] = []
        product.showTimes.forEach {
            if $0.dayOfWeek == weekDay {
                let time = $0.time.split(separator: ":").map { String($0) }
                times.append("\(time[0]):\(time[1])")
            }
        }
        times = times.sorted(by: <)
        calendarView.isHidden = true
        configureTimeSelectView(times: times)
        viewModel.isValidDate(
            date: dateSelectButton.titleLabel?.text,
            time: timeSelectButton.titleLabel?.text
        )
    }
    
    @objc
    private func stepperButtonTouchUpInside(_ sender: UIButton) {
        viewModel.countValueChanged(sender.tag)
    }
    
    @objc
    private func nextButtonTouchUpInside() {
        guard let selectDate, let selectTime, let count = countLabel.text else { return }
        let showAt = selectDate.convertToAPIDateYearMonthDayString() + "T" + selectTime + ":00"
        let step3ViewController = PartyMemberRecruitingContentViewController(
            partyType: partyType,
            product: product,
            showAt: showAt,
            maxMemberNumber: Int(count) ?? 1,
            viewModel: PartyMemberRecruitingContentViewModel()
        )
        navigationController?.pushViewController(step3ViewController, animated: true)
    }
}

extension PartyMemberRecruitingDateViewController: CalendarViewDelegate {
    func selectedCalendar(date: Date) {
        calendarView.isHidden = true
        dateSelectButton.setTitle(date.convertToYearMonthDayKoreanString(), for: .normal)
        selectDate = date
        selectTime = nil
        viewModel.isValidDate(
            date: dateSelectButton.titleLabel?.text,
            time: timeSelectButton.titleLabel?.text
        )
        timeSelectButton.isUserInteractionEnabled = true
    }
}

extension PartyMemberRecruitingDateViewController: TimeSelectViewDelegate {
    func selectedTime(time: String) {
        timeSelectButton.setTitle(time, for: .normal)
        let viewWithTag = view.viewWithTag(100)
        viewWithTag?.removeFromSuperview()
        selectTime = time
        viewModel.isValidDate(
            date: dateSelectButton.titleLabel?.text,
            time: timeSelectButton.titleLabel?.text
        )
        timeSelectButton.isUserInteractionEnabled = true
    }
}
