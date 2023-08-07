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
    
    private let bannerView: UIView = {
        let view = UIView()
        view.backgroundColor = .pointColor1
        return view
    }()
    
    private lazy var bannerCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createBannerLayout())
        collectionView.register(
            HomeBannerCell.self,
            forCellWithReuseIdentifier: HomeBannerCell.identifier
        )
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .pointColor1
        collectionView.isPagingEnabled = true
        collectionView.delegate = self
        return collectionView
    }()
    
    private let pageControl: UIPageControl = {
        let pageControl = UIPageControl(frame: .zero)
        pageControl.numberOfPages = BannerData.list.count
        return pageControl
    }()
    
    private let myStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        return stackView
    }()
    
    private let myRecruitmentView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private let myRecruitmentHeaderView = UIView()
    private let myRecruitmentLabel: UILabel = {
        let label = UILabel()
        label.text = "📢  My 모집"
        label.font = .heading2
        label.textColor = .title
        return label
    }()
    
    private lazy var myRecruitmentTableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.register(
            MyRecruitmentCell.self,
            forCellReuseIdentifier: MyRecruitmentCell.identifier
        )
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
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
        contentView.addSubviews(navigationView, helloLabel, bannerView, myStackView)
        bannerView.addSubviews(bannerCollectionView, pageControl)
        navigationView.addSubviews(titleImageView, searchButton)
        myStackView.addArrangedSubviews(myRecruitmentView)
        myRecruitmentView.addSubviews(myRecruitmentHeaderView, myRecruitmentTableView)
        myRecruitmentHeaderView.addSubview(myRecruitmentLabel)
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
        bannerView.snp.makeConstraints {
            $0.top.equalTo(helloLabel.snp.bottom).offset(16)
            $0.horizontalEdges.equalToSuperview()
        }
        bannerCollectionView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(180)
        }
        pageControl.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(bannerCollectionView.snp.bottom).offset(11)
            $0.bottom.equalToSuperview().inset(16)
        }
        myStackView.snp.makeConstraints {
            $0.top.equalTo(bannerView.snp.bottom)
            $0.horizontalEdges.equalToSuperview()
            // TODO: 추가
        }
        myRecruitmentHeaderView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(81)
        }
        myRecruitmentLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(3)
            $0.leading.equalToSuperview().offset(24)
        }
        myRecruitmentTableView.snp.makeConstraints {
            $0.top.equalTo(myRecruitmentHeaderView.snp.bottom)
            $0.height.equalTo(HomeMyProductData.list.count * 111)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview().inset(10)
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
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.scrollDirection = .horizontal
        return UICollectionViewCompositionalLayout(section: section, configuration: config)
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

extension HomeViewController: UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let page = Int((scrollView.contentOffset.x / scrollView.frame.width).rounded(.up))
        pageControl.currentPage = page
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return HomeMyProductData.list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueCell(
            type: MyRecruitmentCell.self,
            indexPath: indexPath
        ) else { return UITableViewCell() }
        cell.selectionStyle = .none
        cell.draw(item: HomeMyProductData.list[indexPath.row])
        return cell
    }
    
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 111
    }
}
