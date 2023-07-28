//
//  ProductDetailMainViewController.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/07/27.
//

import UIKit

final class ProductDetailMainViewController: UIViewController {
    
    // MARK: - UI properties
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .white
        return scrollView
    }()
    
    private let contentView = UIView()
    
    private let headerView: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        return view
    }()
    
    private let buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private let detailButton: UIButton = {
        let button = UIButton()
        button.setTitle("상세정보", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    private let reviewButton: UIButton = {
        let button = UIButton()
        button.setTitle("리뷰", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    private let lostProductButton: UIButton = {
        let button = UIButton()
        button.setTitle("분실물", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    private let detailView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        return view
    }()
    
    private let reviewView: UIView = {
        let view = UIView()
        view.backgroundColor = .green
        return view
    }()
    
    private let lostProductView: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        return view
    }()
    
    private let detailInfoView = DetailInfoView()
    private let detailReviewView = DetailReviewView()
    
    // MARK: - Properties
    
    // MARK: - Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        addTarget()
        setupInfoView()
    }
    
    // MARK: - Helpers
    
    private func configureUI() {
        configureSubviews()
        configureConstraints()
    }
    
    private func configureSubviews() {
        view.addSubview(scrollView)
        scrollView.addSubviews(contentView)
        contentView.addSubviews(
            headerView, buttonStackView, detailInfoView,
            detailView, lostProductView, reviewView
        )
        buttonStackView.addArrangedSubviews(detailButton, reviewButton, lostProductButton)
    }
    
    private func configureConstraints() {
        scrollView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalToSuperview().offset(-120)
        }
        contentView.snp.makeConstraints {
            $0.edges.equalTo(scrollView.contentLayoutGuide)
            $0.width.equalTo(scrollView.frameLayoutGuide)
        }
        headerView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(1000)
        }
        buttonStackView.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.bottom).offset(10)
            $0.horizontalEdges.equalToSuperview()
        }
        
    }
    
    private func addTarget() {
        [detailButton, reviewButton, lostProductButton].forEach {
            $0.addTarget(self, action: #selector(subButtonTouchUpInside), for: .touchUpInside)
        }
    }
    
    @objc
    private func subButtonTouchUpInside(_ sender: UIButton) {
        switch sender {
        case detailButton:
            setupInfoView()
        case reviewButton:
            setupReviewView()
        case lostProductButton:
            print("lostButtonTapped")
        default:
            fatalError("Error: Not Button")
        }
    }
    
    private func setupInfoView() {
        contentView.addSubview(detailInfoView)
        detailReviewView.removeFromSuperview()
        
        detailInfoView.snp.makeConstraints {
            $0.top.equalTo(buttonStackView.snp.bottom).offset(50)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-20)
        }
    }
    
    private func setupReviewView() {
        contentView.addSubview(detailReviewView)
        
        detailInfoView.removeFromSuperview()
        
        detailReviewView.snp.makeConstraints {
            $0.top.equalTo(buttonStackView.snp.bottom).offset(50)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-20)
        }
    }
}
