//
//  CalendarView.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/07/13.
//

import UIKit

final class CalendarView: UIView, CalendarDelegate {
    
    // MARK: - UI properties
    
    private let headerView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let headerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 14
        return stackView
    }()
    
    private let prevButton: UIButton = {
        let button = UIButton()
        button.tintColor = .pointColor2
        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        button.tag = -1
        button.contentEdgeInsets = .init(top: 20, left: 20, bottom: 20, right: 20)
        return button
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .subTitle2
        return label
    }()
    
    private let nextButton: UIButton = {
        let button = UIButton()
        button.tintColor = .pointColor2
        button.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        button.tag = 1
        button.contentEdgeInsets = .init(top: 20, left: 20, bottom: 20, right: 20)
        return button
    }()
    
    private let checkButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.pointColor2, for: .normal)
        button.setTitle("확인", for: .normal)
        button.titleLabel?.font = .body3
        button.layer.cornerRadius = 11.5
        button.layer.borderColor = UIColor.pointColor2?.cgColor
        button.layer.borderWidth = 1
        return button
    }()
    
    private let borderView: UIView = {
        let view = UIView()
        view.backgroundColor = .hexF2F3F5
        return view
    }()
    
    private let weekStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private let weekLabels: [UILabel] = {
        var labels: [UILabel] = []
        for week in "일월화수목금토".map({ String($0) }) {
            let label = UILabel()
            label.textColor = .hex3B4350
            label.textAlignment = .center
            label.text = week
            labels.append(label)
        }
        return labels
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.delegate = self
        collectionView.isScrollEnabled = false
        return collectionView
    }()
    
    // MARK: - Properties
    
    enum Section { case main }
    struct Item: Hashable {
        let id = UUID()
        let date: Date?
        let isSunday: Bool
        let isSaturday: Bool
        let isSelected: Bool
        let isSelectable: Bool
    }
    
    private var dataSource: UICollectionViewDiffableDataSource<Section, Item>?
    private var date = Date()
    private var days: [Item] = []
    private var calendar = Calendar.current
    private var dateComponents = DateComponents()
    private let isSectableDates: [Date]
    private var selectedDate: Date?
    private let dateDict: [String: [String]]
    weak var delegate: CalendarViewDelegate?
    
    // MARK: - Lifecycles
    
    init(isSectableDates: [Date]) {
        self.isSectableDates = isSectableDates
        self.dateDict = isSectableDates.convertToYearMonthDayKeyHourValue()
        super.init(frame: .zero)
        configureUI()
        registerCell()
    }
    
    @available (*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    private func configureUI() {
        configureSubviews()
        configureConstraints()
        configureDatasoruce()
        setCalendar(date: date)
        addTarget()
        print(dateDict)
    }
    
    private func configureSubviews() {
        backgroundColor = .white
        dateLabel.text = date.convertToYearMonthKoreanString()
        addSubviews(headerView, borderView, weekStackView, collectionView)
        headerView.addSubviews(headerStackView, checkButton)
        headerStackView.addArrangedSubviews(prevButton, dateLabel, nextButton)
        weekLabels.forEach { weekStackView.addArrangedSubview($0) }
    }
    
    private func configureConstraints() {
        headerView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(67)
        }
        headerStackView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview()
        }
        checkButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(20)
            $0.width.equalTo(50)
            $0.height.equalTo(23)
        }
        borderView.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.bottom)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(1)
        }
        weekStackView.snp.makeConstraints {
            $0.top.equalTo(borderView.snp.bottom).offset(16)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(25)
        }
        collectionView.snp.makeConstraints {
            $0.top.equalTo(weekStackView.snp.bottom).offset(16)
            $0.height.equalTo(240)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1/7),
            heightDimension: .fractionalHeight(1)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .absolute(40)
        )
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
//        section.interGroupSpacing =
        return UICollectionViewCompositionalLayout(section: section)
    }
    
    private func registerCell() {
        collectionView.register(
            CalendarCell.self,
            forCellWithReuseIdentifier: CalendarCell.identifier
        )
    }
    
    private func addTarget() {
        [prevButton, nextButton].forEach {
            $0.addTarget(
                self,
                action: #selector(monthMoveButtonTouchUpInside),
                for: .touchUpInside
            )
        }
        checkButton.addTarget(
            self,
            action: #selector(checkButtonTouchUpInside),
            for: .touchUpInside
        )
    }
    
    private func configureDatasoruce() {
        dataSource = UICollectionViewDiffableDataSource<Section, Item>(
            collectionView: collectionView,
            cellProvider: { collectionView, indexPath, item in
                guard let cell = collectionView.dequeueCell(
                    type: CalendarCell.self, indexPath: indexPath) else {
                    return UICollectionViewCell()
                }
                cell.configureUI(item)
                return cell
            })
    }
    
    private func configureSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections([.main])
        snapshot.appendItems(days, toSection: .main)
        dataSource?.apply(snapshot)
    }
    
    private func setCalendar(date: Date) {
        days.removeAll()
        let calendar = Calendar.current
        var dateComponents = DateComponents()
        
        dateComponents.year = calendar.component(.year, from: date)
        dateComponents.month = calendar.component(.month, from: date)
        guard let firstDayOfMonth = calendar.date(from: dateComponents) else { return }
        
        let firstWeekIndex = calendar.component(.weekday, from: firstDayOfMonth) - 1
        let endDay = calendar.range(of: .day, in: .month, for: date)?.count ?? 31
        let totalDays = firstWeekIndex + endDay
        
        for day in 0..<totalDays {
            if day < firstWeekIndex {
                days.append(Item(
                    date: nil,
                    isSunday: false,
                    isSaturday: false,
                    isSelected: false,
                    isSelectable: false
                ))
            } else {
                dateComponents.day = day - firstWeekIndex + 1
                guard let date = calendar.date(from: dateComponents) else { return }
                days.append(Item(
                    date: date,
                    isSunday: day % 7 == 0,
                    isSaturday: day % 7 == 6,
                    isSelected: selectedDate == date,
                    isSelectable: dateDict[date.convertToYearMonthDayString()] != nil || isSectableDates.isEmpty
                )
                )
            }
        }
        configureSnapshot()
        configureHeight(dayCount: totalDays)
    }
    
    private func configureHeight(dayCount: Int) {
        collectionView.snp.updateConstraints {
                $0.height.equalTo(dayCount > 35 ? 250 : 210)
        }
    }
    
    @objc
    private func monthMoveButtonTouchUpInside(_ sender: UIButton) {
        if let newDate = Calendar.current.date(
            byAdding: DateComponents(month: sender.tag),
            to: date
        ) {
            date = newDate
            setCalendar(date: date)
            dateLabel.text = date.convertToYearMonthKoreanString()
        }
    }
    
    @objc
    private func checkButtonTouchUpInside() {
        guard let selectedDate else { return }
        delegate?.selectedCalendar(date: selectedDate)
    }
}

extension CalendarView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let dataSource,
            let item = dataSource.itemIdentifier(for: indexPath),
              let date = item.date
        else { return }
        if !isSectableDates.isEmpty && dateDict[date.convertToYearMonthDayString()] == nil {
            return
        }
        selectedDate = date
        days = days.map { Item(
            date: $0.date,
            isSunday: $0.isSunday,
            isSaturday: $0.isSaturday,
            isSelected: $0.date == date,
            isSelectable: $0.isSelectable
        )}
        configureSnapshot()
    }
}
