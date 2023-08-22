//
//  ReviewViewController.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/07/28.
//

import UIKit

import Moya
import CombineMoya
import Combine

final class ReviewViewController: UIViewController {
    
    // MARK: UI Property
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ProductReviewCell.self, forCellReuseIdentifier: ProductReviewCell.identifier)
        return tableView
    }()
    
    private let writeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: ImageNamespace.partymemberWriteButton), for: .normal)
        return button
    }()
    
    private let emptyView = UIView()
    private let emptyImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: ImageNamespace.emptyMarks)
        return imageView
    }()
    private let emptyLabel: UILabel = {
        let label = UILabel()
        label.font = .body1
        label.textColor = .hexBEC2CA
        label.numberOfLines = 0
        label.text = "아직 한 줄 리뷰가 없어요!\n간단한 리뷰 작성으로 감상 후기를\n공유해보세요 :)"
        label.textAlignment = .center
        return label
    }()
    
    
    // MARK: Property
    
    private let provider = MoyaProvider<ReviewAPI>()
    private var subscriptions: Set<AnyCancellable> = []
    private let id: String
    private var reviewInfos: [ShowReviewContent] = []
    private let product: ProductDetailResponse
    
    // MARK: Life Cycle
    
    init(product: ProductDetailResponse, id: String) {
        self.product = product
        self.id = id
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        addTarget()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        requestReviewList(id: id)
    }
    
    // MARK: Configure
    
    private func configureUI() {
        configureSubviews()
        configureConstarints()
        configureNavigation()
    }
    
    private func configureSubviews() {
        view.addSubviews(tableView, emptyView, writeButton)
        emptyView.addSubviews(emptyImage, emptyLabel)
        
    }
    
    private func configureConstarints() {
        tableView.snp.makeConstraints { $0.edges.equalToSuperview() }
        writeButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-60)
            $0.trailing.equalToSuperview().offset(-24)
        }
        emptyView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
        emptyImage.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(emptyLabel.snp.top).offset(-18)
        }
        emptyLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
    }
    
    private func configureNavigation() {
        configureBackbarButton()
        title = "한 줄 리뷰"
    }
    
    private func addTarget() {
        writeButton.addTarget(
            self,
            action: #selector(writeButtonTouchUpInside),
            for: .touchUpInside
        )
    }
    
    @objc
    private func writeButtonTouchUpInside() {
        let writeViewController = ReviewWriteViewController(
            product: product,
            id: id,
            viewModel: ReviewWriteViewModel()
        )
        navigationController?.pushViewController(writeViewController, animated: true)
    }
    
    private func requestReviewList(id: String) {
        provider.requestPublisher(.list(id: id, page: 0, size: 20))
            .sink { completion in
                if case let .failure(error) = completion {
                    print(error.localizedDescription)
                    return
                }
            } receiveValue: { [weak self] response in
                if let data = try? response.map(ShowReviewResponse.self) {
                    if data.content.isEmpty {
                        self?.setUpEmptyView()
                        self?.emptyView.isHidden = false
                    } else {
                        self?.reviewInfos = data.content
                        self?.emptyView.isHidden = true
                        self?.tableView.reloadData()
                    }
                }
            }.store(in: &subscriptions)
    }
    
    private func setUpEmptyView() {
        emptyView.isHidden = false
    }
    
}

extension ReviewViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviewInfos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: ProductReviewCell.identifier
        ) as? ProductReviewCell else { return UITableViewCell() }
        
        cell.draw(item: reviewInfos[indexPath.row])
        return cell
    }
}

extension ReviewViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
