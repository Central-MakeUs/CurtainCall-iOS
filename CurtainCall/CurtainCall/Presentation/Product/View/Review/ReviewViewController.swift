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
    
    // MARK: Property
    
    private let provider = MoyaProvider<ReviewAPI>()
    private var subscriptions: Set<AnyCancellable> = []
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        addTarget()
    }
    
    // MARK: Configure
    
    private func configureUI() {
        configureSubviews()
        configureConstarints()
        configureNavigation()
    }
    
    private func configureSubviews() {
        view.addSubviews(tableView, writeButton)
    }
    
    private func configureConstarints() {
        tableView.snp.makeConstraints { $0.edges.equalToSuperview() }
        writeButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-60)
            $0.trailing.equalToSuperview().offset(-24)
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
            viewModel: ReviewWriteViewModel()
        )
        navigationController?.pushViewController(writeViewController, animated: true)
    }
}

extension ReviewViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ReviewInfo.list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: ProductReviewCell.identifier
        ) as? ProductReviewCell else { return UITableViewCell() }
        
        cell.draw(item: ReviewInfo.list[indexPath.row])
        return cell
    }
}

extension ReviewViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
