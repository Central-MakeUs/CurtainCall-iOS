//
//  ProductViewController.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/07/07.
//

import UIKit

import SnapKit
import Moya
import CombineMoya
import Combine

final class ProductViewController: UIViewController {
    
    enum Section {
        case play
        case musical
    }
    typealias Item = ProductListContent
    typealias Datasource = UICollectionViewDiffableDataSource<Section, Item>
    
    // MARK: - UI properties
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "작품 탐색"
        label.font = .heading1
        label.textColor = .heading
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "현재 상영 중인 작품 정보가 제공됩니다."
        label.font = .body3
        label.textColor = .hex5A6271
        return label
    }()
    
    private let categoryView: UIView = {
        let view = UIView()
        view.backgroundColor = .hexF5F6F8
        view.layer.cornerRadius = 10
        return view
    }()
    
    private let categoryStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private let theaterButton: UIButton = {
        let button = UIButton()
        button.setTitle("연극", for: .normal)
        button.titleLabel?.font = .subTitle4
        button.setTitleColor(.white, for: .selected)
        button.setTitleColor(.hexBEC2CA, for: .normal)
        button.layer.cornerRadius = 8
        return button
    }()
    
    private let musicalButton: UIButton = {
        let button = UIButton()
        button.setTitle("뮤지컬", for: .normal)
        button.titleLabel?.font = .subTitle4
        button.setTitleColor(.white, for: .selected)
        button.setTitleColor(.hexBEC2CA, for: .normal)
        button.layer.cornerRadius = 8
        return button
    }()
    
    private let reservationImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: ImageNamespace.productSearchSortIcon)
        return imageView
    }()
    
    private let reservationOrderButton: UIButton = {
        let button = UIButton()
        button.setTitle("별점순", for: .normal)
        button.titleLabel?.font = .body1
        button.setTitleColor(.body1, for: .normal)
        
        return button
    }()
    
//    private let dictionaryOrderDotView: UIView = {
//        let view = UIView()
//        view.backgroundColor = .pointColor2
//        view.layer.cornerRadius = 2
//        return view
//    }()
//
//    private let dictionaryOrderButton: UIButton = {
//        let button = UIButton()
//        button.setTitle("가나다순", for: .normal)
//        button.titleLabel?.font = .systemFont(ofSize: 12, weight: .medium)
//        button.setTitleColor(.body1, for: .selected)
//        button.setTitleColor(.hexBEC2CA, for: .normal)
//        return button
//    }()
    
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
    
    // MARK: - Properties
    
    private var datasource: Datasource?
    private var subscriptions: Set<AnyCancellable> = []
    private let provider = MoyaProvider<ProductAPI>()
    private let viewModel: ProductViewModel
    
    // MARK: - Lifecycles
    
    init(viewModel: ProductViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        addTarget()
        bind()
        orderSelectButtonTouchUpInside(reservationOrderButton)
        typeButtonTouchUpInside(theaterButton)
        
    }

    
    // MARK: - Helpers
    
    private func configureUI() {
        configureSubviews()
        configureConstraints()
        configureNavigation()
        configureDatasource()
    }
    
    private func configureSubviews() {
        view.addSubviews(
            titleLabel, descriptionLabel, categoryView, collectionView, reservationOrderButton,
            reservationImageView
        )
        categoryView.addSubview(categoryStackView)
        categoryStackView.addArrangedSubviews(theaterButton, musicalButton)
    }
    
    private func configureConstraints() {
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(6)
            $0.leading.equalTo(24)
        }
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(4)
            $0.leading.equalTo(24)
        }
        categoryView.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(16)
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.height.equalTo(45)
        }
        categoryStackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(4)
        }
        
//        reservationDotView.snp.makeConstraints {
//            $0.height.width.equalTo(4)
//            $0.top.equalTo(categoryView.snp.bottom).offset(24)
//            $0.leading.equalToSuperview().offset(24)
//        }
//
        reservationOrderButton.snp.makeConstraints {
            $0.top.equalTo(categoryView.snp.bottom).offset(24)
            $0.leading.equalToSuperview().offset(24)
        }
        reservationImageView.snp.makeConstraints {
            $0.centerY.equalTo(reservationOrderButton)
            $0.leading.equalTo(reservationOrderButton.snp.trailing).offset(6)
        }
//        dictionaryOrderDotView.snp.makeConstraints {
//            $0.height.width.equalTo(4)
//            $0.centerY.equalTo(reservationDotView)
//            $0.leading.equalTo(reservationOrderButton.snp.trailing).offset(10)
//        }
//
//        dictionaryOrderButton.snp.makeConstraints {
//            $0.centerY.equalTo(dictionaryOrderDotView)
//            $0.leading.equalTo(dictionaryOrderDotView.snp.trailing).offset(4)
//        }
        collectionView.snp.makeConstraints {
            $0.top.equalTo(reservationOrderButton.snp.bottom).offset(9)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-90)
        }
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
    
    private func configureNavigation() {
        let searchBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "magnifyingglass"),
            style: .plain,
            target: self,
            action: nil
        )
        searchBarButtonItem.tintColor = .black
        navigationItem.rightBarButtonItem = searchBarButtonItem
    }
    
    private func addTarget() {
        [theaterButton, musicalButton].forEach {
            $0.addTarget(self, action: #selector(typeButtonTouchUpInside), for: .touchUpInside)
        }
        [reservationOrderButton].forEach {
            $0.addTarget(
                self,
                action: #selector(orderSelectButtonTouchUpInside),
                for: .touchUpInside
            )
        }
    }
    
    @objc
    private func typeButtonTouchUpInside(_ sender: UIButton) {
        [theaterButton, musicalButton].forEach {
            $0.isSelected = sender == $0
            $0.isUserInteractionEnabled = !(sender == $0)
            $0.backgroundColor = sender == $0 ? .pointColor2 : .clear
        }
        if sender == theaterButton {
            viewModel.requestShow(page: 0, size: 20, genre: .play)
        } else {
            viewModel.requestShow(page: 0, size: 20, genre: .musical)
        }
    }
    
    @objc
    private func orderSelectButtonTouchUpInside(_ sender: UIButton) {
        
    }
    
    private func bind() {
        viewModel.$playList
            .sink { completion in
                if case let .failure(error) = completion {
                    print(error.localizedDescription)
                    return
                }
            } receiveValue: { [weak self] value in
                guard let self else { return }
                var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
                snapshot.appendSections([.play])
                snapshot.appendItems(value, toSection: .play)
                datasource?.apply(snapshot)
                viewModel.isLoding = false
            }.store(in: &subscriptions)
        
        viewModel.$musicalList
            .sink { completion in
                if case let .failure(error) = completion {
                    print(error.localizedDescription)
                    return
                }
            } receiveValue: { [weak self] value in
                guard let self else { return }
                var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
                snapshot.deleteAllItems()
                snapshot.appendSections([.musical])
                snapshot.appendItems(value, toSection: .musical)
                datasource?.apply(snapshot)
                viewModel.isLoding = false
            }.store(in: &subscriptions)
    }
}

extension ProductViewController: UICollectionViewDelegate {
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
        if theaterButton.isSelected {
            if indexPath.row > (viewModel.theaterPage + 1) * 20 - 3 {
                if !viewModel.isLoding {
                    viewModel.isLoding = true
                    viewModel.requestShow(page: viewModel.theaterPage + 1, size: 20, genre: .play)
                    viewModel.theaterPage += 1
                }
            }
        } else {
            if indexPath.row > (viewModel.musicalPage + 1) * 20 - 3 {
                if !viewModel.isLoding {
                    viewModel.isLoding = true
                    viewModel.requestShow(page: viewModel.musicalPage + 1, size: 20, genre: .musical)
                    viewModel.musicalPage += 1
                }
            }
        }
    }
}
