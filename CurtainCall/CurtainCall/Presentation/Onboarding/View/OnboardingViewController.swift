//
//  OnboardingViewController.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/07/05.
//

import UIKit
import Combine

import SnapKit

final class OnboardingViewController: UIViewController {
    
    // MARK: - UI properties
    
    private let pageControl: UIPageControl = {
        let pageControl = UIPageControl(frame: .zero)
        pageControl.numberOfPages = OnboardingData.list.count
        return pageControl
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: createCollectionViewLayout()
        )
        collectionView.backgroundColor = .pointColor1
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        return collectionView
    }()
    
    private let nextButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .pointColor2
        button.layer.cornerRadius = 15
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        button.setTitleColor(.pointColor1, for: .normal)
        return button
    }()
    
    // MARK: - Properties
    
    private let viewModel: OnboardingViewModel
    private var cancellables = Set<AnyCancellable>()
    
    enum Section {
        case main
    }
    
    typealias Item = OnboardingData
    
    private var dataSource: UICollectionViewDiffableDataSource<Section, Item>?
    
    // MARK: - Lifecycles
    
    init(viewModel: OnboardingViewModel) {
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
        bind()
        registerCell()
        addTargets()
    }
    
    // MARK: - Helpers
    
    private func configureUI() {
        view.backgroundColor = .pointColor1
        configureSubviews()
        configureConstraints()
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
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.scrollDirection = .horizontal
        return UICollectionViewCompositionalLayout(section: section, configuration: config)
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
            cellProvider: { collectionView, indexPath, item in
                guard let cell = collectionView.dequeueCell(
                    type: OnboardingCell.self,
                    indexPath: indexPath
                ) else { return UICollectionViewCell() }
                cell.setupUI(data: item)
                return cell
            }
        )
    }
    
    private func configureSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections([.main])
        snapshot.appendItems(OnboardingData.list, toSection: .main)
        dataSource?.apply(snapshot)
    }
    
    private func bind() {
        viewModel.$currentPage.sink { [weak self] page in
            guard let self else { return }
            self.pageControl.currentPage = page
            self.nextButton.setTitle(page == 2 ? "로그인 하기" : "건너뛰기", for: .normal)
        }.store(in: &cancellables)
    }
    
    private func moveToLoginViewController() {
        let loginViewController = LoginViewController(
            viewModel: LoginViewModel()
        )
        changeRootViewController(UINavigationController(rootViewController: loginViewController))
    }
    
    // MARK: Action
    
    private func addTargets() {
        nextButton.addTarget(
            self,
            action: #selector(nextButtonTouchUpInside),
            for: .touchUpInside
        )
    }
    
    @objc
    private func nextButtonTouchUpInside() {
        if viewModel.currentPage == 2 {
            moveToLoginViewController()
            return
        }
        viewModel.nextButtonTapped()
        let x = collectionView.frame.size.width * CGFloat(viewModel.currentPage)
        collectionView.setContentOffset(
            CGPoint(x: x, y: 0),
            animated: true
        )
    }
    
}

extension OnboardingViewController: UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        viewModel.scrollPage(x: scrollView.contentOffset.x, width: scrollView.frame.width)
    }
}
