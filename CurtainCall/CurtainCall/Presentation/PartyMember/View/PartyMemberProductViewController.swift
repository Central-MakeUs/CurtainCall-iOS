//
//  PartyMemberProductViewController.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/07/10.
//

import UIKit
import Combine

final class PartyMemberProductViewController: UIViewController {
    
    // MARK: - UI properties
    
    private let guideLabel: UILabel = {
        let label = UILabel()
        label.text = "모든 게시물은 최신순으로 제공됩니다."
        label.font = .body3
        label.textColor = .hex5A6271
        return label
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: createCollectionViewLayout()
        )
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        return collectionView
    }()
    
    private let writeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: ImageNamespace.partymemberWriteButton), for: .normal)
        return button
    }()
    
    private let emptyView: UIView = {
        let view = UIView()
        view.backgroundColor = .hexF5F6F8
        
        let emptyLabel: UILabel = {
            let label = UILabel()
            label.text = "모집 중인 파티원이 없어요!"
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
    
    // MARK: - Properties
    
    private enum Section { case main }
    typealias Item = PartyListContent
    
    private let viewModel: PartyMemberProductViewModel
    private let partyType: PartyCategoryType
    private var cancellables = Set<AnyCancellable>()
    private var dataSource: UICollectionViewDiffableDataSource<Section, Item>?
    private var snapshot: NSDiffableDataSourceSnapshot<Section, Item>?
    
    
    // MARK: - Lifecycles
    
    init(partyType: PartyCategoryType, viewModel: PartyMemberProductViewModel) {
        self.partyType = partyType
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
        addTarget()
        bind()
        viewModel.requestPartyProductInfo(page: 0, size: 20, category: partyType)
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
        view.backgroundColor = .hexF5F6F8
        view.addSubviews(emptyView, guideLabel, collectionView, writeButton)
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
        emptyView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func configureNavigation() {
        title = partyType.title
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
            action: #selector(searchButtonTapped)
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
            PartyProductCell.self,
            forCellWithReuseIdentifier: PartyProductCell.identifier
        )
    }
    
    private func configureDatasource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Item>(
            collectionView: collectionView,
            cellProvider: { collectionView, indexPath, item in
                guard let cell = collectionView.dequeueCell(
                    type: PartyProductCell.self,
                    indexPath: indexPath
                ) else { return UICollectionViewCell() }
                cell.setUI(item)
                return cell
            }
        )
    }
    
    private func configureSnapshot() {
        
        
    }
    
    private func bind() {
        viewModel.$productInfoData
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                if case let .failure(error) = completion {
                    print(error.localizedDescription)
                    self?.emptyView.isHidden = false
                    self?.guideLabel.isHidden = true
                }
            } receiveValue: { [weak self] item in
                guard let self else { return }
                if item.isEmpty {
                    emptyView.isHidden = false
                    guideLabel.isHidden = true
                } else {
                    var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
                    snapshot.deleteAllItems()
                    snapshot.appendSections([.main])
                    snapshot.appendItems(item, toSection: .main)
                    dataSource?.apply(snapshot)
                    emptyView.isHidden = true
                    guideLabel.isHidden = false
                    viewModel.isLoding = false
                }
            }.store(in: &cancellables)

    }
    
    private func addTarget() {
        writeButton.addTarget(
            self,
            action: #selector(writeButtonTouchUpInside),
            for: .touchUpInside
        )
    }
    
    // MARK: - Actions
    
    @objc
    private func backBarbuttonTapped() {
        dismiss(animated: true)
    }
    
    @objc
    private func writeButtonTouchUpInside() {
        moveToWriteView()
    }
    
    @objc
    private func searchButtonTapped() {
        let searchViewController = PartyMemberSearchViewController(partyType: partyType)
        navigationController?.pushViewController(searchViewController, animated: true)
    }
    
    private func moveToWriteView() {
        configureBackbarButton()
        let writeViewController = PartyMemberRecruitingProductViewController(
            partyType: partyType,
            viewModel: PartyMemberRecruitingProductViewModel()
        )
        navigationController?.pushViewController(writeViewController, animated: true)
    }
}

extension PartyMemberProductViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let dataSource, let item = dataSource.itemIdentifier(for: indexPath) else {
            return
        }
        let detailViewController = PartyMemberRecruitingDetailViewController(id: item.id,
            partyType: partyType)
        navigationController?.pushViewController(detailViewController, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row > (viewModel.page + 1) * 20 - 3 {
            if !viewModel.isLoding {
                viewModel.isLoding = true
                viewModel.requestPartyProductInfo(page: viewModel.page + 1, size: 20, category: partyType)
                viewModel.page += 1
            }
        }
    }
}
