//
//  GuideSaleViewController.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/08/12.
//

import UIKit

final class GuideSaleViewController: UIViewController {
    
    // MARK: - UI properties
    
    @IBOutlet var numberLabels: [UILabel] = []
    @IBOutlet weak var scrollView: UIScrollView! {
        didSet {
//            scrollView.clipsToBounds = false
//            scrollView.layer.cornerRadius = 30
//            scrollView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]

        }
    }
    
//    private let titleLabel: UILabel = {
//        let label = UILabel()
//        label.font = .subTitle1
//        label.textColor = .title
//        label.text = "🎁  할인 꿀팁"
//        return label
//    }()
//
//    private lazy var scrollView: UIScrollView = {
//        let scrollView = UIScrollView()
//        scrollView.layer.cornerRadius = 30
//        scrollView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
//        scrollView.contentInset = .init(top: 0, left: 0, bottom: 90, right: 0)
//        return scrollView
//    }()
//
//    private let contentView: UIView = UIView()
    
    // MARK: - Properties
    
    // MARK: - Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .hexF5F6F8
        configureNavigation()
        numberLabels.forEach {
            $0.layer.cornerRadius = 12.5
            $0.clipsToBounds = true
        }
        scrollView.backgroundColor = .white
        scrollView.layer.cornerRadius = 30
        scrollView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    // MARK: - Helpers
    
//    private func configureUI() {
//        configureSubviews()
//        configureConstraints()
//        configureNavigation()
//    }
//
//    private func configureSubviews() {
//        view.addSubviews(titleLabel, scrollView)
//        scrollView.addSubview(contentView)
//    }
//
//    private func configureConstraints() {
//        titleLabel.snp.makeConstraints {
//            $0.top.equalTo(view.safeAreaLayoutGuide).offset(30)
//            $0.left.equalToSuperview().offset(24)
//        }
//        scrollView.snp.makeConstraints {
//            $0.top.equalTo(titleLabel.snp.bottom).offset(15)
//            $0.left.right.bottom.equalToSuperview()
//        }
//        contentView.snp.makeConstraints {
//            $0.edges.equalTo(scrollView.contentLayoutGuide)
//            $0.width.equalTo(scrollView.frameLayoutGuide)
//        }
//
//    }
    
    private func configureNavigation() {
        configureBackbarButton()
        title = "입문자를 위한 연뮤 가이드"
    }
}
