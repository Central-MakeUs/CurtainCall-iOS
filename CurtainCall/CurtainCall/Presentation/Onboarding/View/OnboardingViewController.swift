//
//  OnboardingViewController.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/07/05.
//

import UIKit

import SnapKit

final class OnboardingViewController: UIViewController {
    
    // MARK: - UI properties
    
    private let pageControl: UIPageControl = {
        let pageControl = UIPageControl(frame: .zero)
        pageControl.numberOfPages = 3
        pageControl.currentPage = 1
        return pageControl
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: createCollectionViewLayout()
        )
        collectionView.backgroundColor = UIColor(rgb: 0x273041)
        return collectionView
    }()
    
    private let nextButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(rgb: 0xF04E87)
        button.layer.cornerRadius = 15
        button.setTitle("건너뛰기", for: .normal)
        return button
    }()
    
    // MARK: - Properties
    typealias Section = String
    typealias Item = String
    
    private var dataSource: UICollectionViewDiffableDataSource<Section, Item>?
    
    // MARK: - Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Helpers
    
    private func configureUI() {
        view.backgroundColor = UIColor(rgb: 0x273041)
        configureSubviews()
        configureConstraints()
        registerCell()
        configureDatasource()
        configureSnapshot()
        
    }
    
    private func configureSubviews() {
        [pageControl, collectionView, nextButton].forEach { view.addSubview($0) }
    }
    
    private func configureConstraints() {
        pageControl.snp.makeConstraints {
            $0.top.equalToSuperview().offset(66)
            $0.trailing.equalToSuperview().offset(12)
        }
        collectionView.snp.makeConstraints {
            $0.top.equalTo(pageControl.snp.bottom)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalTo(nextButton.snp.top)
        }
        nextButton.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.bottom.equalToSuperview().offset(-54)
            $0.height.equalTo(58)
        }
    }
    
    private func createCollectionViewLayout() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        return UICollectionViewCompositionalLayout(section: section)
    }
    
    private func registerCell() {
        collectionView.register(
            OnboardingCell.self,
            forCellWithReuseIdentifier: OnboardingCell.identifier
        )
    }
    
    private func configureDatasource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Item>(
            collectionView: collectionView,
            cellProvider: { collectionView, indexPath, itemIdentifier in
                guard let cell = collectionView.dequeueCell(
                    type: OnboardingCell.self,
                    indexPath: indexPath
                ) else { return UICollectionViewCell() }
                
                return cell
            }
        )
    }
    
    private func configureSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections(["main"])
        snapshot.appendItems(["하하"], toSection: "main")
        dataSource?.apply(snapshot)
    }
    
}
