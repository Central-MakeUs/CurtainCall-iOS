//
//  PartyMemberSearchViewController.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/08/29.
//

import UIKit
import Combine

final class PartyMemberSearchViewController: UIViewController {
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: createCollectionViewLayout()
        )
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.register(
            PartyProductCell.self,
            forCellWithReuseIdentifier: PartyProductCell.identifier
        )
        return collectionView
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
    
    private enum Section { case main }
    typealias Item = PartyListContent
    private var subscriptions = Set<AnyCancellable>()
    private var dataSource: UICollectionViewDiffableDataSource<Section, Item>?
    private let viewModel: PartySearchViewModel
    private let partyType: PartyCategoryType
    private var searchString = ""
    
    init(partyType: PartyCategoryType) {
        self.partyType = partyType
        self.viewModel = PartySearchViewModel(partyType: partyType)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardUp), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDown), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func configureUI() {
        configureSubviews()
        configureConstraints()
        configureNavigation()
        configureDatasource()
    }
    
    private func configureSubviews() {
        view.backgroundColor = .hexF5F6F8
        view.addSubviews(emptyView, collectionView)
    }
    
    private func configureConstraints() {
        collectionView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        emptyView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func configureNavigation() {
        configureBackbarButton()
        let searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: view.frame.width - 80, height: 0))
        searchBar.setImage(UIImage(), for: UISearchBar.Icon.search, state: .normal)
        searchBar.placeholder = "작품명 또는 장소 입력"
        searchBar.delegate = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: searchBar)
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
    
    private func bind() {
        viewModel.$partyList
            .debounce(for: .seconds(0.7), scheduler: DispatchQueue.main)
            .sink { [weak self] data in
                guard let self else { return }
                var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
                snapshot.deleteAllItems()
                snapshot.appendSections([.main])
                snapshot.appendItems(data, toSection: .main)
                dataSource?.apply(snapshot)
                viewModel.isLoding = false
            }.store(in: &subscriptions)
    }
    
    @objc
    private func keyboardUp(notification: NSNotification) {
        if let keyboardFrame:NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            collectionView.contentInset = .init(top: 0, left: 0, bottom: keyboardRectangle.height, right: 0)
        }
    }
    
    @objc
    private func keyboardDown() {
        self.collectionView.contentInset = .zero
    }
    
}

extension PartyMemberSearchViewController: UICollectionViewDelegate {
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
                viewModel.requestSearch(page: viewModel.page + 1, size: 20, keyword: searchString)
                viewModel.page += 1
            }
        }
    }
}

extension PartyMemberSearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchString = searchText
        viewModel.requestSearch(page: 0, size: 20, keyword: searchString)
    }
}
