//
//  PartyMemberViewController.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/07/07.
//

import UIKit

import SnapKit

final class PartyMemberViewController: UIViewController {
    
    // MARK: - UI properties
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "파티원 모집"
        label.font = .heading1
        return label
    }()
    
    private let cardStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 0
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private let productView: UIView = {
        let view = UIView()
        view.backgroundColor = .pointColor1
        view.layer.cornerRadius = 10
        return view
    }()
    
    private let productTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "공연 관람"
        label.font = .heading2
        label.textColor = .white
        return label
    }()
    
    private let productDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "여럿이 함께 관람할 때\n더 즐거운 공연 관람!"
        label.font = .body5
        label.numberOfLines = 2
        label.textColor = .white
        return label
    }()
    
    private let productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: ImageNamespace.partymemberProductCardSymbol)
        return imageView
    }()
    
    private let productButton: UIButton = {
        let button = UIButton()
        button.tag = 0
        return button
    }()
    
    private let foodView: UIView = {
        let view = UIView()
        view.backgroundColor = .pointColor1
        view.layer.cornerRadius = 10
        
        return view
    }()
    
    private let foodTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "식사/카페"
        label.font = .heading2
        label.textColor = .white
        return label
    }()
    
    private let foodDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "공연 전후에 근처 맛집이나 카페에서 관심있는 공연 혹은 배우에 관한 이야기를 나눌 수 있어요!"
        label.font = .body5
        label.numberOfLines = 3
        label.textColor = .white
        return label
    }()
    
    private let foodImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: ImageNamespace.partymemberProductFoodSymbol)
        return imageView
    }()
    
    private let foodButton: UIButton = {
        let button = UIButton()
        button.tag = 1
        return button
    }()
    
    private let otherView: UIView = {
        let view = UIView()
        view.backgroundColor = .pointColor1
        view.layer.cornerRadius = 10
        return view
    }()
    
    private let otherTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "기타"
        label.font = .heading2
        label.textColor = .white
        return label
    }()
    
    private let otherDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "이벤트, 굿즈 제작 등 자유롭게\n파티원들을 모집할 수 있어요!"
        label.font = .body5
        label.numberOfLines = 2
        label.textColor = .white
        return label
    }()
    
    private let otherImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: ImageNamespace.partymemberProductOtherSymbol)
        return imageView
    }()
    private let otherButton: UIButton = {
        let button = UIButton()
        button.tag = 2
        return button
    }()
    
    // MARK: - Properties
    
    // MARK: - Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        addTargets()
        view.layoutIfNeeded()
        drawViewDotLine(view: productView)
        drawViewDotLine(view: foodView)
    }
    
    // MARK: - Helpers
    
    private func configureUI() {
        configureSubviews()
        configureConstraints()
        
    }
    
    private func configureSubviews() {
        view.addSubviews(titleLabel, cardStackView)
        cardStackView.addArrangedSubviews(productView, foodView, otherView)
        productView.addSubviews(
            productTitleLabel, productDescriptionLabel, productImageView, productButton
        )
        foodView.addSubviews(foodTitleLabel, foodDescriptionLabel, foodImageView, foodButton)
        otherView.addSubviews(otherTitleLabel, otherDescriptionLabel, otherImageView, otherButton)
    }
    
    private func configureConstraints() {
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(46)
            $0.leading.equalToSuperview().offset(24)
        }
        cardStackView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(18)
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.bottom.equalToSuperview().offset(-120)
        }
        productTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(30)
            $0.leading.equalToSuperview().offset(24)
        }
        productDescriptionLabel.snp.makeConstraints {
            $0.top.equalTo(productTitleLabel.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(24)
        }
        productImageView.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(30)
            $0.trailing.equalToSuperview().inset(15)
        }
        productButton.snp.makeConstraints { $0.edges.equalToSuperview() }
        foodTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(30)
            $0.leading.equalToSuperview().offset(24)
        }
        foodDescriptionLabel.snp.makeConstraints {
            $0.top.equalTo(foodTitleLabel.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(24)
            $0.trailing.equalToSuperview().inset(120)
        }
        foodImageView.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(28)
            $0.trailing.equalToSuperview().inset(41)
        }
        foodButton.snp.makeConstraints { $0.edges.equalToSuperview() }
        otherTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(30)
            $0.leading.equalToSuperview().offset(24)
        }
        otherDescriptionLabel.snp.makeConstraints {
            $0.top.equalTo(otherTitleLabel.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(24)
        }
        otherImageView.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(36)
            $0.trailing.equalToSuperview().inset(35)
        }
        otherButton.snp.makeConstraints { $0.edges.equalToSuperview() }
    }
    
    private func addTargets() {
        [productButton, foodButton, otherButton].forEach {
            $0.addTarget(self, action: #selector(cardViewTapped), for: .touchUpInside)
        }
    }
    
    func drawViewDotLine(view: UIView) {
        let layer = CAShapeLayer()
        layer.strokeColor = UIColor.white.cgColor
        layer.lineDashPattern = [10, 10]
             
        let path = UIBezierPath()
        let point1 = CGPoint(x: view.bounds.minX, y: view.bounds.maxY - 20)
        let point2 = CGPoint(x: view.bounds.maxX, y: view.bounds.maxY - 20)
        
        path.move(to: point1)
        path.addLine(to: point2)
             
        layer.path = path.cgPath
        
        view.layer.addSublayer(layer)
    }
    
    // MARK: - Acions
    
    @objc
    private func cardViewTapped(_ sender: UIButton) {
        guard let partyType = PartyCategoryType(tag: sender.tag) else { return }
        moveToDetailViewController(type: partyType)
    }
    
    private func setDetailViewController(_ type: PartyCategoryType) -> UIViewController {
        switch type {
        case .etc:
            return PartyMemberOtherViewController(
                viewModel: PartyMemberOtherViewModel(
                ))
        default:
            return PartyMemberProductViewController(
                partyType: type,
                viewModel: PartyMemberProductViewModel()
            )
        }
    }
    
    private func moveToDetailViewController(type: PartyCategoryType) {
        let detailViewController = UINavigationController(
            rootViewController: setDetailViewController(type)
        )
        detailViewController.modalPresentationStyle = .fullScreen
        present(detailViewController, animated: true)
    }
    
}


