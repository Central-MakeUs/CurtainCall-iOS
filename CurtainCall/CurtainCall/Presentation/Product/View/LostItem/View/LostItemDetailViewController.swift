//
//  LostItemDetailViewController.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/08/05.
//

import UIKit

import Combine
import Moya
import CombineMoya

final class LostItemDetailViewController: UIViewController {
    
    // MARK: UI Property
    
    private let scrollView = UIScrollView()
    private let contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private let topView: UIView = {
        let view = UIView()
        view.backgroundColor = .hexF5F6F8
        return view
    }()
    
    private lazy var itemImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 15
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let midView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        
        return view
    }()
    
    private let itemNameView: UIView = {
        let view = UIView()
        view.backgroundColor = .pointColor1
        view.layer.cornerRadius = 10
        return view
    }()
    
    private lazy var itemNameLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = .white
        label.font = .subTitle4
        return label
    }()
    
    private let infoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 18
        return stackView
    }()
    
    private let categoryView = UIView()
    
    private let categoryImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: ImageNamespace.lostItemDetailCategory)
        return imageView
    }()
    
    private let categoryTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .body1
        label.textColor = .hex5A6271
        label.text = "분류"
        return label
    }()
    
    private lazy var categoryLabel: UILabel = {
        let label = UILabel()
        label.font = .body1
        label.textColor = .body1
        return label
    }()
    
    private let locationView = UIView()
    
    private let locationImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: ImageNamespace.lostItemDetailLocationSearching)
        return imageView
    }()
    
    private let locationTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .body1
        label.textColor = .hex5A6271
        label.text = "습득장소"
        return label
    }()
    
    private lazy var locationLabel: UILabel = {
        let label = UILabel()
        label.font = .body1
        label.textColor = .body1
        
        return label
    }()
    
    private let locationDetailView = UIView()
    
    private let locationDetailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: ImageNamespace.lostItemDetailMyLocation)
        return imageView
    }()
    
    private let locationDetailTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .body1
        label.textColor = .hex5A6271
        label.text = "세부장소"
        return label
    }()
    
    private lazy var locationDetailLabel: UILabel = {
        let label = UILabel()
        label.font = .body1
        label.textColor = .body1
        
        return label
    }()
    
    private let dateView = UIView()
    
    private let dateImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: ImageNamespace.lostItemDetailEventAvailable)
        return imageView
    }()
    
    private let dateTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .body1
        label.textColor = .hex5A6271
        label.text = "습득일자"
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = .body1
        label.textColor = .body1
        
        return label
    }()
    
    private let timeView = UIView()
    
    private let timeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: ImageNamespace.lostItemDetailAlarmOn)
        return imageView
    }()
    
    private let timeTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .body1
        label.textColor = .hex5A6271
        label.text = "습득시간"
        return label
    }()
    
    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.font = .body1
        label.textColor = .body1
        return label
    }()
    
    private let otherView = UIView()
    
    private let otherImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: ImageNamespace.lostItemDetailCategory)
        return imageView
    }()
    
    private let otherTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .body1
        label.textColor = .hex5A6271
        label.text = "특이사항"
        return label
    }()
    
    private let otherLabel: UILabel = {
        let label = UILabel()
        label.font = .body1
        label.textColor = .body1
        return label
    }()
    
    private let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .hexF5F6F8
        return view
    }()
    
    private let bottomView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private let bottomStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()
    
    private lazy var keepLocationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SpoqaHanSansNeo-Regular", size: 14)
        label.textColor = UIColor(rgb: 0x636363)
//        label.text = "보관장소   \(item.keepLocation)"
        return label
    }()
    
    private lazy var phoneNumberLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SpoqaHanSansNeo-Regular", size: 14)
        label.textColor = UIColor(rgb: 0x636363)
//        label.text = "전화번호   02-1234-5678"
        return label
    }()
    
    // MARK: Property
    
    private let id: Int
    private var subscriptions: Set<AnyCancellable> = []
    
    // MARK: Life Cycle
    
    init(id: Int) {
        self.id = id
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .hexF5F6F8
        configureUI()
        requestDetail()
    }
    
    // MARK: Configure
    
    private func configureUI() {
        configureSubviews()
        cofigureConstraints()
        configureNavigation()
        
    }
    
    private func configureSubviews() {
        view.addSubviews(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubviews(topView, midView, separatorView, bottomView)
        topView.addSubview(itemImageView)
        midView.addSubview(itemNameView)
        itemNameView.addSubview(itemNameLabel)
        midView.addSubview(infoStackView)
        infoStackView.addArrangedSubviews(
            categoryView, locationView, locationDetailView,
            dateView, timeView, otherView
        )
        categoryView.addSubviews(categoryImageView, categoryTitleLabel, categoryLabel)
        locationView.addSubviews(locationImageView, locationTitleLabel, locationLabel)
        locationDetailView.addSubviews(locationDetailImageView, locationDetailTitleLabel, locationDetailLabel)
        dateView.addSubviews(dateImageView, dateTitleLabel, dateLabel)
        timeView.addSubviews(timeImageView, timeTitleLabel, timeLabel)
        otherView.addSubviews(otherImageView, otherTitleLabel, otherLabel)
        bottomView.addSubviews(bottomStackView)
        bottomStackView.addArrangedSubviews(keepLocationLabel, phoneNumberLabel)
    }
    
    private func cofigureConstraints() {
        scrollView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalToSuperview()
        }
        contentView.snp.makeConstraints {
            $0.edges.equalTo(scrollView.contentLayoutGuide)
            $0.width.equalTo(scrollView.frameLayoutGuide)
        }
        
        topView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(270)
        }
        itemImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(30)
            $0.size.equalTo(200)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-30)
        }
        midView.snp.makeConstraints {
            $0.top.equalTo(topView.snp.bottom)
            $0.horizontalEdges.equalToSuperview()
        }
        itemNameView.snp.makeConstraints {
            $0.top.equalTo(20)
            $0.leading.equalTo(24)
        }
        itemNameLabel.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview().inset(10)
            $0.horizontalEdges.equalToSuperview().inset(12)
        }
        
        [categoryView, locationView, locationDetailView, dateView, timeView, otherView].forEach {
            $0.snp.makeConstraints { make in
                make.height.equalTo(22)
                make.horizontalEdges.equalToSuperview()
            }
        }
        infoStackView.snp.makeConstraints {
            $0.top.equalTo(itemNameView.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.bottom.equalToSuperview().inset(70)
        }
        
        categoryImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview()
        }
        categoryTitleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(categoryImageView.snp.trailing).offset(8)
            $0.width.equalTo(60)
        }
        categoryLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(categoryTitleLabel.snp.trailing).offset(20)
        }
        
        locationImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview()
        }
        locationTitleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(locationImageView.snp.trailing).offset(8)
            $0.width.equalTo(60)
        }
        locationLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(locationTitleLabel.snp.trailing).offset(20)
        }
        
        locationDetailImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview()
        }
        locationDetailTitleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(locationDetailImageView.snp.trailing).offset(8)
            $0.width.equalTo(60)
        }
        locationDetailLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(locationDetailTitleLabel.snp.trailing).offset(20)
        }
        
        dateImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview()
        }
        dateTitleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(categoryImageView.snp.trailing).offset(8)
            $0.width.equalTo(60)
        }
        dateLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(categoryTitleLabel.snp.trailing).offset(20)
        }
        
        timeImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview()
        }
        timeTitleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(categoryImageView.snp.trailing).offset(8)
            $0.width.equalTo(60)
        }
        timeLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(categoryTitleLabel.snp.trailing).offset(20)
        }
        
        otherImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview()
        }
        otherTitleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(categoryImageView.snp.trailing).offset(8)
            $0.width.equalTo(60)
        }
        otherLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(categoryTitleLabel.snp.trailing).offset(20)
        }
        
        separatorView.snp.makeConstraints {
            $0.top.equalTo(midView.snp.bottom)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(5)
        }
        
        bottomView.snp.makeConstraints {
            $0.top.equalTo(separatorView.snp.bottom)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        bottomStackView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(37)
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.bottom.equalToSuperview().inset(52)
        }
    }
    
    private func configureNavigation() {
        configureBackbarButton()
        title = "분실물 찾기"
        let reportButton = UIBarButtonItem(
            title: nil,
            image: UIImage(named: ImageNamespace.navigationReportButton),
            target: self,
            action: #selector(reportButtonTouchUpInside)
        )
        navigationItem.rightBarButtonItem = reportButton
        navigationItem.rightBarButtonItem?.tintColor = .hex828996
    }
    
    private func requestDetail() {
        let provider = MoyaProvider<LostItemService>()
        provider.requestPublisher(.detail(id: id))
            .sink { completion in
                if case let .failure(error) = completion {
                    print(error)
                    return
                }
            } receiveValue: { [weak self] response in
                guard let self else { return }
                
                if let data = try? response.map(LostItemDetailResponse.self) {
                    draw(info: data)
                    
                }
            }.store(in: &subscriptions)
    }
    
    private func draw(info: LostItemDetailResponse) {
        if let url = URL(string: info.imageUrl) {
            itemImageView.kf.setImage(with: url)
            itemImageView.kf.indicatorType = .activity
        } else {
            itemImageView.image = nil
        }
        itemNameLabel.text = info.title
        let type = LostItemCategoryType(apiName: info.type)
        categoryLabel.text = type.name
        locationLabel.text = info.facilityName
        locationDetailLabel.text = info.foundPlaceDetail.isEmpty ? "정보 없음" : info.foundPlaceDetail
        dateLabel.text = info.foundDate
        if let foundTimte = info.foundTime {
            timeLabel.text = foundTimte
            timeView.isHidden = false
        } else {
            timeView.isHidden = true
        }
        otherLabel.text = info.particulars
        
        keepLocationLabel.text = "보관장소   \(info.facilityName)"
        phoneNumberLabel.text = "전화번호   \(info.facilityPhone)"
    }
    
    @objc
    private func reportButtonTouchUpInside() {
        let reportViewController = ReportViewController(viewModel: ReportViewModel(id: id, type: .lostItem))
        navigationController?.pushViewController(reportViewController, animated: true)
    }
}
