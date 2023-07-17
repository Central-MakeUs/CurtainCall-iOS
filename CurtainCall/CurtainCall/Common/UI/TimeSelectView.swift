//
//  TimeSelectView.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/07/17.
//

import UIKit

import SnapKit

final class TimeSelectView: UIView {
    
    // MARK: - UI properties
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorInset.left = 20
        tableView.separatorInset.right = 20
        return tableView
    }()
    
    // MARK: - Properties
    
    private let times: [String]
    
    // MARK: - Lifecycles
    init(times: [String]) {
        self.times = times
        super.init(frame: .zero)
        configureUI()
        registerCell()
    }
    
    @available (*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    private func configureUI() {
        addSubview(tableView)
        tableView.snp.makeConstraints { $0.edges.equalToSuperview() }
    }
    
    private func registerCell() {
        tableView.register(
            TimeSelectCell.self,
            forCellReuseIdentifier: TimeSelectCell.identifier
        )
    }
}

extension TimeSelectView: UITableViewDelegate {
    
}

extension TimeSelectView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return times.count
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        guard let cell = tableView.dequeueCell(
            type: TimeSelectCell.self,
            indexPath: indexPath
        ) else { return UITableViewCell() }
        cell.setUI(time: times[indexPath.row])
        return cell
    }
    
    
}

final class TimeSelectCell: UITableViewCell {
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .black
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    @available (*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        addSubview(timeLabel)
        timeLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(26)
            $0.centerY.equalToSuperview()
        }
    }
    
    func setUI(time: String) {
        timeLabel.text = time
    }
}
