//
//  LostItemViewController.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/07/31.
//

import UIKit

final class LostItemViewController: UIViewController {
    
    // MARK: - UI properties
    
    private let topView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private let filterStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 12
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private let lostedDateView: UIView = {
        let view = UIView()
        view.backgroundColor = .hexF5F6F8
        view.layer.cornerRadius = 8
        view.layer.borderColor = UIColor.hex828996?.cgColor
        return view
    }()
    
    private let categoryView: UIView = {
        let view = UIView()
        view.backgroundColor = .hexF5F6F8
        view.layer.cornerRadius = 8
        view.layer.borderColor = UIColor.hex828996?.cgColor
        return view
    }()
    
    private let lostedButton = UIButton()
    private let categoryButton = UIButton()
    
    private let lostedLabel: UILabel = {
        let label = UILabel()
        label.text = "잃어버린 날짜"
        label.font = .body3
        label.textColor = .hexBEC2CA
        return label
    }()
    
    private let cateogyLabel: UILabel = {
        let label = UILabel()
        label.text = "물건 분류"
        label.font = .body3
        label.textColor = .hexBEC2CA
        return label
    }()
    
    private let lostedExpandImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: ImageNamespace.expandBottomArrow)
        return imageView
    }()
    
    private let categoryExpandImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: ImageNamespace.expandBottomArrow)
        return imageView
    }()
    
    private lazy var calendarView: CalendarView = {
        let calendarView = CalendarView(isSectableDates: [Date()])
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
    
    // MARK: - Lifecycles
    
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
        view.addSubviews(topView, calendarView)
        topView.addSubviews(filterStackView)
        filterStackView.addArrangedSubviews(lostedDateView, categoryView)
        lostedDateView.addSubviews(lostedButton, lostedLabel, lostedExpandImageView)
        categoryView.addSubviews(categoryButton, cateogyLabel, categoryExpandImageView)
    }
    
    private func configureConstraints() {
        topView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(74)
        }
        filterStackView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(24)
        }
        lostedDateView.snp.makeConstraints {
            $0.height.equalTo(42)
        }
        lostedButton.snp.makeConstraints { $0.edges.equalToSuperview() }
        categoryButton.snp.makeConstraints { $0.edges.equalToSuperview() }
        categoryView.snp.makeConstraints {
            $0.height.equalTo(42)
        }
        lostedLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(12)
        }
        lostedExpandImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-8)
        }
        cateogyLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(12)
        }
        categoryExpandImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-8)
        }
        calendarView.snp.makeConstraints {
            $0.top.equalTo(topView.snp.bottom)
            $0.horizontalEdges.equalToSuperview().inset(24)
        }
    }
    
    private func configureNavigation() {
        title = "분실물 찾기"
        let searchBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "magnifyingglass"),
            style: .plain,
            target: self,
            action: nil
        )
        searchBarButtonItem.tintColor = .black
        navigationItem.rightBarButtonItem = searchBarButtonItem
        configureBackbarButton()
    }
    
    private func addTargets() {
        lostedButton.addTarget(self, action: #selector(dateButtonTouchUpInside), for: .touchUpInside)
        categoryButton.addTarget(self, action: #selector(categoryButtonTouchUpInside), for: .touchUpInside)
    }
    
    @objc
    private func dateButtonTouchUpInside() {
        calendarView.isHidden = false
        lostedDateView.layer.borderWidth = 1
    }
    
    @objc
    private func categoryButtonTouchUpInside() {
        print("categoryTapped")
    }
}

extension LostItemViewController: CalendarViewDelegate {
    func selectedCalendar(date: Date) {
        calendarView.isHidden = true
        lostedDateView.layer.borderWidth = 0
        lostedLabel.text = date.convertToYearMonthDayString()
        lostedLabel.textColor = .body1
        
    }
}
