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
    
    enum Section { case main }
    typealias Item = ProductSearchInfo
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
    
    private let reservationDotView: UIView = {
        let view = UIView()
        view.backgroundColor = .pointColor2
        view.layer.cornerRadius = 2
        return view
    }()
    
    private let reservationOrderButton: UIButton = {
        let button = UIButton()
        button.setTitle("예매율순", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 12, weight: .medium)
        button.setTitleColor(.body1, for: .selected)
        button.setTitleColor(.hexBEC2CA, for: .normal)
        return button
    }()
    
    private let dictionaryOrderDotView: UIView = {
        let view = UIView()
        view.backgroundColor = .pointColor2
        view.layer.cornerRadius = 2
        return view
    }()
    
    private let dictionaryOrderButton: UIButton = {
        let button = UIButton()
        button.setTitle("가나다순", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 12, weight: .medium)
        button.setTitleColor(.body1, for: .selected)
        button.setTitleColor(.hexBEC2CA, for: .normal)
        return button
    }()
    
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
    
    // MARK: - Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        addTarget()
        typeButtonTouchUpInside(theaterButton)
        orderSelectButtonTouchUpInside(reservationOrderButton)
        requestShowList()
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
        view.addSubviews(
            titleLabel, descriptionLabel, categoryView, collectionView, reservationDotView,
            reservationOrderButton, dictionaryOrderDotView, dictionaryOrderButton
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
        
        reservationDotView.snp.makeConstraints {
            $0.height.width.equalTo(4)
            $0.top.equalTo(categoryView.snp.bottom).offset(24)
            $0.leading.equalToSuperview().offset(24)
        }
        
        reservationOrderButton.snp.makeConstraints {
            $0.centerY.equalTo(reservationDotView)
            $0.leading.equalTo(reservationDotView.snp.trailing).offset(4)
        }
        dictionaryOrderDotView.snp.makeConstraints {
            $0.height.width.equalTo(4)
            $0.centerY.equalTo(reservationDotView)
            $0.leading.equalTo(reservationOrderButton.snp.trailing).offset(10)
        }
        
        dictionaryOrderButton.snp.makeConstraints {
            $0.centerY.equalTo(dictionaryOrderDotView)
            $0.leading.equalTo(dictionaryOrderDotView.snp.trailing).offset(4)
        }
        collectionView.snp.makeConstraints {
            $0.top.equalTo(reservationOrderButton.snp.bottom).offset(12)
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
        item.edgeSpacing = .init(leading: nil, top: .fixed(28), trailing: nil, bottom: nil)
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .estimated(200)
        )
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: -28, leading: 24, bottom: 0, trailing: 24)
        return UICollectionViewCompositionalLayout(section: section)
    }
    
    private func configureDatasource() {
        datasource = Datasource(collectionView: collectionView, cellProvider: {
            collectionView, indexPath, item in
            guard let cell = collectionView.dequeueCell(
                type: ProductSearchCell.self,
                indexPath: indexPath
            ) else { return UICollectionViewCell() }
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
    
    private func configureSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections([.main])
        snapshot.appendItems(ProductSearchInfo.list)
        datasource?.apply(snapshot)
    }
    
    private func addTarget() {
        [theaterButton, musicalButton].forEach {
            $0.addTarget(self, action: #selector(typeButtonTouchUpInside), for: .touchUpInside)
        }
        [reservationOrderButton, dictionaryOrderButton].forEach {
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
    }
    
    @objc
    private func orderSelectButtonTouchUpInside(_ sender: UIButton) {
        [reservationOrderButton, dictionaryOrderButton].forEach {
            $0.isSelected = sender == $0
            $0.isUserInteractionEnabled = !(sender == $0)
        }
        reservationDotView.alpha = sender == reservationOrderButton ? 1 : 0
        dictionaryOrderDotView.alpha = sender == dictionaryOrderButton ? 1 : 0
    }
    
    private func requestShowList() {
        provider.requestPublisher(.list(page: 1, size: 20, genre: .play))
            .sink { completion in
                if case let .failure(error) = completion {
                    print(error.localizedDescription)
                    return
                }
            } receiveValue: { response in
                if let data = try? response.map(ProductListResponse.self) {
                    print("##", data)
                }
            }.store(in: &subscriptions)

    }
}

extension ProductViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailViewController = UINavigationController(
            rootViewController: ProductDetailMainViewController()
        )
        detailViewController.modalPresentationStyle = .overFullScreen
        present(detailViewController, animated: true)
    }
}
