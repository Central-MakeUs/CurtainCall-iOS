//
//  HomeViewController.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/07/07.
//

import UIKit
import Combine

import SnapKit

final class HomeViewController: UIViewController {
    
    // MARK: - UI properties
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private let navigationView: UIView = {
        let view = UIView()
        view.backgroundColor = .pointColor1
        return view
    }()
    
    private let titleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: ImageNamespace.homeBannerTitle)
        return imageView
    }()
    
    private let searchButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: ImageNamespace.navigationSearchButton), for: .normal)
        return button
    }()
    
    private let helloLabel: UILabel = {
        let label = UILabel()
        label.text = "안녕하세요. 만도스님:)"
        label.textColor = .white
        label.font = .subTitle2
        return label
    }()
    
    private lazy var bannerCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createBannerLayout())
        collectionView.register(
            HomeBannerCell.self,
            forCellWithReuseIdentifier: HomeBannerCell.identifier
        )
        collectionView.backgroundColor = .pointColor1
        collectionView.isPagingEnabled = true
        return collectionView
    }()
    
    // MARK: - Properties
    
    enum BannerSection {
        case main
    }
    typealias BannerItem = BannerData
    private var bannerDatasource: UICollectionViewDiffableDataSource<BannerSection, BannerItem>?
    
    
    // MARK: - Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        view.backgroundColor = .pointColor1
    }
    
    // MARK: - Helpers
    
    private func configureUI() {
        configureSubviews()
        configureConstraints()
        configureBannerDatasource()
        confgureBannerSnapshot()
    }
    
    private func configureSubviews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubviews(navigationView, helloLabel, bannerCollectionView)
        navigationView.addSubviews(titleImageView, searchButton)
    }
    
    private func configureConstraints() {
        scrollView.snp.makeConstraints { $0.edges.equalTo(view.safeAreaLayoutGuide) }
        contentView.snp.makeConstraints {
            $0.edges.equalTo(scrollView.contentLayoutGuide)
            $0.width.equalTo(scrollView.frameLayoutGuide)
            $0.height.equalTo(2000)
        }
        navigationView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(40)
        }
        titleImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(24)
        }
        searchButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(24)
        }
        helloLabel.snp.makeConstraints {
            $0.top.equalTo(navigationView.snp.bottom).offset(26)
            $0.leading.equalToSuperview().offset(26)
        }
        bannerCollectionView.snp.makeConstraints {
            $0.top.equalTo(helloLabel.snp.bottom).offset(16)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(180)
        }
    }
    
    private func createBannerLayout() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .absolute(180)
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [item]
        )
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPagingCentered
        return UICollectionViewCompositionalLayout(section: section)
    }
    
    private func configureBannerDatasource() {
        bannerDatasource = UICollectionViewDiffableDataSource<BannerSection, BannerItem>(
            collectionView: bannerCollectionView,
            cellProvider: { collectionView, indexPath, itemIdentifier in
                guard let cell = collectionView.dequeueCell(
                    type: HomeBannerCell.self,
                    indexPath: indexPath
                ) else { return UICollectionViewCell() }
                print(itemIdentifier)
                cell.drawCell(data: itemIdentifier)
                return cell
            }
        )
    }
    
    private func confgureBannerSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<BannerSection, BannerItem>()
        snapshot.appendSections([.main])
        snapshot.appendItems(BannerData.list, toSection: .main)
        bannerDatasource?.apply(snapshot)
    }
    
}
//
//    private func configureDatasource() {
//        datasource = UICollectionViewDiffableDataSource<Section, Item>(
//            collectionView: collectionView,
//            cellProvider: { collectionView, indexPath, itemIdentifier in
//                switch indexPath.section {
//                case 0:
//                    guard let cell = collectionView.dequeueCell(
//                        type: HomeBannerCell.self,
//                        indexPath: indexPath
//                    ) else {
//                        return nil
//                    }
//                    switch itemIdentifier {
//                    case .banner(let str):
//                        str.forEach { _ in
//                            print(str)
//                            cell.drawCell(i: 0)
//                        }
//                    }
//                    
//                    return cell
//                default:
//                    return nil
//                }
//            }
//        )
//        
//        datasource?.supplementaryViewProvider = { [weak self] (collectionView, kind, indexPath) in
//            switch indexPath.section {
//            case 0:
//                guard let header = collectionView.dequeueReusableSupplementaryView(
//                    ofKind: UICollectionView.elementKindSectionHeader,
//                    withReuseIdentifier: HomeBannerHeaderView.identifier,
//                    for: indexPath
//                ) as? HomeBannerHeaderView else { return nil }
//                return header
//            default:
//                return nil
//            }
//        }
//    }
//    
//    private func configureSnapshot() {
//        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
//        snapshot.appendSections([.banner])
//        snapshot.appendItems([.banner(["aaa", "bbb"])], toSection: .banner)
//        datasource?.apply(snapshot)
//    }

