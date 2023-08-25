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
    
    private let categoryLabel: UILabel = {
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
    
    private lazy var lostItemCategoryView: LostItemLargeCategoryView = {
        let view = LostItemLargeCategoryView()
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
        let calendarView = CalendarView(isSectableDates: [Date()])
        calendarView.isHidden = true
        calendarView.layer.applySketchShadow(
            color: UIColor(rgb: 0x273041),
            alpha: 0.1,
            x: 0,
            y: 10,
            blur: 20,
            spread: 0
        )
        calendarView.layer.cornerRadius = 10
        calendarView.delegate = self
        return calendarView
    }()
    
    private let writeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: ImageNamespace.partymemberWriteButton), for: .normal)
        return button
    }()
    
    private let emptyView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        
        let emptyLabel: UILabel = {
            let label = UILabel()
            label.text = "아직 분실물이 없어요!"
            label.textColor = .hexBEC2CA
            label.font = .body1
            return label
        }()
        
        let emptyImageView = UIImageView(image: UIImage(named: ImageNamespace.lostItemEmptyImage))
        view.addSubviews(emptyImageView, emptyLabel)
        emptyLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        emptyImageView.snp.makeConstraints {
            $0.bottom.equalTo(emptyLabel.snp.top).offset(-18)
            $0.centerX.equalToSuperview()
        }
        view.isHidden = true
        return view
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: createLayout()
        )
        collectionView.backgroundColor = .white
        collectionView.register(
            LostItemCollectionViewCell.self,
            forCellWithReuseIdentifier: LostItemCollectionViewCell.identifier
        )
        collectionView.delegate = self
        return collectionView
    }()
    
    // MARK: - Properties
    enum Section { case main }
    typealias Item = LostItemContent
    typealias Datasource = UICollectionViewDiffableDataSource<Section, Item>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Item>
    
    private var datasource: Datasource?
    private let id: String
    private let name: String

    // MARK: - Lifecycles
    
    init(id: String, name: String) {
        self.id = id
        self.name = name
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        addTargets()
//        requestItem()
    }
    
    // MARK: - Helpers
    
    private func configureUI() {
        configureSubviews()
        configureConstraints()
        configureNavigation()
        configureDatasource()
    }
    
    private func configureSubviews() {
        view.backgroundColor = .white
        view.addSubviews(
            topView, collectionView, emptyView, calendarView, lostItemCategoryView, writeButton, emptyView
        )
        topView.addSubviews(filterStackView)
        filterStackView.addArrangedSubviews(lostedDateView, categoryView)
        lostedDateView.addSubviews(lostedButton, lostedLabel, lostedExpandImageView)
        categoryView.addSubviews(categoryButton, categoryLabel, categoryExpandImageView)
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
        categoryLabel.snp.makeConstraints {
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
        lostItemCategoryView.snp.makeConstraints {
            $0.top.equalTo(topView.snp.bottom)
            $0.horizontalEdges.equalToSuperview().inset(24)
        }
        writeButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-60)
            $0.trailing.equalToSuperview().offset(-24)
        }
        emptyView.snp.makeConstraints {
            $0.top.equalTo(topView.snp.bottom)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        collectionView.snp.makeConstraints {
            $0.top.equalTo(topView.snp.bottom)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview()
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
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1/2),
            heightDimension: .estimated(243)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .estimated(243)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 0, leading: 18, bottom: 0, trailing: 18)
        return UICollectionViewCompositionalLayout(section: section)
    }
    
    private func configureDatasource() {
        datasource = Datasource(
            collectionView: collectionView,
            cellProvider: { collectionView, indexPath, item in
                guard let cell = collectionView.dequeueCell(type: LostItemCollectionViewCell.self, indexPath: indexPath) else {
                    return UICollectionViewCell()
                }
                cell.drawUI(item: item)
                return cell
            }
        )
    }
    
//    private func requestItem() {
//        var snapshot = Snapshot()
//        snapshot.appendSections([.main])
//        snapshot.appendItems(LostItemInfo.list, toSection: .main)
//        datasource?.apply(snapshot)
//    }
    
    private func addTargets() {
        lostedButton.addTarget(
            self,
            action: #selector(dateButtonTouchUpInside),
            for: .touchUpInside
        )
        categoryButton.addTarget(
            self,
            action: #selector(categoryButtonTouchUpInside),
            for: .touchUpInside
        )
        writeButton.addTarget(
            self,
            action: #selector(writeButtonTouchUpInside),
            for: .touchUpInside
        )
    }
    
    @objc
    private func dateButtonTouchUpInside() {
        calendarView.isHidden = false
        lostedDateView.layer.borderWidth = 1
        lostItemCategoryView.isHidden = true
        categoryView.layer.borderWidth = 0
    }
    
    @objc
    private func categoryButtonTouchUpInside() {
        categoryView.layer.borderWidth = 1
        lostedDateView.layer.borderWidth = 0
        calendarView.isHidden = true
        lostItemCategoryView.isHidden = false
    }
    
    @objc
    private func writeButtonTouchUpInside() {
        moveToWriteView()
    }
    
    private func moveToWriteView() {
        // MARK: Case 1
//        let writeViewController = UINavigationController(rootViewController: LostItemWriteViewController())
//        writeViewController.modalPresentationStyle = .overFullScreen
//        present(writeViewController, animated: true)
//        
        // MARK: Case2
        navigationController?.pushViewController(
            LostItemWriteViewController(
                id: id,
                name: name,
                viewModel: LostItemWriteViewModel()
            ),
            animated: true
        )
    }
}

extension LostItemViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let item = datasource?.itemIdentifier(for: indexPath) else {
            return
        }
        let detailViewController = LostItemDetailViewController(id: 1)
        navigationController?.pushViewController(detailViewController, animated: true)
        
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

extension LostItemViewController: LostItemViewDelegate {
    func didTappedCategoryButton(categoryType: LostItemCategoryType) {
        lostItemCategoryView.isHidden = true
        categoryLabel.text = categoryType.name
        categoryView.layer.borderWidth = 0
        categoryLabel.textColor = .body1
    }
}
