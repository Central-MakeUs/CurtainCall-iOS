//
//  ProductDetailMainViewController.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/07/27.
//

import UIKit

import Moya
import CombineMoya
import Combine

final class ProductDetailMainViewController: UIViewController {
    
    // MARK: - UI properties
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .clear
        scrollView.bounces = false
        return scrollView
    }()
    
    private let contentView = UIView()
    
    private let navigationView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private let backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: ImageNamespace.navigationBackButtonWhite), for: .normal)
        return button
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .subTitle4
        label.textColor = .white
        label.text = "비스티"
        return label
    }()
    
    private let headerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private let headerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: ImageNamespace.productHeader)
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
//        imageView.image = UIImage(named: "dummy_poster")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 15
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let categoryView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        return view
    }()
    
    private let categoryLabel: UILabel = {
        let label = UILabel()
        label.text = "뮤지컬"
        label.font = .body4
        label.textColor = .title
        return label
    }()
    
    private let productTitleLabel: UILabel = {
        let label = UILabel()
//        label.text = "비스티"
        label.font = .heading2
        label.textColor = .white
        return label
    }()
    
    private let reservationLabel: UILabel = {
        let label = UILabel()
        label.font = .body4
        label.textColor = .white
//        label.text = "예매율 29.0% |"
        return label
    }()
    
    private let startImageView = StarImageView(isEmpty: false)
    
    private let gradeLabel: UILabel = {
        let label = UILabel()
        label.font = .body4
        label.textColor = .white
//        label.text = "4.8"
        return label
    }()
    
    private let gradeCountLabel: UILabel = {
        let label = UILabel()
        label.font = .body4
        label.textColor = .white
//        label.text = "(324)"
        return label
    }()
    
    private let keepButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: ImageNamespace.productKeepDeselect), for: .normal)
        button.setBackgroundImage(UIImage(named: ImageNamespace.productKeepSelect), for: .selected)
        return button
    }()
    
    private let infoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 4
        return stackView
    }()
    
    private let duringStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 14
        return stackView
    }()
    
    private let duringLabel: UILabel = {
        let label = UILabel()
        label.text = "공연기간"
        label.font = .body3
        label.textColor = .white
        return label
    }()
    
    private let duringProductLabel: UILabel = {
        let label = UILabel()
//        label.text = "2023.6.1 ~ 2023.6.18"
        label.font = .body3
        label.textColor = .white
        return label
    }()
    
    private let runningTimeStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 14
        return stackView
    }()
    
    private let runningTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "관람시간"
        label.font = .body3
        label.textColor = .white
        return label
    }()
    
    private let runningTimeProductLabel: UILabel = {
        let label = UILabel()
        label.text = "200분"
        label.font = .body3
        label.textColor = .white
        return label
    }()
    
    private let ageStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 14
        return stackView
    }()
    
    private let ageLabel: UILabel = {
        let label = UILabel()
        label.text = "관람연령"
        label.font = .body3
        label.textColor = .white
        return label
    }()
    
    private let ageProductLabel: UILabel = {
        let label = UILabel()
//        label.text = "14세 이상 관람가능"
        label.font = .body3
        label.textColor = .white
        return label
    }()
    
    private let priceStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 14
        return stackView
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.text = "티켓가격"
        label.font = .body3
        label.textColor = .white
        return label
    }()
    
    private let priceProductLabel: UILabel = {
        let label = UILabel()
//        label.text = "R석 99,000원|S석 77,000원|A석 44,000원"
        label.font = .body3
        label.textColor = .white
        return label
    }()
    
    private let locationStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 14
        return stackView
    }()
    
    private let locationLabel: UILabel = {
        let label = UILabel()
        label.text = "장소"
        label.font = .body3
        label.textColor = .white
        return label
    }()
    
    private let locationProductLabel: UILabel = {
        let label = UILabel()
//        label.text = "LG아트센터 서울 LG SIGNATURE 홀"
        label.font = .body3
        label.textColor = .white
        return label
    }()
    
    private let buttonView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 30
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return view
    }()
    
    private let buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 56
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private let detailButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: ImageNamespace.detailInfoButtonDeselect), for: .normal)
        button.setImage(UIImage(named: ImageNamespace.detailInfoButtonSelect), for: .selected)
        return button
    }()
    
    private let infoButtonLabel: UILabel = {
        let label = UILabel()
        label.text = "상세 정보"
        label.font = .body1
        label.textColor = .title
        return label
    }()
    
    private let reviewButtonLabel: UILabel = {
        let label = UILabel()
        label.text = "한 줄 리뷰"
        label.font = .body1
        label.textColor = .title
        return label
    }()
    
    private let lostButtonLabel: UILabel = {
        let label = UILabel()
        label.text = "분실물"
        label.font = .body1
        label.textColor = .title
        return label
    }()
    
    private let reviewButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: ImageNamespace.detailReviewButtonDeselect), for: .normal)
        button.setImage(UIImage(named: ImageNamespace.detailReviewButtonSelect), for: .selected)
        return button
    }()
    
    private let lostItemButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: ImageNamespace.detailLostButtonDeselect), for: .normal)
        button.setImage(UIImage(named: ImageNamespace.detailLostButtonSelect), for: .selected)
        return button
    }()

    private let detailInfoView = DetailInfoView()
    private let detailReviewView = DetailReviewView()
    private let detailLostItemView = DetailLostItemView()
    
    
    // MARK: - Properties
    private let provider = MoyaProvider<ProductAPI>()
    private var subscriptions: Set<AnyCancellable> = []
    private let reviewProvider = MoyaProvider<ReviewAPI>()
    private let id: String
    private var product: ProductDetailResponse?
    
    // MARK: - Lifecycles
    
    init(id: String) {
        self.id = id
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        addTarget()
        setupInfoView()
        detailReviewView.delegate = self
        detailLostItemView.delegate = self
        subButtonTouchUpInside(detailButton)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        requestShowDetail(id: id)
        requestReviewList(id: id)
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    // MARK: - Helpers
    
    private func configureUI() {
        configureSubviews()
        configureConstraints()
    }
    
    private func configureSubviews() {
        view.backgroundColor = .white
        view.addSubviews(headerImageView, navigationView, scrollView)
        scrollView.addSubviews(contentView)
        contentView.addSubviews(
            headerView, buttonStackView, detailInfoView
        )
        headerView.addSubviews(
            posterImageView, categoryView, productTitleLabel,
            reservationLabel, startImageView, gradeLabel, gradeCountLabel, infoStackView,
            buttonView, keepButton
        )
        buttonView.addSubviews(buttonStackView, infoButtonLabel, reviewButtonLabel, lostButtonLabel)
        infoStackView.addArrangedSubviews(
            duringStackView, runningTimeStackView, ageStackView, priceStackView, locationStackView
        )
        duringStackView.addArrangedSubviews(duringLabel, duringProductLabel)
        runningTimeStackView.addArrangedSubviews(runningTimeLabel, runningTimeProductLabel)
        ageStackView.addArrangedSubviews(ageLabel, ageProductLabel)
        priceStackView.addArrangedSubviews(priceLabel, priceProductLabel)
        locationStackView.addArrangedSubviews(locationLabel, locationProductLabel)
        
        categoryView.addSubview(categoryLabel)
        navigationView.addSubviews(backButton, titleLabel)
        buttonStackView.addArrangedSubviews(detailButton, reviewButton, lostItemButton)
    }
    
    private func configureConstraints() {
        navigationView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(40)
        }
        backButton.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.centerY.equalToSuperview()
        }
        titleLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        scrollView.snp.makeConstraints {
            $0.top.equalTo(navigationView.snp.bottom)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalToSuperview()
        }
        contentView.snp.makeConstraints {
            $0.edges.equalTo(scrollView.contentLayoutGuide)
            $0.width.equalTo(scrollView.frameLayoutGuide)
        }
        headerView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
        }
        
        headerImageView.snp.makeConstraints {
            $0.top.trailing.leading.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-50)
        }
        posterImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(30)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(170)
            $0.height.equalTo(226)
        }
        
        categoryView.snp.makeConstraints {
            $0.top.equalTo(posterImageView.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(24)
            $0.height.equalTo(24)
        }
        
        categoryLabel.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview().inset(4)
            $0.horizontalEdges.equalToSuperview().inset(10)
        }
        
        productTitleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(24)
            $0.top.equalTo(categoryView.snp.bottom).offset(10)
        }
        
        keepButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-24)
            $0.centerY.equalTo(productTitleLabel)
        }
        
        reservationLabel.snp.makeConstraints {
            $0.top.equalTo(productTitleLabel.snp.bottom).offset(8)
            $0.leading.equalToSuperview().offset(24)
        }
        startImageView.snp.makeConstraints {
            $0.centerY.equalTo(reservationLabel)
            $0.leading.equalTo(reservationLabel.snp.trailing).offset(5)
        }
        
        gradeLabel.snp.makeConstraints {
            $0.centerY.equalTo(reservationLabel)
            $0.leading.equalTo(startImageView.snp.trailing).offset(2)
        }
        
        gradeCountLabel.snp.makeConstraints {
            $0.centerY.equalTo(reservationLabel)
            $0.leading.equalTo(gradeLabel.snp.trailing).offset(3)
        }
        
        infoStackView.snp.makeConstraints {
            $0.top.equalTo(reservationLabel.snp.bottom).offset(30)
            $0.leading.equalToSuperview().offset(24)
        }
        [duringLabel, runningTimeLabel, ageLabel, priceLabel, locationLabel].forEach {
            $0.snp.makeConstraints { make in make.width.equalTo(52) }
        }
        buttonView.snp.makeConstraints {
            $0.top.equalTo(infoStackView.snp.bottom).offset(40)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(128)
            $0.bottom.equalToSuperview()
        }
        
        buttonStackView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(26)
            $0.horizontalEdges.equalToSuperview().inset(52)
        }
        
        infoButtonLabel.snp.makeConstraints {
            $0.top.equalTo(detailButton.snp.bottom).offset(10)
            $0.centerX.equalTo(detailButton)
        }
        
        reviewButtonLabel.snp.makeConstraints {
            $0.top.equalTo(reviewButton.snp.bottom).offset(10)
            $0.centerX.equalTo(reviewButton)
        }
        
        lostButtonLabel.snp.makeConstraints {
            $0.top.equalTo(lostItemButton.snp.bottom).offset(10)
            $0.centerX.equalTo(lostItemButton)
        }
        
        [detailButton, reviewButton, lostItemButton].forEach { button in
            button.snp.makeConstraints { make in
                make.height.equalTo(button.snp.width)
            }
        }
    }
    
    private func addTarget() {
        [detailButton, reviewButton, lostItemButton].forEach {
            $0.addTarget(self, action: #selector(subButtonTouchUpInside), for: .touchUpInside)
        }
        keepButton.addTarget(self, action: #selector(keepButtonTouchUpInside), for: .touchUpInside)
        backButton.addTarget(self, action: #selector(backButtonTouchUpInside), for: .touchUpInside)
    }
    
    @objc
    private func backButtonTouchUpInside() {
        dismiss(animated: true)
    }
    
    @objc
    private func subButtonTouchUpInside(_ sender: UIButton) {
        sender.isSelected = true
        switch sender {
        case detailButton:
            setupInfoView()
            reviewButton.isSelected = false
            lostItemButton.isSelected = false
        case reviewButton:
            setupReviewView()
            detailButton.isSelected = false
            lostItemButton.isSelected = false
        case lostItemButton:
            setupLostItemView()
            detailButton.isSelected = false
            reviewButton.isSelected = false
        default:
            fatalError("Error: Not Button")
        }
    }
    
    private func setupInfoView() {
        contentView.addSubview(detailInfoView)
        
        detailReviewView.removeFromSuperview()
        detailLostItemView.removeFromSuperview()
        
        detailInfoView.snp.makeConstraints {
            $0.top.equalTo(buttonView.snp.bottom)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
    private func setupReviewView() {
        contentView.addSubview(detailReviewView)
        
        detailInfoView.removeFromSuperview()
        detailLostItemView.removeFromSuperview()
        
        detailReviewView.snp.makeConstraints {
            $0.top.equalTo(buttonView.snp.bottom)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
    private func setupLostItemView() {
        contentView.addSubview(detailLostItemView)
        
        detailReviewView.removeFromSuperview()
        detailInfoView.removeFromSuperview()
        
        detailLostItemView.snp.makeConstraints {
            $0.top.equalTo(buttonView.snp.bottom)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }

    @objc
    func keepButtonTouchUpInside() {
        keepButton.isSelected.toggle()
    }
    
    private func requestShowDetail(id: String) {
        provider.requestPublisher(.detail(id: id))
            .sink { completion in
                if case let .failure(error) = completion {
                    print(error.localizedDescription)
                    return
                }
            } receiveValue: { [weak self] response in
                guard let self else { return }
                if let data = try? response.map(ProductDetailResponse.self) {
                    product = data
                    draw(data: data)
                } else {
                    print("@@DECODE ERROR")
                }
            }.store(in: &subscriptions)

    }
    
    private func requestReviewList(id: String) {
        reviewProvider.requestPublisher(.list(id: id, page: 0, size: 20))
            .sink { completion in
                if case let .failure(error) = completion {
                    print(error.localizedDescription)
                    return
                }
            } receiveValue: { [weak self] response in
                if let data = try? response.map(ShowReviewResponse.self) {
                    print("####", data)
                    if data.content.isEmpty {
                        self?.detailReviewView.setEmptyView()
                    } else {
                        self?.detailReviewView.reviewInfos = data.content
                        self?.detailReviewView.setTableView()
                        self?.detailReviewView.tableView.reloadData()
                    }
                }
            }.store(in: &subscriptions)
    }
    
    private func draw(data: ProductDetailResponse) {
        titleLabel.text = data.name
        if let url = URL(string: data.poster) {
            posterImageView.kf.setImage(with: url)
        } else {
            posterImageView.image = nil
        }
        categoryLabel.text = data.genre == "PLAY" ? "연극" : "뮤지컬"
        productTitleLabel.text = data.name
        gradeLabel.text = String(format: "%.1f", data.reviewGradeSum / data.reviewCount)
        gradeCountLabel.text = "(" + String(Int(data.reviewCount)) + ")"
        duringProductLabel.text = data.startDate + " ~ " + data.endDate
        runningTimeProductLabel.text = data.runtime
        ageProductLabel.text = data.age
        priceProductLabel.text = data.ticketPrice
        locationProductLabel.text = data.facilityName
        detailReviewView.titleLabel.text = "총 \(Int(data.reviewCount))개의 한 줄 리뷰"
    }
}

extension ProductDetailMainViewController: DetailReviewViewDelegate {
    func didTappedDetailReviewViewInAllViewButton() {
        guard let product else { return }
        show(ReviewViewController(product: product, id: id), sender: nil)
    }
}

extension ProductDetailMainViewController: DetailLostItemViewDelegate {
    func didTappedLostViewInAllViewButton() {
        show(LostItemViewController(), sender: nil)
    }
}
