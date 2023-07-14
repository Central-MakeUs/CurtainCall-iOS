//
//  PartyMemberRecruitingDateViewController.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/07/13.
//

import UIKit

final class PartyMemberRecruitingDateViewController: UIViewController {
    
    // MARK: - UI properties
    
    private let step1Label: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(rgb: 0x273041)
        label.text = "Step 1"
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        return label
    }()
    
    private let step2Label: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(rgb: 0x273041)
        label.text = "Step 2"
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        return label
    }()
    
    private let step3Label: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(rgb: 0xE1E4E9)
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
        view.backgroundColor = UIColor(rgb: 0x273041)
        view.layer.cornerRadius = 4
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        
        return view
    }()
    
    private let step2View: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(rgb: 0x273041)
        return view
    }()
    
    private let step3View: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(rgb: 0xE1E4E9)
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
        view.backgroundColor = UIColor(rgb: 0x273041)
        view.layer.cornerRadius = 12
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "공연 관람"
        label.textColor = .white
        label.font = .systemFont(ofSize: 12, weight: .medium)
        return label
    }()
    
    private let dateSelectLabel: UILabel = {
        let label = UILabel()
        label.text = "공연 날짜를 선택해주세요."
        label.textColor = UIColor(rgb: 0x273041)
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    private let dateEssentialLabel: UILabel = {
        let label = UILabel()
        label.text = "필수"
        label.textAlignment = .center
        label.textColor = UIColor(rgb: 0xFF5792)
        label.layer.borderColor = UIColor(rgb: 0xFF5792).cgColor
        label.layer.borderWidth = 1
        label.layer.cornerRadius = 11
        label.font = .systemFont(ofSize: 13, weight: .medium)
        return label
    }()
    
    private let dateSelectButton: UIButton = {
        let button = UIButton()
        button.setTitle("날짜를 선택해주세요.", for: .normal)
        button.setTitleColor(UIColor(rgb: 0x999999), for: .normal)
        button.backgroundColor = UIColor(rgb: 0xF5F6F8)
        button.titleLabel?.font = .systemFont(ofSize: 15)
        button.layer.cornerRadius = 10
        button.contentHorizontalAlignment = .left
        button.titleEdgeInsets = .init(top: 0, left: 18, bottom: 0, right: 0)
        return button
    }()
    
    private let timeSelectLabel: UILabel = {
        let label = UILabel()
        label.text = "시간대를 선택해주세요."
        label.textColor = UIColor(rgb: 0x273041)
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    private let timeEssentialLabel: UILabel = {
        let label = UILabel()
        label.text = "필수"
        label.textAlignment = .center
        label.textColor = UIColor(rgb: 0xFF5792)
        label.layer.borderColor = UIColor(rgb: 0xFF5792).cgColor
        label.layer.borderWidth = 1
        label.layer.cornerRadius = 11
        label.font = .systemFont(ofSize: 13, weight: .medium)
        return label
    }()
    
    private let timeSelectButton: UIButton = {
        let button = UIButton()
        button.setTitle("시간대를 선택해주세요.", for: .normal)
        button.setTitleColor(UIColor(rgb: 0x999999), for: .normal)
        button.backgroundColor = UIColor(rgb: 0xF5F6F8)
        button.titleLabel?.font = .systemFont(ofSize: 15)
        button.layer.cornerRadius = 10
        button.contentHorizontalAlignment = .left
        button.titleEdgeInsets = .init(top: 0, left: 18, bottom: 0, right: 0)
        return button
    }()
    
    private let countSelectLabel: UILabel = {
        let label = UILabel()
        label.text = "인원을 선택해주세요."
        label.textColor = UIColor(rgb: 0x273041)
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    private let countEssentialLabel: UILabel = {
        let label = UILabel()
        label.text = "필수"
        label.textAlignment = .center
        label.textColor = UIColor(rgb: 0xFF5792)
        label.layer.borderColor = UIColor(rgb: 0xFF5792).cgColor
        label.layer.borderWidth = 1
        label.layer.cornerRadius = 11
        label.font = .systemFont(ofSize: 13, weight: .medium)
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
        button.tintColor = UIColor(rgb: 0x111111)
        button.backgroundColor = UIColor(rgb: 0xF5F6F8)
        return button
    }()
    private let plusButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.tintColor = UIColor(rgb: 0x111111)
        button.backgroundColor = UIColor(rgb: 0xF5F6F8)
        return button
    }()
    
    private let countLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(rgb: 0x111111)
        label.text = "1"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    private let nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("다음", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .medium)
        button.backgroundColor = UIColor(rgb: 0xDCDEE1)
        button.setTitleColor(UIColor(rgb: 0x99A1B2), for: .normal)
        button.layer.cornerRadius = 12
        button.isUserInteractionEnabled = false
        return button
    }()
    
    private lazy var calendarView: CalendarView = {
        let calendarView = CalendarView(isSectableDates: product.date)
        calendarView.layer.cornerRadius = 10
        calendarView.isHidden = true
        calendarView.delegate = self
        return calendarView
    }()
    
    // MARK: - Properties
    
    private let product: ProductSelectInfo
    
    // MARK: - Lifecycles
    
    init(product: ProductSelectInfo) {
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
            $0.bottom.equalTo(nextButton.snp.top).offset(-15)
        }
    }
    
    private func configureNavigation() {
        configureBackbarButton()
        title = "파티원 모집"
    }
    
    private func setNextButton(isSelected: Bool) {
        nextButton.backgroundColor = isSelected ? UIColor(rgb: 0xFF7CAB) : UIColor(rgb: 0xDCDEE1)
        nextButton.setTitleColor(
            isSelected ? .white : UIColor(rgb: 0x99A1B2),
            for: .normal
        )
        nextButton.isUserInteractionEnabled = isSelected
    }
    
    private func addTargets() {
        dateSelectButton.addTarget(
            self,
            action: #selector(dateSelectButtonTouchUpInside),
            for: .touchUpInside
        )
    }
    
    // MARK: - Actions
    
    @objc
    func dateSelectButtonTouchUpInside() {
        calendarView.isHidden = false
    }
}

extension PartyMemberRecruitingDateViewController: CalendarViewDelegate {
    func selectedCalendar(date: Date) {
        calendarView.isHidden = true
        dateSelectButton.setTitle(date.convertToYearMonthDayKoreanString(), for: .normal)
    }
}
