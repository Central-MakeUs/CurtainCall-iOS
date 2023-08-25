//
//  DetailLostItemView.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/07/28.
//

import UIKit

protocol DetailLostItemViewDelegate: AnyObject {
    func didTappedLostViewInAllViewButton()
}

final class DetailLostItemView: UIView {
    
    // MARK: UI Property
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "분실물 찾기"
        label.font = .subTitle3
        label.textColor = .title
        return label
    }()
    
    private let allViewButton: UIButton = {
        let button = UIButton()
        button.setTitle("모두 보기", for: .normal)
        button.titleLabel?.font = .body4
        button.setTitleColor(.pointColor2, for: .normal)
        button.layer.cornerRadius = 14
        button.layer.borderColor = UIColor.pointColor2?.cgColor
        button.layer.borderWidth = 1
        return button
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(LostItemCell.self, forCellReuseIdentifier: LostItemCell.identifier)
        tableView.separatorStyle = .none
        return tableView
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
        label.text = "아직 분실물이 없어요!"
        return label
    }()
    
    // MARK: Property
    
    weak var delegate: DetailLostItemViewDelegate?
    var lostItems: [LostItemContent] = []
    
    // MARK: Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        allViewButton.addTarget(
            self,
            action: #selector(allViewButtonTouchUpInside),
            for: .touchUpInside
        )
    }
    
    @available (*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Configure
    
    private func configureUI() {
        configureSubviews()
        configureConstraints()
    }
    
    private func configureSubviews() {
        backgroundColor = .white
        addSubviews(titleLabel, allViewButton, tableView)
    }
    
    private func configureConstraints() {
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(30)
            $0.leading.equalToSuperview().offset(24)
        }
        allViewButton.snp.makeConstraints {
            $0.centerY.equalTo(titleLabel)
            $0.trailing.equalToSuperview().inset(24)
            $0.width.equalTo(71)
        }
        tableView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(17)
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.height.equalTo(min(LostItemInfo.list.count, 3) * 95)
            $0.bottom.equalToSuperview()
        }
    }
    
    @objc
    private func allViewButtonTouchUpInside() {
        delegate?.didTappedLostViewInAllViewButton()
    }
    
    func setTableView() {
        tableView.snp.remakeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(17)
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.height.equalTo(min(lostItems.count, 3) * 95)
            $0.bottom.equalToSuperview()
        }
    }
    
    func setEmptyView() {
        addSubview(emptyView)
        emptyView.addSubviews(emptyImage, emptyLabel)
        emptyView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.height.equalTo(250)
        }
        emptyImage.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(-10)
        }
        emptyLabel.snp.makeConstraints {
            $0.top.equalTo(emptyImage.snp.bottom).offset(18)
            $0.centerX.equalToSuperview()
            
        }
        tableView.snp.remakeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(0)
        }

        setNeedsLayout()
    }
}

extension DetailLostItemView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return min(3, lostItems.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: LostItemCell.identifier) as? LostItemCell else {
            return UITableViewCell()
        }
        cell.draw(item: lostItems[indexPath.row])
        return cell
    }
}

extension DetailLostItemView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UITableView.automaticDimension
        return 95
    }
}

final class LostItemCell: UITableViewCell {
    
    private let wholeView: UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor.hexE4E7EC?.cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 10
        return view
    }()
    
    private let itemImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    private let itemLabel: UILabel = {
        let label = UILabel()
        label.textColor = .title
        label.font = UIFont(name: "SpoqaHanSansNeo-Bold", size: 14)
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .hex828996
        label.font = .caption
        return label
    }()
    
    private let locationLabel: UILabel = {
        let label = UILabel()
        label.textColor = .hex5A6271
        label.font = .body5
        label.numberOfLines = 2
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: .init(top: 0, left: 0, bottom: 12, right: 0))
    }
    
    
    func draw(item: LostItemContent) {
        if let urlString = item.imageUrl, let url = URL(string: urlString) {
            itemImageView.kf.setImage(with: url)
            itemImageView.kf.indicatorType = .activity
        } else {
            itemImageView.image = nil
        }
        itemLabel.text = item.title
//        dateLabel.text = item.date.convertToYearMonthDayString()
//        locationLabel.text = """
//                             습득 장소ㅣ\(item.getLocation)
//                             보관 장소ㅣ\(item.keepLocation)
//                             """
        locationLabel.text = """
                             습득 장소ㅣ\(item.facilityName)
                             """
    }
    
    private func configureUI() {
        configureSubviews()
        configureConstarints()
    }
    
    private func configureSubviews() {
        addSubviews(wholeView)
        wholeView.addSubviews(itemImageView, itemLabel, dateLabel, locationLabel)
    }
    
    private func configureConstarints() {
        wholeView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.bottom.equalToSuperview().inset(6)
        }
        itemImageView.snp.makeConstraints {
            $0.top.leading.bottom.equalToSuperview().inset(10)
            $0.size.equalTo(63)
        }
        
        itemLabel.snp.makeConstraints {
            $0.top.equalTo(itemImageView)
            $0.leading.equalTo(itemImageView.snp.trailing).offset(12)
        }
        
        dateLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(12)
            $0.trailing.equalToSuperview().offset(-10)
        }
        locationLabel.snp.makeConstraints {
            $0.top.equalTo(itemLabel.snp.bottom).offset(8)
            $0.leading.equalTo(itemImageView.snp.trailing).offset(12)
        }
    }
    
}
