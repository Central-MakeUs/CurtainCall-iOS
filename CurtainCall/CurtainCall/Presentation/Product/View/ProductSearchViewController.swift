//
//  ProductSearchViewController.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/08/28.
//

import UIKit

import SnapKit
import Moya
import CombineMoya
import Combine

final class ProductSearchViewController: UIViewController {
    
    // MARK: UI Property
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: createCollectionViewLayout()
        )
        collectionView.register(
            ProductSearchCell.self,
            forCellWithReuseIdentifier: ProductSearchCell.identifier
        )
        collectionView.delegate = self
        return collectionView
    }()
    
    // MARK: Property
    
    enum Section {
        case main
    }
    typealias Item = ProductListContent
    typealias Datasource = UICollectionViewDiffableDataSource<Section, Item>
    private var datasource: Datasource?
    private var subscriptions: Set<AnyCancellable> = []
    private let viewModel: ProductSearchViewModel
    private var searchString = ""
    // MARK: Life Cycle
    
    init(viewModel: ProductSearchViewModel) {
        self.viewModel = viewModel
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
    
    // MARK: Configure
    
    private func configureUI() {
        configureSubviews()
        configureConstraints()
        configureDatasource()
        configureNavigation()
    }
    
    private func configureSubviews() {
        view.backgroundColor = .white
        view.addSubview(collectionView)
    }
    
    private func configureConstraints() {
        collectionView.snp.makeConstraints { $0.edges.equalTo(view.safeAreaLayoutGuide) }
    }
    
    private func configureNavigation() {
        configureBackbarButton()
        let searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: view.frame.width - 80, height: 0))
        searchBar.setImage(UIImage(), for: UISearchBar.Icon.search, state: .normal)
        searchBar.placeholder = "작품명 입력"
        searchBar.delegate = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: searchBar)
    }
    
    private func createCollectionViewLayout() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .estimated(200)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.edgeSpacing = .init(leading: nil, top: nil, trailing: nil, bottom: nil)
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .estimated(200)
        )
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 0, leading: 24, bottom: 0, trailing: 24)
        return UICollectionViewCompositionalLayout(section: section)
    }
    
    private func configureDatasource() {
        datasource = Datasource(collectionView: collectionView, cellProvider: {
            collectionView, indexPath, item in
            guard let cell = collectionView.dequeueCell(
                type: ProductSearchCell.self,
                indexPath: indexPath
            ) else { return UICollectionViewCell() }
            cell.id = item.id
            cell.draw(item: item)
            return cell
        })
    }
    
    private func bind() {
        viewModel.$productList
            .debounce(for: .seconds(0.3), scheduler: DispatchQueue.main)
            .sink { [weak self] data in
                guard let self else { return }
                var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
                snapshot.deleteAllItems()
                snapshot.appendSections([.main])
                snapshot.appendItems(data, toSection: .main)
                datasource?.apply(snapshot)
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
//        self.view.transform = .identity
        self.collectionView.contentInset = .zero
    }
    
}

extension ProductSearchViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let datasource = datasource, let item = datasource.itemIdentifier(for: indexPath) else {
            return
        }
        let detailViewController = UINavigationController(
            rootViewController: ProductDetailMainViewController(id: item.id)
        )
        detailViewController.modalPresentationStyle = .overFullScreen
        present(detailViewController, animated: true)
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

extension ProductSearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchString = searchText
        guard !searchString.isEmpty else { return }
        viewModel.requestSearch(page: 0, size: 20, keyword: searchString)
    }
}
