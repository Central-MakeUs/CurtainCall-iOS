//
//  NoticeDetailViewController.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/08/22.
//

import UIKit
import Combine

final class NoticeDetailViewController: UIViewController {
    
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
    
    private let borderView: UIView = {
        let view = UIView()
        view.backgroundColor = .hexF5F6F8
        return view
    }()
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let contentLabel: UILabel = {
        let label = UILabel()
        label.font = .body3
        label.textColor = UIColor(rgb: 0x333C53)
        return label
    }()
    
    // MARK: - Properties
    
    private let viewModel: NoticeDetailViewModel
    private var subscriptions: Set<AnyCancellable> = []
    
    // MARK: - Lifecycles
    
    init(viewModel: NoticeDetailViewModel) {
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
        viewModel.requestDetail()
    }
    
    // MARK: - Helpers
    
    private func configureUI() {
        configureSubviews()
        configureConstraints()
        configureNavigation()
    }
    
    private func configureSubviews() {
        view.backgroundColor = .white
        view.addSubviews(titleLabel, dateLabel, borderView, scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(contentLabel)
    }
    
    private func configureConstraints() {
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(32)
            $0.leading.equalToSuperview().offset(24)
        }
        dateLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(4)
            $0.horizontalEdges.equalToSuperview().inset(24)
        }
        borderView.snp.makeConstraints {
            $0.top.equalTo(dateLabel.snp.bottom).offset(16)
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.height.equalTo(1)
        }
        scrollView.snp.makeConstraints {
            $0.top.equalTo(borderView.snp.bottom).offset(40)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaInsets)
        }
        contentView.snp.makeConstraints {
            $0.edges.equalTo(scrollView.contentLayoutGuide)
            $0.width.equalTo(scrollView.frameLayoutGuide)
        }
        contentLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.bottom.greaterThanOrEqualToSuperview().inset(24)
        }
    }
    
    private func configureNavigation() {
        configureBackbarButton()
        title = "공지사항"
    }
    
    private func bind() {
        viewModel.noticeDetailInfo
            .sink { [weak self] info in
                self?.draw(info: info)
            }.store(in: &subscriptions)
    }
    
    private func draw(info: NoticeDetailResponse) {
        titleLabel.text = info.title
        contentLabel.text = info.content
        if let date = info.createdAt.convertAPIDateToDate() {
            dateLabel.text = date.convertToYearMonthDayString()
        } else {
            dateLabel.text = ""
        }
    }
}
