//
//  MyWriteViewController.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/08/31.
//

import UIKit
import Combine

import Moya
import CombineMoya

final class MyWriteViewController: UIViewController {
    
    private var myWriteData: [MyWriteReviewContent] = []
    private var myWriteLostData: [MyWriteLostItemContent] = []
    
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
    
    private let reviewButton: MyWriteCategoryButton = {
        let button = MyWriteCategoryButton()
        button.setTitle("한 줄 리뷰", for: .normal)
        button.isSelected = true
        button.setBackground(true)
        return button
    }()
    
    private let lostItemButton: MyWriteCategoryButton = {
        let button = MyWriteCategoryButton()
        button.setTitle("분실물", for: .normal)
        button.isSelected = false
        return button
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.contentInset = .init(top: 20, left: 0, bottom: 0, right: 0)
        tableView.register(MyWriteReviewCell.self, forCellReuseIdentifier: MyWriteReviewCell.identifier)
        tableView.register(MyWriteLostItemCell.self, forCellReuseIdentifier: MyWriteLostItemCell.identifier)
        return tableView
    }()
    
    private lazy var emptyView: UIView = {
        let view = UIView()
        view.backgroundColor = .hexF5F6F8
        
        let emptyLabel: UILabel = {
            let label = UILabel()
            label.text = "내가 쓴 글이 없어요!"
            label.textColor = .hexBEC2CA
            label.font = .body1
            return label
        }()
        
        let emptyImageView = UIImageView(image: UIImage(named: ImageNamespace.lostItemEmptyImage))
        view.addSubviews(emptyImageView, emptyLabel)
        emptyLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        emptyImageView.snp.makeConstraints {
            $0.bottom.equalTo(emptyLabel.snp.top).offset(-18)
            $0.centerX.equalToSuperview()
        }
        view.isHidden = true
        return view
    }()
    
    // MARK: - Properties
    
    private let provider = MoyaProvider<MyPageAPI>()
    private var subscriptions = Set<AnyCancellable>()
    
    // MARK: - Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        categoryButtonTapped(reviewButton)
        addTargets()
    }
    
    // MARK: - Helpers
    
    private func configureUI() {
        configureSubviews()
        configureConstraints()
        configureNavigation()
    }
    
    private func configureSubviews() {
        view.backgroundColor = .white
        view.addSubviews(categoryScrollView, emptyView, tableView)
        categoryScrollView.addSubviews(categoryContentView)
        categoryContentView.addSubview(categoryStackView)
        categoryStackView.addArrangedSubviews(reviewButton, lostItemButton)
    }
    
    private func configureConstraints() {
        categoryScrollView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(10)
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
        
        [reviewButton, lostItemButton].forEach {
            $0.snp.makeConstraints { make in
                make.width.equalTo(106)
            }
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(categoryScrollView.snp.bottom).offset(6)
            $0.left.right.bottom.equalToSuperview()
            
        }
        emptyView.snp.makeConstraints {
            $0.top.equalTo(categoryScrollView.snp.bottom).offset(26)
            $0.left.right.bottom.equalToSuperview()
        }
    }
    
    private func requestMyReview() {
        provider.requestPublisher(.myWriteReview)
            .sink { [weak self] completion in
                if case let .failure(error) = completion {
                    guard let self else { return }
                    self.emptyView.isHidden = false
                    self.tableView.isHidden = true
                    return
                }
            } receiveValue: { [weak self] response in
                if let data = try? response.map(MyWriteReviewResponse.self) {
                    self?.emptyView.isHidden = !data.content.isEmpty
                    self?.tableView.isHidden = data.content.isEmpty
                    self?.myWriteData = data.content
                    self?.tableView.reloadData()
                } else {
                    self?.emptyView.isHidden = false
                    self?.tableView.isHidden = true
                }
            }.store(in: &subscriptions)
        
    }
    
    private func requestMyWriteLostItem() {
        provider.requestPublisher(.myWriteLostItem)
            .sink { [weak self] completion in
                if case let .failure(error) = completion {
                    guard let self else { return }
                    self.emptyView.isHidden = false
                    self.tableView.isHidden = true
                    print(error)
                    return
                }
            } receiveValue: { [weak self] response in
                
                if let data = try? response.map(MyWriteLostItemResponse.self) {
                    self?.emptyView.isHidden = !data.content.isEmpty
                    self?.tableView.isHidden = data.content.isEmpty
                    self?.myWriteLostData = data.content
                    self?.tableView.reloadData()
                } else {
                    self?.emptyView.isHidden = false
                    self?.tableView.isHidden = true
                }
            }.store(in: &subscriptions)

    }
    
    private func configureNavigation() {
        title = "내가 쓴 글"
        configureBackbarButton(.dismiss)
    }
    
    private func addTargets() {
        [reviewButton, lostItemButton].forEach {
            $0.addTarget(self, action: #selector(categoryButtonTapped), for: .touchUpInside)
        }
    }
    
    @objc
    private func categoryButtonTapped(_ sender: MyWriteCategoryButton) {
        [reviewButton, lostItemButton].forEach {
            $0.isSelected = false
            $0.setBackground(false)
        }
        sender.isSelected = true
        sender.setBackground(true)
        if sender == reviewButton {
            requestMyReview()
        } else {
            requestMyWriteLostItem()
        }
        tableView.reloadData()
    }
    
}

extension MyWriteViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if reviewButton.isSelected {
            guard let cell = tableView.dequeueCell(type: MyWriteReviewCell.self, indexPath: indexPath) else {
                return UITableViewCell()
            }
            cell.draw(item: myWriteData[indexPath.row])
            return cell
        } else {
            guard let cell = tableView.dequeueCell(type: MyWriteLostItemCell.self, indexPath: indexPath) else {
                return UITableViewCell()
            }
            cell.draw(item: myWriteLostData[indexPath.row])
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if reviewButton.isSelected {
            return myWriteData.count
        } else {
            return myWriteLostData.count
        }
    }
}

extension MyWriteViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return reviewButton.isSelected ? 146 : 154
//    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if reviewButton.isSelected {
            let id = myWriteData[indexPath.row].id

        } else {
            let id = myWriteLostData[indexPath.row].id
            let vc = LostItemDetailViewController(id: id)
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
