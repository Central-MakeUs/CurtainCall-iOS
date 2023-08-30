//
//  MyWriteViewController.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/08/30.
//

import UIKit

import SnapKit
import Moya
import CombineMoya
import Combine

final class MyFavoriteViewController: UIViewController {
    
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
    
    enum Section { case main }
    typealias Item = MyFavoriteShowContent
    typealias Datasource = UICollectionViewDiffableDataSource<Section, Item>
    
    private let viewModel: MyFavoriteViewModel
    private var subscriptions: Set<AnyCancellable> = []
    private var datasource: Datasource?
    private let provider = MoyaProvider<ProductAPI>()
    
    // MARK: Life Cycle
    
    init(viewModel: MyFavoriteViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        bind()
        viewModel.requestMyFavorite()
        configureUI()
    }
    
    // MARK: Configure
    
    private func configureUI() {
        configureSubviews()
        configureConstraints()
        configureNavigation()
    }
    
    private func configureSubviews() {
        view.addSubviews(collectionView)
    }
    
    private func configureConstraints() {
        collectionView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func configureNavigation() {
        configureBackbarButton(.dismiss)
        title = "저장한 작품 목록"
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
    
//    private func configureDatasource() {
//        datasource = Datasource(collectionView: collectionView, cellProvider: {
//            collectionView, indexPath, item in
//            guard let cell = collectionView.dequeueCell(
//                type: ProductSearchCell.self,
//                indexPath: indexPath
//            ) else { return UICollectionViewCell() }
//            cell.id = item.id
//            cell.draw(item: item)
//            return cell
//        })
//    }
    
    private func bind() {
        viewModel.myFavoriteShowList
            .sink { completion in
                if case let .failure(error) = completion {
                    print(error.localizedDescription)
                    return
                }
            } receiveValue: { [weak self] value in
                guard let self else { return }
                print("###", value)
//                var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
//                snapshot.appendSections([.main])
//                snapshot.appendItems(value, toSection: .main)
//                datasource?.apply(snapshot)
//                viewModel.isLoding = false
            }.store(in: &subscriptions)

    }
    
}

extension MyFavoriteViewController: UICollectionViewDelegate {
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
}
