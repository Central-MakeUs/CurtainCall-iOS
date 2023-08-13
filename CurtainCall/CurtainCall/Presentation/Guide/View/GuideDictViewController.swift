//
//  GuideDictViewController.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/08/10.
//

import UIKit

final class GuideDictViewController: UIViewController {
    
    // MARK: - UI properties
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .subTitle1
        label.textColor = .title
        label.text = "📚 알쏭달쏭 용어 사진"
        return label
    }()
    
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
    
    private let totalButton: GuideCategoryButton = {
        let button = GuideCategoryButton()
        button.setTitle("전체", for: .normal)
        button.isSelected = true
        button.setBackground(true)
        return button
    }()
    
    private let ticketingButton: GuideCategoryButton = {
        let button = GuideCategoryButton()
        button.setTitle("예메 및 좌석", for: .normal)
        button.guideType = .ticketing
        return button
    }()
    
    private let showButton: GuideCategoryButton = {
        let button = GuideCategoryButton()
        button.setTitle("공연", for: .normal)
        button.guideType = .show
        return button
    }()
    
    private let theaterButton: GuideCategoryButton = {
        let button = GuideCategoryButton()
        button.setTitle("극장", for: .normal)
        button.guideType = .theater
        return button
    }()
    
    private let audienceButton: GuideCategoryButton = {
        let button = GuideCategoryButton()
        button.setTitle("관객", for: .normal)
        button.guideType = .audience
        return button
    }()
    
    private let otherButton: GuideCategoryButton = {
        let button = GuideCategoryButton()
        button.setTitle("기타", for: .normal)
        button.guideType = .other
        return button
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.register(GuideDictCell.self, forCellReuseIdentifier: GuideDictCell.identifier)
        tableView.separatorInset = .init(top: 0, left: 24, bottom: 0, right: 24)
        tableView.layer.cornerRadius = 30
        tableView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        tableView.contentInset = .init(top: 0, left: 0, bottom: 90, right: 0)
        return tableView
    }()
    
    // MARK: - Properties
    
    private var guideData = PerformanceExpressionDictionaryData.list

    // MARK: - Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .hexF5F6F8
        configureUI()
        addTargets()
    }
    
    // MARK: - Helpers
    
    private func configureUI() {
        configureSubviews()
        configureConstraints()
        configureNavigation()
    }
    
    private func configureSubviews() {
        view.addSubviews(titleLabel, categoryScrollView, tableView)
        categoryScrollView.addSubview(categoryContentView)
        categoryContentView.addSubview(categoryStackView)
        categoryStackView.addArrangedSubviews(
            totalButton, ticketingButton, showButton, theaterButton, audienceButton, otherButton
        )
    }
    
    private func configureConstraints() {
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(30)
            $0.left.equalToSuperview().offset(24)
        }
        categoryScrollView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
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
        
        [totalButton, showButton, theaterButton, audienceButton, otherButton].forEach {
            $0.snp.makeConstraints { make in
                make.width.equalTo(58)
            }
        }
        ticketingButton.snp.makeConstraints {
            $0.width.equalTo(109)
        }
        tableView.snp.makeConstraints {
            $0.top.equalTo(categoryScrollView.snp.bottom).offset(26)
            $0.left.right.bottom.equalToSuperview()
            
        }
    }
    
    private func configureNavigation() {
        configureBackbarButton()
        title = "입문자를 위한 연뮤 가이드"
    }
    
    private func addTargets() {
        [totalButton, ticketingButton, showButton, theaterButton, audienceButton, otherButton].forEach {
            $0.addTarget(self, action: #selector(categoryButtonTapped), for: .touchUpInside)
        }
    }
    
    @objc
    private func categoryButtonTapped(_ sender: GuideCategoryButton) {
        [totalButton, ticketingButton, showButton, theaterButton, audienceButton, otherButton].forEach {
            $0.isSelected = false
            $0.setBackground(false)
        }
        sender.isSelected = true
        sender.setBackground(true)
        if let guideType = sender.guideType {
            guideData = PerformanceExpressionDictionaryData.list.filter { $0.type == guideType }
        } else {
            guideData = PerformanceExpressionDictionaryData.list
        }
        tableView.reloadData()
    }
    
}

extension GuideDictViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return guideData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueCell(type: GuideDictCell.self, indexPath: indexPath) else { return UITableViewCell() }
        cell.selectionStyle = .none
        cell.draw(dict: guideData[indexPath.row])
        cell.drawNumber(index: indexPath.row + 1)
        return cell
    }
    
    
}
