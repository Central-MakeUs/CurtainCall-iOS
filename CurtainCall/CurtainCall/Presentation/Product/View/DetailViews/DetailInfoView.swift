//
//  DetailInfoView.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/07/28.
//

import UIKit

import NMapsMap

final class DetailInfoView: UIView {
    
    // MARK: UI Property
    
    private let introductionStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        return stackView
    }()
    
    private let introductionImageView1: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.isHidden = true
        return imageView
    }()
    private let introductionImageView2: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.isHidden = true
        return imageView
    }()
    private let introductionImageView3: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.isHidden = true
        return imageView
    }()
    private let introductionImageView4: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.isHidden = true
        return imageView
    }()
    private let introductionImageView5: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.isHidden = true
        return imageView
    }()
    
    private lazy var introductionImageViews: [UIImageView] = [
        introductionImageView1, introductionImageView2, introductionImageView3,
        introductionImageView4, introductionImageView5
    ]
    
    private let timeTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "공연시간"
        label.font = .subTitle3
        label.textColor = .title
        return label
    }()
    
    //    private let reservationDotView: UIView = {
    //        let view = UIView()
    //        view.backgroundColor = .body1
    //        view.layer.cornerRadius = 3
    //        return view
    //    }()
    //
    //    private let reservationLabel: UILabel = {
    //        let label = UILabel()
    //        label.text = "예매 가능 시간: 관람 2시간 전까지"
    //        label.textColor = .body1
    //        label.font = .body3
    //        return label
    //    }()
    
    private let duringDotView: UIView = {
        let view = UIView()
        view.backgroundColor = .body1
        view.layer.cornerRadius = 3
        return view
    }()
    
    private let duringLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .body3
        label.textColor = .body1
        return label
    }()
    
    private let infoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 6
        return stackView
    }()
    
    private let locationTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "장소 정보"
        label.font = .subTitle3
        label.textColor = .title
        return label
    }()
    
    private let concertHallStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 20
        return stackView
    }()
    
    private let concertHallTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "공연장명"
        label.font = .body3
        label.textColor = .hex5A6271
        return label
    }()
    
    private let concertHallLabel: UILabel = {
        let label = UILabel()
        label.text = "LG 아트센터 서울"
        label.textAlignment = .left
        label.font = UIFont(name: "SpoqaHanSansNeo-Regular", size: 14)
        label.textColor = .body1
        return label
    }()
    
    private let addressStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 20
        return stackView
    }()
    
    private let addressTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "주소"
        label.font = .body3
        label.textColor = .hex5A6271
        return label
    }()
    
    private let addressLabel: UILabel = {
        let label = UILabel()
        label.text = "서울 강서구 마곡중앙로 136"
        label.textAlignment = .left
        label.font = UIFont(name: "SpoqaHanSansNeo-Regular", size: 14)
        label.textColor = .body1
        return label
    }()
    
    private let phoneStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 20
        return stackView
    }()
    
    private let phoneTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "전화번호"
        label.font = .body3
        label.textColor = .hex5A6271
        return label
    }()
    
    private let phoneLabel: UILabel = {
        let label = UILabel()
        label.text = "1661-0070"
        label.textAlignment = .left
        label.font = UIFont(name: "SpoqaHanSansNeo-Regular", size: 14)
        label.textColor = .body1
        return label
    }()
    
    private let websiteStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 20
        return stackView
    }()
    
    private let websiteTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "웹사이트"
        label.font = .body3
        label.textColor = .hex5A6271
        return label
    }()
    
    private let websiteLabel: UILabel = {
        let label = UILabel()
        label.text = "https://www.lgart.com/"
        label.font = UIFont(name: "SpoqaHanSansNeo-Regular", size: 14)
        label.textColor = .body1
        return label
    }()
    
    private let mapView: NMFMapView = {
        let mapView = NMFMapView(frame: .zero)
        
        return mapView
    }()
    
    private let emptyView = UIView()
    
    // MARK: Property
    
    var content: FacilityResponse?
    var introductionImages: [String] = []
    var showTime: [ProductDetailShowTime] = []
    
    // MARK: Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        LodingIndicator.showLoading()
        configureUI()
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
        addSubviews(
            timeTitleLabel, duringDotView, duringLabel,
            locationTitleLabel, infoStackView, mapView, emptyView, introductionStackView
        )
        introductionStackView.addArrangedSubviews(
            introductionImageView1, introductionImageView2,
            introductionImageView3, introductionImageView4,
            introductionImageView5
        )
        infoStackView.addArrangedSubviews(
            concertHallStackView, addressStackView, phoneStackView, websiteStackView
        )
        concertHallStackView.addArrangedSubviews(concertHallTitleLabel, concertHallLabel)
        addressStackView.addArrangedSubviews(addressTitleLabel, addressLabel)
        phoneStackView.addArrangedSubviews(phoneTitleLabel, phoneLabel)
        websiteStackView.addArrangedSubviews(websiteTitleLabel, websiteLabel)
    }
    
    private func configureConstraints() {
        introductionStackView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
        }
        
        timeTitleLabel.snp.makeConstraints {
            $0.top.equalTo(introductionStackView.snp.bottom).offset(30)
            $0.leading.equalToSuperview().offset(24)
        }
        duringDotView.snp.makeConstraints {
            $0.top.equalTo(timeTitleLabel.snp.bottom).offset(19)
            $0.leading.equalToSuperview().offset(24)
            $0.size.equalTo(6)
        }
        duringLabel.snp.makeConstraints {
            $0.top.equalTo(timeTitleLabel.snp.bottom).offset(10)
            $0.leading.equalTo(duringDotView.snp.trailing).offset(10)
        }
        locationTitleLabel.snp.makeConstraints {
            $0.top.equalTo(duringLabel.snp.bottom).offset(30)
            $0.leading.equalTo(24)
        }
        
        [concertHallTitleLabel, addressTitleLabel, phoneTitleLabel, websiteTitleLabel].forEach {
            $0.snp.makeConstraints { make in
                make.width.equalTo(52)
            }
        }
        
        infoStackView.snp.makeConstraints {
            $0.top.equalTo(locationTitleLabel.snp.bottom).offset(10)
            //            $0.leading.equalTo(24)
            $0.horizontalEdges.equalToSuperview().inset(24)
        }
        
        mapView.snp.makeConstraints {
            $0.top.equalTo(infoStackView.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.height.equalTo(152)
        }
        emptyView.snp.makeConstraints {
            $0.top.equalTo(mapView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.height.equalTo(20)
        }
    }
    
    func draw() {
        guard let content else { return }
        phoneLabel.text = content.phone.isEmpty ? "정보 없음" : content.phone
        addressLabel.text = content.address.isEmpty ? "정보 없음" : content.address
        concertHallLabel.text = content.name.isEmpty ? "정보 없음" : content.name
        websiteLabel.text = content.homepage.isEmpty ? "정보 없음"
        : content.homepage
        let marker = NMFMarker(position: NMGLatLng(lat: content.latitude, lng: content.longitude))
        let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: content.latitude, lng: content.longitude), zoomTo: 15)
        mapView.moveCamera(cameraUpdate)
        marker.mapView = mapView
        let during = showTimeToDict(showTiems: showTime).joined(separator: "\n")
        duringLabel.text = during.isEmpty ? "정보 없음" : during
        introductionImages.enumerated().forEach { index, str in

            if let url = URL(string: str) {
                introductionImageViews[index].kf.indicatorType = .activity
                introductionImageViews[index].kf.setImage(with: url) { result in
                    switch result {
                    case .success(let value):
                        let ratio = value.image.size.width / value.image.size.height
                        let newHeight = self.introductionImageViews[index].frame.width / ratio
                        self.introductionImageViews[index].snp.remakeConstraints {
                            $0.height.equalTo(newHeight)
                        }
                    case .failure(let error):
                        print(error)
                    }
                    
                }
                
                introductionImageViews[index].isHidden = false
            } else {
                introductionImageViews[index].isHidden = true
            }
        }
        
        
    }
    
    
    func showTimeToDict(showTiems: [ProductDetailShowTime]) -> [String] {
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
