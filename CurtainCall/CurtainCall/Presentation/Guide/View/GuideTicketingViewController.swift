//
//  GuideTicketingViewController.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/08/12.
//

import UIKit

final class GuideTicketingViewController: UIViewController {
    
    // MARK: - UI properties
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .subTitle1
        label.textColor = .title
        label.text = "🎟️  티켓팅 안내"
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
    
    private let ticketingPrevButton: GuideCategoryButton = {
        let button = GuideCategoryButton()
        button.setTitle("티켓팅 이전", for: .normal)
        button.isSelected = true
        button.setBackground(true)
        return button
    }()
    
    private let ticketingNextButton: GuideCategoryButton = {
        let button = GuideCategoryButton()
        button.setTitle("티켓팅 이후", for: .normal)
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
    
    private var ticketingData = TicketingInfo.prevList

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
            ticketingPrevButton, ticketingNextButton
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
        
        [ticketingPrevButton, ticketingNextButton].forEach {
            $0.snp.makeConstraints { make in
                make.width.equalTo(106)
            }
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
        [ticketingPrevButton, ticketingNextButton].forEach {
            $0.addTarget(self, action: #selector(categoryButtonTapped), for: .touchUpInside)
        }
    }
    
    @objc
    private func categoryButtonTapped(_ sender: GuideCategoryButton) {
        [ticketingPrevButton, ticketingNextButton].forEach {
            $0.isSelected = false
            $0.setBackground(false)
        }
        sender.isSelected = true
        sender.setBackground(true)
        if sender == ticketingPrevButton {
            ticketingData = TicketingInfo.prevList
        } else {
            ticketingData = TicketingInfo.nextList
        }
        tableView.reloadData()
    }
    
}

extension GuideTicketingViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ticketingData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueCell(type: GuideDictCell.self, indexPath: indexPath) else { return UITableViewCell() }
        cell.selectionStyle = .none
        cell.draw(ticketing: ticketingData[indexPath.row])
        cell.drawNumber(index: indexPath.row + 1)
        return cell
    }
    
    
}

