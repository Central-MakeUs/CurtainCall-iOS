//
//  MyRecruitmentViewController.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/08/15.
//

import UIKit
import Combine

final class MyRecruitmentViewController: UIViewController {
    
    // MARK: - UI properties
    
    private let categoryScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.contentInset = .init(top: 0, left: 24, bottom: 0, right: 24)
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    private let categoryContentView = UIView()
    private let categoryStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        return stackView
    }()
    
    private let productButton: GuideCategoryButton = {
        let button = GuideCategoryButton()
        button.setTitle("공연 관람", for: .normal)
        button.tag = 0
        return button
    }()
    
    private let foodButton: GuideCategoryButton = {
        let button = GuideCategoryButton()
        button.setTitle("식사/카페", for: .normal)
        button.tag = 1
        return button
    }()
    
    private let otherButton: GuideCategoryButton = {
        let button = GuideCategoryButton()
        button.setTitle("기타", for: .normal)
        button.tag = 2
        return button
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: createCollectionViewLayout()
        )
        collectionView.backgroundColor = .clear
        collectionView.register(
            MyPageRecruitmentCell.self,
            forCellWithReuseIdentifier: MyPageRecruitmentCell.identifier
        )
        collectionView.delegate = self
        collectionView.isHidden = true
        return collectionView
    }()
    
    private let emptyView = PartyMemberEmptyView()
    
    // MARK: - Properties
    
    private enum Section { case main }
    typealias Item = MyRecruitmentContent
    private var cancellables = Set<AnyCancellable>()
    private var dataSource: UICollectionViewDiffableDataSource<Section, Item>?
    private let viewModel: MyRecruitmentViewModel
    
    // MARK: - Lifecycles
    
    init(viewModel: MyRecruitmentViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        addTargets()
        bind()
        categoryButtonTapped(productButton)
    }
    
    // MARK: - Helpers
    
    private func configureUI() {
        configureSubviews()
        configureConstraints()
        configureNavigtaion()
        configureDatasource()
    }
    
    private func configureSubviews() {
        view.backgroundColor = .hexF5F6F8
        view.addSubviews(categoryScrollView, collectionView, emptyView)
        categoryScrollView.addSubviews(categoryContentView)
        categoryContentView.addSubview(categoryStackView)
        categoryStackView.addArrangedSubviews(productButton, foodButton, otherButton)
    }
    
    private func configureConstraints() {
        categoryScrollView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(30)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(36)
        }
        categoryContentView.snp.makeConstraints {
            $0.edges.equalTo(categoryScrollView.contentLayoutGuide)
            $0.height.equalTo(categoryScrollView.frameLayoutGuide)
        }
        categoryStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        productButton.snp.makeConstraints {
            $0.width.equalTo(91)
        }
        foodButton.snp.makeConstraints {
            $0.width.equalTo(97)
        }
        otherButton.snp.makeConstraints {
            $0.width.equalTo(58)
        }
        collectionView.snp.makeConstraints {
            $0.top.equalTo(categoryScrollView.snp.bottom).offset(18)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        emptyView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    private func configureNavigtaion() {
        configureBackbarButton(.dismiss)
        title = "MY 모집"
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
                    type: MyPageRecruitmentCell.self,
                    indexPath: indexPath
                ) else { return UICollectionViewCell() }
                cell.setUI(item)
                return cell
            }
        )
    }
    
    private func addTargets() {
        [productButton, foodButton, otherButton].forEach {
            $0.addTarget(self, action: #selector(categoryButtonTapped), for: .touchUpInside)
        }
    }
    
    private func bind() {
        viewModel.myRecruitmentSubject
            .receive(on: DispatchQueue.main)
            .sink { completion in
                if case let .failure(error) = completion {
                    print(error.localizedDescription)
                }
            } receiveValue: { [weak self] item in
                var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
                snapshot.appendSections([.main])
                snapshot.appendItems(item, toSection: .main)
                self?.collectionView.isHidden = item.isEmpty
                self?.emptyView.isHidden = !item.isEmpty
                self?.dataSource?.apply(snapshot)
            }.store(in: &cancellables)

    }
    
    @objc
    private func categoryButtonTapped(_ sender: GuideCategoryButton) {
        [productButton, foodButton, otherButton].forEach {
            $0.isSelected = false
            $0.setBackground(false)
        }
        sender.isSelected = true
        sender.setBackground(true)
        if sender == productButton {
            viewModel.requestRecruitment(category: .watching)
        } else if sender == foodButton {
            viewModel.requestRecruitment(category: .food)
        } else {
            viewModel.requestRecruitment(category: .etc)
        }
    }
    
}

extension MyRecruitmentViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let dataSource,
              let item = dataSource.itemIdentifier(for: indexPath),
              let tag = [productButton, foodButton, otherButton].first(where: { $0.isSelected })?.tag,
              let partyType = PartyType(tag: tag) else {
            return
        }
        let detailViewController = MyPageDetailViewController(
            id: 1,
            editType: .recruitment
        )
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}
