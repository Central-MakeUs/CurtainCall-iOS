//
//  PartyMemberFoodViewController.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/07/11.
//

import UIKit
import Combine

final class PartyMemberFoodViewController: UIViewController {
    
    // MARK: - UI properties
    
    private let guideLabel: UILabel = {
        let label = UILabel()
        label.text = "모든 게시물은 최신순으로 제공됩니다."
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = UIColor(rgb: 0x717A90)
        return label
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: createCollectionViewLayout()
        )
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    private let writeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: ImageNamespace.partymemberWriteButton), for: .normal)
        return button
    }()
    
    // MARK: - Properties
    
    private enum Section { case main }
    typealias Item = FoodPartyInfo
    
    private let viewModel: PartyMemberFoodViewModel
    private var cancellables = Set<AnyCancellable>()
    private var dataSource: UICollectionViewDiffableDataSource<Section, Item>?
    private var snapshot: NSDiffableDataSourceSnapshot<Section, Item>?
    
    // MARK: - Lifecycles
    
    init(viewModel: PartyMemberFoodViewModel) {
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
        registerCell()
        bind()
        viewModel.requestPartyFoodInfo()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavigation()
    }
    
    // MARK: - Helpers
    
    private func configureUI() {
        configureSubviews()
        configureConstraints()
        configureNavigation()
        configureDatasource()
        configureSnapshot()
    }
    
    private func configureSubviews() {
        view.backgroundColor = UIColor(rgb: 0xF5F6F8)
        view.addSubviews(guideLabel, collectionView, writeButton)
    }
    
    private func configureConstraints() {
        guideLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(40)
            $0.leading.equalToSuperview().offset(24)
        }
        collectionView.snp.makeConstraints {
            $0.top.equalTo(guideLabel.snp.bottom).offset(18)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        writeButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-60)
            $0.trailing.equalToSuperview().offset(-24)
        }
    }
    
    private func configureNavigation() {
        title = "식사/카페"
        let leftBarbuttonItem = UIBarButtonItem(
            image: UIImage(named: ImageNamespace.navigationBackButton),
            style: .plain,
            target: self,
            action: #selector(backBarbuttonTapped)
        )
        let searchBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "magnifyingglass"),
            style: .plain,
            target: self,
            action: nil
        )
        leftBarbuttonItem.tintColor = .black
        searchBarButtonItem.tintColor = .black
        navigationItem.leftBarButtonItem = leftBarbuttonItem
        navigationItem.rightBarButtonItem = searchBarButtonItem
    }
    
    private func createCollectionViewLayout() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .estimated(250)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .estimated(250)
        )
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        group.edgeSpacing = .init(leading: nil, top: nil, trailing: nil, bottom: .fixed(20))
        let section = NSCollectionLayoutSection(group: group)
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.scrollDirection = .vertical
        return UICollectionViewCompositionalLayout(section: section, configuration: config)
    }
    
    private func registerCell() {
        collectionView.register(
            PartyFoodCell.self,
            forCellWithReuseIdentifier: PartyFoodCell.identifier
        )
    }
    
    private func configureDatasource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Item>(
            collectionView: collectionView,
            cellProvider: { collectionView, indexPath, item in
                guard let cell = collectionView.dequeueCell(
                    type: PartyFoodCell.self,
                    indexPath: indexPath
                ) else { return UICollectionViewCell() }
                cell.setUI(item)
                return cell
            }
        )
    }
    
    private func configureSnapshot() {
        snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot?.appendSections([.main])
    }
    
    private func bind() {
        viewModel.foodInfoData
            .receive(on: DispatchQueue.main)
            .sink { completion in
                if case let .failure(error) = completion {
                    print(error.localizedDescription)
                }
            } receiveValue: { [weak self] item in
                guard var snapshot = self?.snapshot else { return }
                snapshot.appendItems(item, toSection: .main)
                self?.dataSource?.apply(snapshot)
            }.store(in: &cancellables)

    }
    
    // MARK: - Actions
    
    @objc
    private func backBarbuttonTapped() {
        dismiss(animated: true)
    }
}
