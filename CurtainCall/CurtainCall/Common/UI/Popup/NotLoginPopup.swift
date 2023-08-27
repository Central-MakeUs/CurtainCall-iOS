//
//  NotLoginPopup.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/08/27.
//

import UIKit

final class NotLoginPopup: UIViewController {
    
    // MARK: - UI properties
    
    private let popupView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.clipsToBounds = true
        view.layer.cornerRadius = 15
        view.layer.applySketchShadow(color: .black, alpha: 0.25, x: 0, y: 4, blur: 4, spread: 0)
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .subTitle2
        label.textColor = .title
        label.text = "로그인 후 이용할 수 있어요 :)"
        return label
    }()
    
    private let completeButton: UIButton = {
        let button = UIButton()
        button.setTitle("확인", for: .normal)
        button.backgroundColor = .pointColor2
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        return button
    }()
    
    // MARK: - Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        view.backgroundColor = .black.withAlphaComponent(0.36)
        addTargets()
    }
    
    // MARK: - Helpers
    
    private func configureUI() {
        configureSubviews()
        configureConstraints()
    }
    
    private func configureSubviews() {
        view.addSubview(popupView)
        popupView.addSubviews(titleLabel, completeButton)
    }
    
    private func configureConstraints() {
        popupView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(24)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(38)
            $0.centerX.equalToSuperview()
        }
        completeButton.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(34)
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.bottom.equalToSuperview().inset(20)
            $0.height.equalTo(46)
        }

    }
    
    private func addTargets() {
        completeButton.addTarget(
            self,
            action: #selector(completeButtonTouchUpInside),
            for: .touchUpInside
        )
    }
    
    @objc
    func completeButtonTouchUpInside() {
        dismiss(animated: false)
    }
    
}


