//
//  ProductSearchCell.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/07/27.
//

import UIKit

import Kingfisher

final class ProductSearchCell: UICollectionViewCell {
    
    // MARK: - UI properties
    
    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.layer.cornerRadius = 12
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let productTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .title
        label.font = .subTitle3
        return label
    }()
    
    private let starStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 2
        return stackView
    }()
    
    private let starImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: ImageNamespace.productStarSymbol)
        return imageView
    }()
    
    private let starGradeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .hex3B4350
        label.font = .body3
        return label
    }()
    
    private let starCountLabel: UILabel = {
        let label = UILabel()
        label.textColor = .hex828996
        label.font = .body3
        return label
    }()
    
    private let infoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()
    
    private let duringStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 15
        return stackView
    }()
    
    private let duringLabel: UILabel = {
        let label = UILabel()
        label.text = "기간"
        label.textColor = .hex828996
        label.font = .body4
        return label
    }()
    
    private let productDuringLabel: UILabel = {
        let label = UILabel()
        label.textColor = .body1
        label.font = .body4
        return label
    }()
    
    private let runningTimeStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 15
        return stackView
    }()
    
    private let runningTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "시간"
        label.textColor = .hex828996
        label.font = .body4
        return label
    }()
    
    private let productRunningTimeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .body1
        label.font = .body4
        return label
    }()
    
    private let scheduleStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 15
        return stackView
    }()
    
    private let scheduleLabel: UILabel = {
        let label = UILabel()
        label.text = "일정"
        label.textColor = .hex828996
        label.font = .body4
        return label
    }()
    
    private let productScheduleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .body1
        label.font = .body4
        return label
    }()
    
    private let scheduleSubStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 15
        return stackView
    }()
    
    private let scheduleSubLabel: UILabel = {
        let label = UILabel()
        label.text = "시간"
        label.textColor = .white
        label.font = .body4
        return label
    }()
    
    private let productScheduleSubLabel: UILabel = {
        let label = UILabel()
        label.textColor = .body1
        label.font = .body4
        return label
    }()
    
    private let locationStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 15
        return stackView
    }()
    
    private let locationLabel: UILabel = {
        let label = UILabel()
        label.text = "장소"
        label.textColor = .hex828996
        label.font = .body4
        return label
    }()
    
    private let productLocationLabel: UILabel = {
        let label = UILabel()
        label.textColor = .body1
        label.font = .body4
        label.textAlignment = .left
        return label
    }()
    
    private let borderView: UIView = {
        let view = UIView()
        view.backgroundColor = .hexF2F3F5
        return view
    }()
    
    private let keepButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: ImageNamespace.productKeepDeselect), for: .normal)
        button.setBackgroundImage(UIImage(named: ImageNamespace.productKeepSelect), for: .selected)
        return button
    }()
    
    // MARK: - Properties
    
    var id: String?
    
    // MARK: - Lifecycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(setKeepButton),
            name: Notification.Name("setKeepButton"),
            object: nil
        )
    }
    
    @available (*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    private func configureUI() {
        configureSubviews()
        configureConstraints()
    }
    
    private func configureSubviews() {
        addSubviews(
            posterImageView, productTitleLabel, keepButton, starStackView, infoStackView,
            borderView, keepButton
        )
        starStackView.addArrangedSubviews(starImageView, starGradeLabel, starCountLabel)
        infoStackView.addArrangedSubviews(
            duringStackView, runningTimeStackView, scheduleStackView,
            scheduleSubStackView, locationStackView
        )
        duringStackView.addArrangedSubviews(duringLabel, productDuringLabel)
        runningTimeStackView.addArrangedSubviews(runningTimeLabel, productRunningTimeLabel)
        scheduleStackView.addArrangedSubviews(scheduleLabel, productScheduleLabel)
        scheduleSubStackView.addArrangedSubviews(scheduleSubLabel, productScheduleSubLabel)
        locationStackView.addArrangedSubviews(locationLabel, productLocationLabel)
    }
    
    private func configureConstraints() {
        posterImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(24)
            $0.leading.equalToSuperview()
            $0.height.equalTo(160)
            $0.width.equalTo(120)
        }
        keepButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(24)
            $0.trailing.equalToSuperview()
        }
        productTitleLabel.snp.makeConstraints {
            $0.leading.equalTo(posterImageView.snp.trailing).offset(14)
            $0.trailing.equalToSuperview().inset(25)
            $0.top.equalTo(posterImageView.snp.top)
        }
        starStackView.snp.makeConstraints {
            $0.leading.equalTo(posterImageView.snp.trailing).offset(14)
            $0.top.equalTo(productTitleLabel.snp.bottom).offset(4)
        }
        infoStackView.snp.makeConstraints {
            $0.leading.equalTo(posterImageView.snp.trailing).offset(14)
            $0.trailing.equalToSuperview()
            $0.top.equalTo(starStackView.snp.bottom).offset(8)
        }
        borderView.snp.makeConstraints {
            $0.top.equalTo(posterImageView.snp.bottom).offset(24)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(1)
        }
        [duringLabel, runningTimeLabel, scheduleLabel, scheduleSubLabel, locationLabel].forEach {
            $0.snp.makeConstraints { make in
                make.width.equalTo(25)
            }
        }
        [productDuringLabel, productRunningTimeLabel, productScheduleLabel, productScheduleSubLabel, productLocationLabel].forEach {
            $0.snp.makeConstraints {
                $0.trailing.equalToSuperview().inset(5)
            }
        }
    }
    
    func draw(item: ProductListContent) {
        if let url = URL(string: item.poster) {
            posterImageView.kf.indicatorType = .activity
            posterImageView.kf.setImage(with: url)
        } else {
            posterImageView.image = nil
        }
        productTitleLabel.text = item.name
        if item.reviewGradeSum == 0 && item.reviewCount == 0 {
            starGradeLabel.text = "0"
        } else {
            starGradeLabel.text = String(format: "%.1f", item.reviewGradeSum / item.reviewCount)
        }
        starCountLabel.text = "(\(Int(item.reviewCount)))"
        productDuringLabel.text = item.startDate + " ~ " + item.endDate
        productRunningTimeLabel.text = item.runtime.isEmpty ? "정보 없음" : item.runtime
        keepButton.isSelected = FavoriteService.shared.isFavoriteIds.contains(item.id)
        let timeInfo = showTimeToDict(showTiems: item.showTimes)
        if timeInfo.count >= 2 {
            productScheduleLabel.text = timeInfo[0]
            productScheduleSubLabel.text = timeInfo[1]
            scheduleSubStackView.isHidden = false
        } else if timeInfo.count == 1 {
            productScheduleLabel.text = timeInfo[0]
            scheduleSubStackView.isHidden = true
        } else {
            productScheduleLabel.text = "정보 없음"
            scheduleSubStackView.isHidden = true
        }
        productLocationLabel.text = item.facilityName
        
    }
    
    func keepButtonSelect() {
        keepButton.isSelected = true
    }
    
    @objc
    func setKeepButton(_ notification: Notification) {
        guard let id else { return }
        keepButton.isSelected = FavoriteService.shared.isFavoriteIds.contains(id)

    }
    
    func showTimeToDict(showTiems: [ProductListShowTime]) -> [String] {
        var timeDict: [String: [(String, Int)]] = [:]
        showTiems.forEach {
            let time = $0.time.split(separator: ":").prefix(2).joined(separator: ":")
            guard let week = WeekDayAPI(rawValue: $0.dayOfWeek) else {
                return
            }
            timeDict[time, default: []].append(week.KRname)
        }
        var result: [String] = []
        timeDict.forEach {
            let sortedWeek = $0.value.sorted { $0.1 < $1.1 }.map { $0.0 }.joined(separator: ",")
            result.append(sortedWeek + " " +  $0.key)
        }
        return result
    }
}
