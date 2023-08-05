//
//  LostItemDetailViewController.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/08/05.
//

import UIKit

import UIKit

final class LostItemDetailViewController: UIViewController {
    
    // MARK: UI Property
    
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
        imageView.image = item.image
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
        label.text = item.name
        label.textColor = .white
        label.font = .subTitle4
        return label
    }()
    
    // MARK: Property
    
    private let item: LostItemInfo
    
    // MARK: Life Cycle
    
    init(item: LostItemInfo) {
        self.item = item
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .hexF5F6F8
        configureUI()

    }
    
    // MARK: Configure
    
    private func configureUI() {
        configureSubviews()
        cofigureConstraints()
        configureNavigation()
        
    }
    
    private func configureSubviews() {
        view.addSubviews(topView, midView)
        topView.addSubview(itemImageView)
        midView.addSubview(itemNameView)
        itemNameView.addSubview(itemNameLabel)
    }
    
    private func cofigureConstraints() {
        topView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
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
            $0.height.equalTo(270)
        }
        itemNameView.snp.makeConstraints {
            $0.top.equalTo(20)
            $0.leading.equalTo(24)
        }
        itemNameLabel.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview().inset(10)
            $0.horizontalEdges.equalToSuperview().inset(12)
        }
    }
    
    private func configureNavigation() {
        configureBackbarButton()
        title = "분실물 찾기"
    }
}
