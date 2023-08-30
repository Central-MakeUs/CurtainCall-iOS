//
//  MyFavoriteShowCell.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/08/30.
//
//
//import UIKit
//
//import SnapKit
//
//final class PartyProductCell: UICollectionViewCell {
//
//    // MARK: - UI properties
//
//    private let cardView: UIView = {
//        let view = UIView()
//        view.layer.cornerRadius = 12
//        view.backgroundColor = .white
//        return view
//    }()
//
//    private let productLabelView: UIView = {
//        let view = UIView()
//        view.backgroundColor = .white
//        view.layer.cornerRadius = 12
//        return view
//    }()
//
//    private let productTitleLabel: UILabel = {
//        let label = UILabel()
//        label.textColor = .title
//        label.font = .subTitle4
//        label.textAlignment = .center
//        return label
//    }()
//
//    private let profileImageView: UIImageView = {
//        let imageView = UIImageView()
//        imageView.layer.cornerRadius = 21
//        imageView.clipsToBounds = true
//        return imageView
//    }()
//
//    private let nicknameDateStackView: UIStackView = {
//        let stackView = UIStackView()
//        stackView.axis = .vertical
//        stackView.spacing = 2
//        return stackView
//    }()
//
//    private let nicknameLabel: UILabel = {
//        let label = UILabel()
//        label.font = .subTitle4
//        label.textColor = .black
//        return label
//    }()
//
//    private let dateLabel: UILabel = {
//        let label = UILabel()
//        label.textColor = .hexBEC2CA
//        label.font = .body5
//        return label
//    }()
//
//    private let countLabel: UILabel = {
//        let label = UILabel()
//        label.textColor = .title
//        label.font = .body4
//        return label
//    }()
//
//    private let titleLabel: UILabel = {
//        let label = UILabel()
//        label.textColor = .black
//        label.font = .body1
//        label.numberOfLines = 0
//        return label
//    }()
//
//    private let posterImageView: UIImageView = {
//        let imageView = UIImageView()
//        imageView.layer.cornerRadius = 10
//        imageView.clipsToBounds = true
//        return imageView
//    }()
//
//    private let dateBadgeView: UIView = {
//        let view = UIView()
//        view.backgroundColor = .hexF5F6F8
//        view.layer.cornerRadius = 4
//        return view
//    }()
//
//    private let dateBadgeImageView: UIImageView = {
//        let imageView = UIImageView()
//        imageView.image = UIImage(named: ImageNamespace.myPageDateSymbol)
//        return imageView
//    }()
//
//    private let dateBadgeLabel: UILabel = {
//        let label = UILabel()
//        label.font = .systemFont(ofSize: 12, weight: .medium)
//        label.textColor = .pointColor1
//        return label
//    }()
//
//    private let timeBadgeView: UIView = {
//        let view = UIView()
//        view.backgroundColor = .hexF5F6F8
//        view.layer.cornerRadius = 4
//        return view
//    }()
//
//    private let timeBadgeImageView: UIImageView = {
//        let imageView = UIImageView()
//        imageView.image = UIImage(named: ImageNamespace.myPageTimeSymbol)
//        return imageView
//    }()
//
//    private let timeBadgeLabel: UILabel = {
//        let label = UILabel()
//        label.font = .systemFont(ofSize: 12, weight: .medium)
//        label.textColor = .pointColor1
//        return label
//    }()
//
//    private let locationBadgeView: UIView = {
//        let view = UIView()
//        view.backgroundColor = .hexF5F6F8
//        view.layer.cornerRadius = 4
//        return view
//    }()
//
//    private let locationBadgeImageView: UIImageView = {
//        let imageView = UIImageView()
//        imageView.image = UIImage(named: ImageNamespace.myPageLocationSymbol)
//        return imageView
//    }()
//
//    private let locationBadgeLabel: UILabel = {
//        let label = UILabel()
//        label.font = .systemFont(ofSize: 12, weight: .medium)
//        label.textColor = .pointColor1
//        return label
//    }()
//
//    // MARK: - Properties
//
//    // MARK: - Lifecycles
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        configureUI()
//        clipsToBounds = true
//        layer.applySketchShadow(color: .black, alpha: 0.1, x: 0, y: 4, blur: 4, spread: 0)
//    }
//
//    @available(*, unavailable)
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    // MARK: - Helpers
//
//    private func configureUI() {
//        configureSubviews()
//        configureConstraints()
//        layoutIfNeeded()
//        drawViewDotLine(view: productLabelView)
//    }
//
//    private func configureSubviews() {
//        addSubviews(cardView, productLabelView)
//        cardView.addSubviews(
//            profileImageView, nicknameDateStackView, countLabel, titleLabel,
//            posterImageView, dateBadgeView, timeBadgeView, locationBadgeView
//        )
//        productLabelView.addSubview(productTitleLabel)
//        nicknameDateStackView.addArrangedSubviews(nicknameLabel, dateLabel)
//        dateBadgeView.addSubviews(dateBadgeImageView, dateBadgeLabel)
//        timeBadgeView.addSubviews(timeBadgeImageView, timeBadgeLabel)
//        locationBadgeView.addSubviews(locationBadgeImageView, locationBadgeLabel)
//    }
//
//    private func configureConstraints() {
//        productTitleLabel.snp.makeConstraints {
//            $0.horizontalEdges.equalToSuperview().inset(12)
//            $0.center.equalToSuperview()
//        }
//        productLabelView.snp.makeConstraints {
//            $0.leading.equalTo(cardView.snp.leading)
//            $0.trailing.equalTo(cardView.snp.trailing)
//            $0.top.equalToSuperview()
//            $0.height.equalTo(56)
//        }
//        cardView.snp.makeConstraints {
//            $0.horizontalEdges.equalToSuperview().inset(24)
//            $0.top.equalTo(productLabelView.snp.bottom)
//            $0.bottom.equalToSuperview()
//        }
//        profileImageView.snp.makeConstraints {
//            $0.top.equalToSuperview().offset(17)
//            $0.leading.equalToSuperview().offset(20)
//            $0.size.equalTo(42)
//        }
//        nicknameDateStackView.snp.makeConstraints {
//            $0.leading.equalTo(profileImageView.snp.trailing).offset(10)
//            $0.centerY.equalTo(profileImageView)
//        }
//        countLabel.snp.makeConstraints {
//            $0.bottom.equalToSuperview().inset(20)
//            $0.trailing.equalToSuperview().inset(20)
//        }
//        titleLabel.snp.makeConstraints {
//            $0.horizontalEdges.equalToSuperview().inset(20)
//            $0.top.equalTo(profileImageView.snp.bottom).offset(16)
//
//        }
//        posterImageView.snp.makeConstraints {
//            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
//            $0.leading.equalToSuperview().offset(20)
//            $0.height.equalTo(87)
//            $0.width.equalTo(66)
//            $0.bottom.equalToSuperview().inset(20)
//        }
//
//        dateBadgeImageView.snp.makeConstraints {
//            $0.centerY.equalToSuperview()
//            $0.leading.equalToSuperview().offset(6)
//        }
//
//        dateBadgeLabel.snp.makeConstraints {
//            $0.leading.equalTo(dateBadgeImageView.snp.trailing).offset(6)
//            $0.trailing.equalToSuperview().inset(6)
//            $0.centerY.equalToSuperview()
//        }
//        dateBadgeView.snp.makeConstraints {
//            $0.top.equalTo(posterImageView.snp.top)
//            $0.leading.equalTo(posterImageView.snp.trailing).offset(14)
//            $0.height.equalTo(23)
//        }
//        timeBadgeImageView.snp.makeConstraints {
//            $0.centerY.equalToSuperview()
//            $0.leading.equalToSuperview().offset(6)
//        }
//        timeBadgeLabel.snp.makeConstraints {
//            $0.leading.equalTo(timeBadgeImageView.snp.trailing).offset(6)
//            $0.trailing.equalToSuperview().inset(6)
//            $0.centerY.equalToSuperview()
//        }
//        timeBadgeView.snp.makeConstraints {
//            $0.top.equalTo(dateBadgeView.snp.bottom).offset(9)
//            $0.leading.equalTo(posterImageView.snp.trailing).offset(14)
//            $0.height.equalTo(23)
//        }
//
//        locationBadgeImageView.snp.makeConstraints {
//            $0.centerY.equalToSuperview()
//            $0.leading.equalToSuperview().offset(6)
//            $0.size.equalTo(16)
//        }
//
//        locationBadgeLabel.snp.makeConstraints {
//            $0.leading.equalTo(locationBadgeImageView.snp.trailing).offset(6)
//            $0.trailing.equalToSuperview().inset(6)
//            $0.centerY.equalToSuperview()
//        }
//        locationBadgeView.snp.makeConstraints {
//            $0.top.equalTo(timeBadgeView.snp.bottom).offset(9)
//            $0.leading.equalTo(posterImageView.snp.trailing).offset(14)
//            $0.trailing.lessThanOrEqualToSuperview().inset(50)
//            $0.height.equalTo(23)
//        }
//
//    }
//
//    func drawViewDotLine(view: UIView) {
//        let layer = CAShapeLayer()
//        layer.strokeColor = UIColor.hexE4E7EC?.cgColor
//        layer.lineDashPattern = [2, 2]
//
//        let path = UIBezierPath()
//        let point1 = CGPoint(x: view.bounds.minX, y: view.bounds.maxY)
//        let point2 = CGPoint(x: view.bounds.maxX, y: view.bounds.maxY)
//
//        path.move(to: point1)
//        path.addLine(to: point2)
//
//        layer.path = path.cgPath
//
//        view.layer.addSublayer(layer)
//    }
//
//    func setUI(_ item: PartyListContent) {
//        productTitleLabel.text = item.showName
//        if let urlString = item.creatorImageUrl, let url = URL(string: urlString) {
//            profileImageView.kf.setImage(with: url)
//        } else {
//            profileImageView.image = UIImage(named: ImageNamespace.defaultProfile)
//        }
//        nicknameLabel.text = item.creatorNickname
//        dateLabel.text = item.createdAt.convertAPIDateToDateString()
//        countLabel.text = "\(item.curMemberNum)/\(item.maxMemberNum)"
//        titleLabel.text = item.title
//        if let url = URL(string: item.showPoster ?? "") {
//            posterImageView.kf.setImage(with: url)
//        } else {
//            posterImageView.image = nil
//        }
//        dateBadgeLabel.text = item.showAt?.convertAPIDateToDateWeekString() ?? ""
//        timeBadgeLabel.text = item.showAt?.convertAPIDateToDateTime() ?? ""
//        locationBadgeLabel.text = item.facilityName
//    }
//}
