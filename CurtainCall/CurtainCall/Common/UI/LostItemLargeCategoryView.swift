//
//  LostItemLargeCategoryView.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/07/31.
//

import UIKit

final class LostItemLargeCategoryView: UIView {
    
    // MARK: UI Property
    
    private let wholeStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 26
        return stackView
    }()
    
    private let imageStackView1: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 49
        return stackView
    }()
    
    private let bagView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let bagImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: ImageNamespace.lostItemCategoryBag60px)
        return imageView
    }()
    
    private let bagLabel: UILabel = {
        let label = UILabel()
        label.font = .body1
        label.textColor = .hex161A20
        label.text = "가방"
        return label
    }()
    
    private let bagButton: UIButton = {
        let button = UIButton()
        button.tag = LostItemCategoryType.bag.rawValue
        return button
    }()
    
    private let walletView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let walletImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: ImageNamespace.lostItemCategoryWallet60px)
        return imageView
    }()
    
    private let walletLabel: UILabel = {
        let label = UILabel()
        label.font = .body1
        label.textColor = .hex161A20
        label.text = "지갑"
        return label
    }()
    
    private let walletButton: UIButton = {
        let button = UIButton()
        button.tag = LostItemCategoryType.wallet.rawValue
        return button
    }()
    
    private let cashView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let cashImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: ImageNamespace.lostItemCategoryCash60px)
        return imageView
    }()
    
    private let cashLabel: UILabel = {
        let label = UILabel()
        label.font = .body1
        label.textColor = .hex161A20
        label.text = "현금"
        return label
    }()
    
    private let cashButton: UIButton = {
        let button = UIButton()
        button.tag = LostItemCategoryType.cash.rawValue
        return button
    }()
    
    private let imageStackView2: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 49
        return stackView
    }()
    
    private let cardView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let cardImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: ImageNamespace.lostItemCategoryCard60px)
        return imageView
    }()
    
    private let cardLabel: UILabel = {
        let label = UILabel()
        label.font = .body1
        label.textColor = .hex161A20
        label.text = "카드"
        return label
    }()
    
    private let cardButton: UIButton = {
        let button = UIButton()
        button.tag = LostItemCategoryType.card.rawValue
        return button
    }()
    
    private let jewelView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let jewelImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: ImageNamespace.lostItemCategoryJewel60px)
        return imageView
    }()
    
    private let jewelLabel: UILabel = {
        let label = UILabel()
        label.font = .body1
        label.textColor = .hex161A20
        label.text = "귀금속"
        return label
    }()
    
    private let jewelButton: UIButton = {
        let button = UIButton()
        button.tag = LostItemCategoryType.jewel.rawValue
        return button
    }()
    
    private let phoneView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let phoneImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: ImageNamespace.lostItemCategoryPhone60px)
        return imageView
    }()
    
    private let phoneLabel: UILabel = {
        let label = UILabel()
        label.font = .body1
        label.textColor = .hex161A20
        label.text = "전자기기"
        return label
    }()
    
    private let phoneButton: UIButton = {
        let button = UIButton()
        button.tag = LostItemCategoryType.phone.rawValue
        return button
    }()
    
    private let imageStackView3: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 49
        return stackView
    }()
    
    private let bookView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let bookImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: ImageNamespace.lostItemCategoryBook60px)
        return imageView
    }()
    
    private let bookLabel: UILabel = {
        let label = UILabel()
        label.font = .body1
        label.textColor = .hex161A20
        label.text = "도서"
        return label
    }()
    
    private let bookButton: UIButton = {
        let button = UIButton()
        button.tag = LostItemCategoryType.book.rawValue
        return button
    }()
    
    private let clothesView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let clothesImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: ImageNamespace.lostItemCategoryClothes60px)
        return imageView
    }()
    
    private let clothesLabel: UILabel = {
        let label = UILabel()
        label.font = .body1
        label.textColor = .hex161A20
        label.text = "의류"
        return label
    }()
    
    private let clothesButton: UIButton = {
        let button = UIButton()
        button.tag = LostItemCategoryType.clothes.rawValue
        return button
    }()
    
    private let otherView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let otherImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: ImageNamespace.lostItemCategoryOther60px)
        return imageView
    }()
    
    private let otherLabel: UILabel = {
        let label = UILabel()
        label.font = .body1
        label.textColor = .hex161A20
        label.text = "기타"
        return label
    }()
    
    private let otherButton: UIButton = {
        let button = UIButton()
        button.tag = LostItemCategoryType.other.rawValue
        return button
    }()
    
    // MARK: Property
    
    weak var delegate: LostItemViewDelegate?
    
    // MARK: Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        setButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: Configure
    
    private func configureUI() {
        configureSubviews()
        configureConstarints()
    }
    
    private func configureSubviews() {
        backgroundColor = .white
        addSubviews(wholeStackView)
        wholeStackView.addArrangedSubviews(imageStackView1, imageStackView2, imageStackView3)
        imageStackView1.addArrangedSubviews(bagView, walletView, cashView)
        bagView.addSubviews(bagImageView, bagLabel, bagButton)
        walletView.addSubviews(walletImageView, walletLabel, walletButton)
        cashView.addSubviews(cashImageView, cashLabel, cashButton)
        
        imageStackView2.addArrangedSubviews(cardView, jewelView, phoneView)
        cardView.addSubviews(cardImageView, cardLabel, cardButton)
        jewelView.addSubviews(jewelImageView, jewelLabel, jewelButton)
        phoneView.addSubviews(phoneImageView, phoneLabel, phoneButton)
        
        imageStackView3.addArrangedSubviews(bookView, clothesView, otherView)
        bookView.addSubviews(bookImageView, bookLabel, bookButton)
        clothesView.addSubviews(clothesImageView, clothesLabel, clothesButton)
        otherView.addSubviews(otherImageView, otherLabel, otherButton)
    }
    
    private func configureConstarints() {
        wholeStackView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(24)
            $0.horizontalEdges.equalToSuperview().inset(30)
            $0.bottom.equalToSuperview().inset(20)
        }

        bagImageView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.width.equalTo(60)
        }
        bagLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(bagImageView.snp.bottom).offset(8)
            $0.bottom.equalToSuperview()
        }
        walletImageView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.width.equalTo(60)
        }
        walletLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(walletImageView.snp.bottom).offset(8)
            $0.bottom.equalToSuperview()
        }
        cashImageView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.width.equalTo(60)
        }
        cashLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(cashImageView.snp.bottom).offset(8)
            $0.bottom.equalToSuperview()
        }
        cardImageView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.width.equalTo(60)
        }
        cardLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(cardImageView.snp.bottom).offset(8)
            $0.bottom.equalToSuperview()
        }
        jewelImageView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.width.equalTo(60)
        }
        jewelLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(jewelImageView.snp.bottom).offset(8)
            $0.bottom.equalToSuperview()
        }
        phoneImageView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.width.equalTo(60)
        }
        phoneLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(phoneImageView.snp.bottom).offset(8)
            $0.bottom.equalToSuperview()
        }
        bookImageView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.width.equalTo(60)
        }
        bookLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(bookImageView.snp.bottom).offset(8)
            $0.bottom.equalToSuperview()
        }
        clothesImageView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.width.equalTo(60)
        }
        clothesLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(clothesImageView.snp.bottom).offset(8)
            $0.bottom.equalToSuperview()
        }
        otherImageView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.width.equalTo(60)
        }
        otherLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(otherImageView.snp.bottom).offset(8)
            $0.bottom.equalToSuperview()
        }
    }
    
    private func setButton() {
        [
            bagButton, walletButton, cashButton, cardButton, jewelButton, phoneButton,
            bookButton, clothesButton, otherButton
        ].forEach {
            $0.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
            $0.addTarget(self, action: #selector(categoryButtonTapped), for: .touchUpInside)
        }
    }
    
    @objc
    private func categoryButtonTapped(sender: UIButton) {
        delegate?.didTappedCategoryButton(
            categoryType: LostItemCategoryType(
                rawValue: sender.tag
            ) ?? .bag
        )
    }
}

protocol LostItemViewDelegate: AnyObject {
    func didTappedCategoryButton(categoryType: LostItemCategoryType)
}
