//
//  NoticeViewController.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/08/22.
//

import UIKit
import Combine

final class NoticeViewController: UIViewController {
    
    // MARK: - UI properties
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorInset.left = 24
        tableView.separatorInset.right = 24
        tableView.register(NoticeCell.self, forCellReuseIdentifier: NoticeCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    // MARK: - Properties
    
    private let viewModel: NoticeViewModel
    private var subscriptions: Set<AnyCancellable> = []
    private var noticeItem: [NoticeContent] = []
    
    // MARK: - Lifecycles
    
    init(viewModel: NoticeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        bind()
        viewModel.requestNotice(page: 0, size: 100)
    }
    
    // MARK: - Helpers
    
    private func configureUI() {
        configureSubviews()
        configureConstraints()
        configureNavigation()
    }
    
    private func configureSubviews() {
        view.backgroundColor = .white
        view.addSubview(tableView)
    }
    
    private func configureConstraints() {
        tableView.snp.makeConstraints { $0.edges.equalToSuperview() }
    }
    
    private func configureNavigation() {
        configureBackbarButton()
        title = "공지사항"
    }
    
    private func bind() {
        viewModel.$noticeItem
            .sink { [weak self] value in
                self?.noticeItem = value
                self?.tableView.reloadData()
            }.store(in: &subscriptions)
    }
    
}

extension NoticeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return noticeItem.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueCell(type: NoticeCell.self, indexPath: indexPath) else {
            return UITableViewCell()
        }
        let item = noticeItem[indexPath.row]
        cell.draw(title: item.title, date: item.createdAt)
        return cell
    }
}

extension NoticeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let id = noticeItem[indexPath.row].id
        let detailViewController = NoticeDetailViewController(viewModel: NoticeDetailViewModel(id: id))
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}

final class NoticeCell: UITableViewCell {
    
    // MARK: - UI properties
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .title
        label.font = .subTitle4
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .hex828996
        label.font = .body4
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        addSubviews(titleLabel, dateLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(22)
            $0.horizontalEdges.equalToSuperview().inset(24)
        }
        dateLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(4)
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.bottom.equalToSuperview().inset(16)
        }
    }
    
    func draw(title: String, date: String) {
        titleLabel.text = title
        if let date = date.convertAPIDateToDate() {
            dateLabel.text = date.convertToYearMonthDayString()
        } else {
            dateLabel.text = ""
        }
    }
}
